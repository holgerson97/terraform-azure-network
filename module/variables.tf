variable "vnet_address_space" {

    description = "Adress space of your virtual network."

    type = list(string)
    default = [ "10.10.0.0/16" ]

    sensitive = false
  
}

variable "cost_management" {

    description = "If true will create resource to export cost managemnet for this resource group."
    type = bool
    default = false

    sensitive = false
  
}

variable "ddos_protection" {

    description = "If true will create a DDOS portection plan for your virtual network in your ressource group. "

    type = bool
    default = false

    sensitive = false
  
}

variable "dns_servers" {

    description = "Specify list of DNS servers, that are going to be used inside your virtual network."

    type = list(string)
    default = null

    sensitive = false
  
}

variable "vm_protection" {

    description = "Enables protection of vms inside this virtual network."

    type = bool
    default = false
    
    sensitive = false
  
}