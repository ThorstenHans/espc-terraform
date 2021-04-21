variable "location" {
  type    = string
  default = "germanywestcentral"
  validation {
    condition     = contains(["eastus2", "germanywestcentral", "westeurope"], var.location)
    error_message = "Please use one of the following regions (germanywestcentral|eastus2|westeurope)."
  }
  description = "Default location for all Azure resources"
}

variable "custom_tags" {
  type        = map(any)
  default     = {}
  description = "Custom Azure Tags associated with every resource"
}


