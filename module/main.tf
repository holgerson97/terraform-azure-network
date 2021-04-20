# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "main" {

    count = var.enabled && var.resourcegroup == null ? 1 : 0

    name     = var.namespace
    location = var.location

    tags = var.tags

}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "main" {
  
    count = var.enabled ? 1 : 0

    name                  = "${var.namespace}-vnet"
    location              = var.resourcegroup == null ? join("", azurerm_resource_group.main.*.location) : var.location
    resource_group_name   = var.resourcegroup == null ? join("", azurerm_resource_group.main.*.name) : var.resourcegroup

    address_space         = var.vnet_address_spaces
    dns_servers           = var.dns_servers
    vm_protection_enabled = var.vm_protection

    dynamic "ddos_protection_plan" {

        for_each = var.ddos_protection == false ? [] : [ 1 ]

        content {
            id     = join("", azurerm_network_ddos_protection_plan.main.*.id)
            enable = var.ddos_protection
        }
    }
 
    tags = var.tags

}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "main" {

    count = var.enabled ? length(var.subnet_address_spaces) : 0

    name                  = "${var.namespace}-subnet-${sum([count.index, 1])}"
    resource_group_name   = var.resourcegroup == null ? join("", azurerm_resource_group.main.*.name) : var.resourcegroup
    virtual_network_name  = join("", azurerm_virtual_network.main.*.name)

    address_prefixes = tolist([element(var.subnet_address_spaces, count.index)])

    #TODO Add delegations

    enforce_private_link_endpoint_network_policies = var.enforce_private_link_service_network_policies == true ? false : var.enforce_private_link_endpoint_network_policies
    enforce_private_link_service_network_policies  = var.enforce_private_link_endpoint_network_policies == true ? false : var.enforce_private_link_service_network_policies
    service_endpoints                              = var.service_endpoints
    service_endpoint_policy_ids                    = var.service_endpoint_policy_ids

}