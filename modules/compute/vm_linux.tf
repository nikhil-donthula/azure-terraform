resource "azurerm_public_ip" "vm-public-ip" {
  name                = "${var.team}-${var.environment}-vm-public-ip"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
  
  tags = var.tags
}

resource "azurerm_network_interface" "vm-network-interface" {
  name                = "${var.team}-${var.environment}-netw-interf"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.private_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vm-public-ip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${var.vm_name}-${var.team}-${var.environment}-githr"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  size                = "Standard_B1s"
  disable_password_authentication = false
  admin_username      = "nikhil"
  admin_password      = "Passw0rd@123"
  network_interface_ids = [
    azurerm_network_interface.vm-network-interface.id,
  ]

  # encryption_at_host_enabled = "true"

  os_disk {
    name                 = "${var.vm_name}-${var.team}-${var.environment}-os-disk"
    caching              = "ReadWrite"
    disk_size_gb         = "64"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  identity {
    type      = "SystemAssigned"
  }
  tags = var.tags
}
