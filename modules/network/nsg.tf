#Network security groups
#https://learn.microsoft.com/en-us/azure/api-management/api-management-using-with-internal-vnet?tabs=stv2

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.team}-${var.environment}-nsg"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name



  security_rule {
    name                         = "Management_endpoint_access"
    priority                     = 1011
    direction                    = "Inbound"
    access                       = "Allow"
    source_port_range            = "*"
    destination_port_ranges      = ["3443"]
    protocol                     = "Tcp"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "VirtualNetwork"
    description                  = "Management endpoint for Azure portal and PowerShell"
  }

  security_rule {
    name                         = "Azure_Key_Vault_access"
    priority                     = 1021
    direction                    = "Inbound"
    access                       = "Allow"
    source_port_range            = "*"
    destination_port_ranges      = ["443"]
    protocol                     = "Tcp"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureKeyVault"
    description                  = "Access to Azure Key Vault"
  }

  security_rule {
    name                         = "Azure_Storage_Access"
    priority                     = 1031
    direction                    = "Inbound"
    access                       = "Allow"
    source_port_range            = "*"
    destination_port_ranges      = ["443"]
    protocol                     = "Tcp"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "Storage"
    description                  = "Dependency on Azure Storage"
  }





  # security_rule {
  #   name                         = "Allow_snb-ind-per-12_port_22"
  #   priority                     = 1071
  #   direction                    = "Inbound"
  #   access                       = "Allow"
  #   protocol                     = "Tcp"
  #   source_port_range            = "*"
  #   destination_port_ranges      = ["22","3389"]
  #   source_address_prefixes      = ["20.198.103.194/32","20.237.211.156/32"]
  #   destination_address_prefixes = ["192.168.94.7/32","192.168.94.14"]
  #   description                  = "allow access to machine snb-ind-per-12"
  # }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "pri-subnet01" {
  subnet_id                 = azurerm_subnet.public-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "vnet-integrations01" {
  subnet_id                 = azurerm_subnet.private-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

