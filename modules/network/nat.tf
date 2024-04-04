#NAT gateway

resource "azurerm_public_ip" "public-ip" {
  name                = "${var.team}-${var.environment}-publicip"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
  idle_timeout_in_minutes = 4

  tags = var.tags

}

resource "azurerm_nat_gateway" "nat" {
  name                    = "${var.team}-${var.environment}-natgw01"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 4

  tags = var.tags


}

resource "azurerm_nat_gateway_public_ip_association" "ip-assoc" {
  nat_gateway_id       = azurerm_nat_gateway.nat.id
  public_ip_address_id = azurerm_public_ip.public-ip.id


}

# resource "azurerm_subnet_nat_gateway_association" "public-subnet" {
#   subnet_id      = azurerm_subnet.public-subnet.id
#   nat_gateway_id = azurerm_nat_gateway.nat.id
# }

resource "azurerm_subnet_nat_gateway_association" "private-subnet" {
  subnet_id      = azurerm_subnet.private-subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}
