module "myacr" {
  source = "./components/acr"

  acr_name = "espconline2021"
  rg_name  = azurerm_resource_group.rg.name
}
