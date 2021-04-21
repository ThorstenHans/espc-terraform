data "http" "current_ip" {
  url = "https://api.my-ip.io/ip"
}

data "azurerm_key_vault_secret" "sql_admin_pwd" {
  key_vault_id = var.keyvault_id
  name         = "sql-admin-pwd"
}

data "azurerm_key_vault_secret" "sql_pwd" {
  key_vault_id = var.keyvault_id
  name         = "sql-pwd"
}

resource "azurerm_sql_server" "sqlazure" {
  name                = "sql-azure-espc-2021"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  version                      = "12.0"
  administrator_login          = "espcsqladmin"
  administrator_login_password = data.azurerm_key_vault_secret.sql_admin_pwd.value

  tags = local.tags
}

resource "azurerm_sql_firewall_rule" "sqlallowazureresources" {
  name                = "sqlallowazureresourcesrule"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.sqlazure.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_sql_firewall_rule" "sqlallowtfhost" {
  name                = "sqlfirewall-${random_integer.env.result}"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.sqlazure.name
  start_ip_address    = chomp(data.http.current_ip.body)
  end_ip_address      = chomp(data.http.current_ip.body)
}

resource "azurerm_sql_database" "db" {
  name                             = "sql-db-espc"
  resource_group_name              = azurerm_resource_group.rg.name
  location                         = var.location
  server_name                      = azurerm_sql_server.sqlazure.name
  edition                          = var.admin_db_config.edition
  requested_service_objective_name = var.admin_db_config.size

  tags = local.Tags

  depends_on = [azurerm_sql_firewall_rule.sqlallowtfhost]

  provisioner "local-exec" {
    command = "./scripts/create_sql_azure_db_user.sh"
    environment = {
      RESOURCE_GROUP_NAME          = azurerm_resource_group.rg.name
      SQL_AZURE_SERVER_NAME        = azurerm_sql_server.sqlazure.name
      SQL_AZURE_FQDN               = azurerm_sql_server.sqlazure.fully_qualified_domain_name
      SQL_AZURE_DB_NAME            = azurerm_sql_database.db.name
      SQL_AZURE_ADMIN_USER         = azurerm_sql_server.sqlazure.administrator_login
      SQL_AZURE_ADMIN_PASSWORD     = data.azurerm_key_vault_secret.sql_admin_pwd.value
      SQL_AZURE_USER_NAME          = "espcuser"
      SQL_AZURE_USER_PASSWORD      = data.azurerm_key_vault_secret.sql_pwd.value
      SQL_AZURE_FIREWALL_RULE_NAME = azurerm_sql_firewall_rule.sqlallowtfhost.name
    }
    on_failure = fail
  }
}
