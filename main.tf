resource "azurerm_resource_group" "rg" {
  name     = "rg-espc-online"
  location = var.location

  tags = local.tags
}
