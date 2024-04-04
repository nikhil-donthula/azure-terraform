resource "azurerm_virtual_network" "vnet" {
  name                = "${var.team}-${var.environment}-vnet"
  address_space       = [var.vnet_address_space]
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  tags = {
    environment = var.environment
    managed_by = "terraform"
    Team        = "${var.team}"
  }
}

resource "azurerm_subnet" "public-subnet" {
  name                 = "${var.environment}-public-subnet"
  resource_group_name = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.public_subnet_address_prefixes]

}

resource "azurerm_subnet" "private-subnet" {
  name                 = "${var.environment}-private-subnet"
  resource_group_name = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.private_subnet_address_prefixes]

  private_endpoint_network_policies_enabled = true
  private_link_service_network_policies_enabled = false

}