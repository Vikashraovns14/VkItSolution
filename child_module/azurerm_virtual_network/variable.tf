variable "name" {
  description = "Virtual Network name"
  type        = string
}

variable "location" {
  description = "Location for the Virtual Network"
  type        = string          
}

variable "resource_group_name" {
  description = "Location for the Virtual Network"
  type        = string          
}

variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}