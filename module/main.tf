resource "azurerm_resource_group" "main" {

    count = var.enabled == true ? 1 : 0

    name     = var.namespace
    location = var.location

    tags = var.tags

}

resource "azurerm_virtual_network" "main" {
  
    count = var.enabled == true ? lookup(var.vnet, "number_of_vnets") : 0

    name                = "${var.namespace}-${sum([count.index, 1])}"
    location            = join("", azurerm_resource_group.main.*.location)
    resource_group_name = join("", azurerm_resource_group.main.*.name)

    address_space       = element(lookup(var.vnet, "address_spaces"), count.index)
    dns_servers         = var.dns_servers

    dynamic "ddos_protection_plan" {

        for_each = var.ddos_protection == true ? [ "1" ] : []

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
