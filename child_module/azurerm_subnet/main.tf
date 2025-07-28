resource "azurerm_subnet" "demo-subnet1" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes       = var.address_prefixes
}

resource "azurerm_subnet" "demo-subnet2" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes       = var.address_prefixes
}