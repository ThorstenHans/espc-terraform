provider "azurerm" {
  features {}
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.55.0"
    }
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.rg_name
  location            = var.location
  admin_enabled       = false
  sku                 = var.premium ? "Premium" : "Standard"
}


variable "acr_name" {
  type        = string
  description = "ACR Name"
}

variable "premium" {
  type        = bool
  description = "Premium?"
}

variable "rg_name" {
  type        = string
  description = "RG Name"
}

variable "location" {
  type        = string
  description = "location"
}
