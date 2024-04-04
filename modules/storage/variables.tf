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
variable "vm_name" {
    type = string
    description = "vm name"
}

variable "tags" {
  
}
variable "private_subnet" {
    description = "private_subnet"
}
