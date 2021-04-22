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
  sku                 = var.use_premium ? "Premium" : "Standard"
  admin_enabled       = false
  
}

variable "acr_name" {
  type    = string
  default = "The name of the ACR instance"
}

variable "rg_name" {
  type    = string
  default = "The name of the Resource Group"
}

variable "use_premium" {
  type        = bool
  default     = false
  description = "Choose to provision a premium SKU"
}
