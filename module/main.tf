resource "azurerm_resource_group" "main" {

    count = var.enabled == true ? 1 : 0

    name     = "${var.namespace}-rg"
    location = var.location

    tags = var.tags

}

resource "azurerm_virutal_network" "main" {
  
    count = var.enabled == true ? 1 : 0

    name                = "${var.namespace}-vnet"
    location            = join("", azurerm_resource_group.main.*.location)
    resource_group_name = join("", azurerm_resource_group.main.*.name)

    address_space       = var.vnet_address_space
    dns_server          = var.dns_server

    ddos_protection_plan {
        id     = join("", azurerm_network_ddos_protection_plan.main.*.id)
        enable = var.ddos_protection
    }

    tags = var.tags

    depends_on = [
      azurerm_resource_group.main
    ]
}
