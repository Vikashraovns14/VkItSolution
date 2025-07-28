module "rg_demo" {
  source = "../CHILD MODULE/azurerm_resource_group"
  name     = "rg-demo"
  location = "West us"
}

module "vnet" {
    source = "../CHILD MODULE/azurerm_virtual_network"
    depends_on = [ module.rg_demo ]
    name                = "vnet-demo"
    location            = "West Europe"
    resource_group_name =  "rg-demo"
    address_space       = ["10.0.0.0/16"]
  
}

module "demo_subnet1" {
    source = "../CHILD MODULE/azurerm_subnet"
    depends_on = [ module.vnet ]
    name                 = "fronted-subnet"
    resource_group_name  = "rg-demo"
    virtual_network_name = "vnet-demo"
    address_prefixes       = ["10.0.1.0/24"]
  
}

# module "demo_subnet2" {
#     source = "../CHILD MODULE/azurerm_subnet"
#     depends_on = [ module.vnet ]
#     name                 = "backend-subnet"
#     resource_group_name  = "rg-demo"
#     virtual_network_name = "vnet-demo"
#     address_prefixes       = ["10.0.2.0/24"]
  
# }

module "pip" {
  source = "../CHILD MODULE/azurerm_public_ip"
  depends_on = [ module.rg_demo ]
    name                = "pip-demo"
    resource_group_name = "rg-demo"
    location            = "West Europe"
    allocation_method   = "Static"
}

module "frontend_vm" {
  depends_on = [module.demo_subnet1]
source = "../CHILD MODULE/azurerm_virtual_machine"
  resource_group_name  = "rg-demo"
  location             = "West Europe"
  name              = "vm-frontend"
  size              = "Standard_B1s"
  admin_username       = "devopsadmin"
  admin_password       = "Test@1234567"
  publisher      = "Canonical"
  offer          = "0001-com-ubuntu-server-focal"
  sku            = "20_04-lts"
  image_version = "latest"
  nic_name             = "nic-vm-frontend"
#   frontend_ip_name     = "pip-demo"
#   vnet_name            = "vnet-demo"
#   frontend_subnet_name = "frontend-subnet"
}

module "sql_server" {
  source              = "../CHILD MODULE/azurerm_sql_server"
  depends_on = [ module.rg_demo ]
  sql_server_name     = "todosqlserver005"
  resource_group_name = "rg-demo"
  location            ="West us"
  # secret ko rakhne ka sudhar - Azure Key Vault
  administrator_login          = "sqladmin"
  administrator_login_password = "Test@1234567"
}

# data "azurerm_mssql_server" "sql_server" {
#   name                = "my-sql-server"
#   resource_group_name = "my-resource-group"
# }

# module "sql_database" {
#   source         = "../CHILD MODULE/azurerm_database"
#   sql_database_name = "todosqldatabase008"
#   sql_server_id  = data.azurerm_mssql_server.sql_server.id
# }