resource "azurerm_application_insights" "ai" {
  name                = "ai-espc-2021"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  application_type = "web"

  tags = local.tags
}
