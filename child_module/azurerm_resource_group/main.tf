resource "azurerm_resource_group" "rg-demo" {
  name     = var.name
  location = var.location
}