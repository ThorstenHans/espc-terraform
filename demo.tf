module "myacr" {
  source = "./components/acr"

  acr_name = "espc2021demo"
  rg_name  = azurerm_resource_group.rg.name
  location = var.location
  premium  = false
}
