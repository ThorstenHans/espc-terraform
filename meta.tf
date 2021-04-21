provider "http" {}
provider "random" {}

provider "azurerm" {
  features {}
}

terraform {

  required_version = "=0.15.0"

  backend "azurerm" {
    resource_group_name  = "rg-espc-state-backend"
    storage_account_name = "saespc2021state"
    container_name       = "terraform-state"
    key                  = "espc2021.tfstate"
    use_azuread_auth     = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.55.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "= 3.1.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "= 2.1.0"
    }
  }
}
