resource "azurerm_resource_group" "main" {

    count = var.enabled ? 1 : 0

    name     = var.namespace
    location = var.location

    tags = var.tags

}

resource "azurerm_virtual_network" "main" {
  
    count = var.enabled ? 1 : 0

    name                  = "${var.namespace}-vnet"
    location              = join("", azurerm_resource_group.main.*.location)
    resource_group_name   = join("", azurerm_resource_group.main.*.name)

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

    depends_on = [
      azurerm_resource_group.main
    ]
}

resource "azurerm_subnet" "main" {

    count = var.enabled ? length(var.subnet_address_spaces) : 0

    name                 = "${var.namespace}-subnet-${sum([count.index, 1])}"
    resource_group_name  = join("", azurerm_resource_group.main.*.name)
    virtual_network_name = join("", azurerm_virtual_network.main.*.name)

    address_prefixes = tolist([element(var.subnet_address_spaces, count.index)])

    depends_on = [
      azurerm_virtual_network.main
    ]

}