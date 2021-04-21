resource "azurerm_resource_group" "rg" {
  name     = "rg-escp-online"
  location = var.location

  tags = local.tags
}
