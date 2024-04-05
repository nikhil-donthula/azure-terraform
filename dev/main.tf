module "common" {
  source         = "../modules/common/"
  resource_group = var.resource_group
  location       = var.location
  environment    = var.environment
  tags           = var.tags

}

module "network" {
  source                          = "../modules/network/"
  resource_group                  = module.common.resource_group
  location                        = var.location
  environment                     = var.environment
  team                            = var.team
  vnet_address_space              = var.vnet_address_space
  public_subnet_address_prefixes  = var.public_subnet_address_prefixes
  private_subnet_address_prefixes = var.private_subnet_address_prefixes
  tags                            = var.tags

}

module "compute" {
  source         = "../modules/compute/"
  resource_group = module.common.resource_group
  location       = var.location
  environment    = var.environment
  team           = var.team
  tags           = var.tags
  vm_name        = var.vm_name
  private_subnet = module.network.private_subnet
  public_subnet  = module.network.public_subnet
}

module "frontend-compute" {
  source         = "../modules/compute/"
  resource_group = module.common.resource_group
  location       = var.location
  environment    = var.environment
  team           = var.team
  tags           = var.tags
  vm_name        = var.frontend_vm_name
  private_subnet = module.network.private_subnet
  public_subnet  = module.network.public_subnet
}

module "storage" {
  source         = "../modules/storage/"
  resource_group = module.common.resource_group
  location       = var.location
  environment    = var.environment
  team           = var.team
  tags           = var.tags
  vm_name        = var.vm_name
  private_subnet = module.network.private_subnet

}