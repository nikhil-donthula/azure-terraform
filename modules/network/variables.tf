variable "resource_group" {
  default     = "TFResourceGroup"
  description = "name of resource group"
}

variable "location" {
  default     = "eastus2"
  type        = string
  description = "region like West US or Central India"
}

variable "environment" {
  default     = "DEV"
  type        = string
  description = "env tag like prod, dev, UAT"
}

variable "team" {
    type = string
    description = "region like West US or Central India"
}

variable "tags" {
  
}

variable "vnet_address_space" {
    type = string
}

variable "public_subnet_address_prefixes" {
    type = string
}


variable "private_subnet_address_prefixes" {
    type = string
}
