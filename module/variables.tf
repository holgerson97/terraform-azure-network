variable "enabled" {

    default = true
      
}

variable "namespace" {

    default = "test-ns"
  
}

variable "location" {}

variable "vnet_address_spaces" {

    description = "Virtual network address space."

    type = list(string)

    sensitive = false

}

variable "subnet_address_spaces" {

    description = "List of subnet address spaces"

    type = list(string)

    sensitive = false

}

variable "dns_servers" {

    description = "List of DNS servers."

    type = list(string)

    sensitive = false

}

variable "vm_protection" {

    description = "Enables protection for VMs inside the virtual network."

    type = bool
    default = false

    sensitive = false
  
}

variable "ddos_protection" {

    description = "Enables DDOS protection for the virtual network."

    type = bool
    default = false

    sensitive = false
  
}

variable "subnets_with_nat_gw" {

    description = "Subnets that are attached to NAT gateways."

    type    = list(string)
    default = null

    sensitive = false

}

variable "public_ip_method" {

    description = "Specify allocation mehtod for NAT gateways."

    type = string
    default = "Static"

    sensitive = false
  
}

variable "public_ip_sku" {

    description = "Specify SKU for public ip addresses."

    type    = string
    default = "Standard"

    sensitive = false
  
}

variable "public_ip_version" {

    description = "IP version of public IP addresses."

    type = string
    default = "IPv4"

    sensitive = false
  
}

variable "public_ip_idle_timeouts" {

    description = "Specify TCP idle timouts for public ips."

    type = number
    default = 5

    sensitive = false
  
}

variable "cost_management" {

    description = "If true will create resource to export cost managemnet for this resource group."
    type = bool
    default = false

    sensitive = false
  
}

variable "cm_recurrence_type" {

    description = "Set how the costs for the resource group should be exported."

    type = string
    default = "Monthly"
    
    sensitive = false

    #TODO add validation

}

variable "cm_recurrence_period_start" {

    description = "Set the date when to start the recurrence period."

    type = string
    default = "2021-05-01T00:00:00Z"
    
    sensitive = false

    #TODO add validation

}

variable "cm_recurrence_period_end" {

    description = "Set the date when to end the recurrence period."

    type = string
    default = "2021-05-01T00:00:00Z"
    
    sensitive = false

    # TODO add validation

}

variable "tags" {

    description = "Add tags to your resources."

    type   = map
    default = null

    sensitive = false
  
}
