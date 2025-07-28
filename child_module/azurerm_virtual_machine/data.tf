# data "azurerm_subnet" "subnet" {
#   name                 = "frontend-subnet"
#   virtual_network_name = "vnet-demo"
#   resource_group_name  = "rg-demo"
# }
# data "azurerm_public_ip" "pip" {
#   name                = "pip-demo"
#   resource_group_name = "rg-demo"
# }