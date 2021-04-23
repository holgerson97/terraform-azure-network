resource "azurerm_network_ddos_protection_plan" "main" {

  count = var.enabled && var.ddos_protection ? 1 : 0

  name                = "${var.namespace}-ddos"
  location            = join("", azurerm_resource_group.main.*.location)
  resource_group_name = join("", azurerm_resource_group.main.*.name)

  depends_on = [
    azurerm_resource_group.main
  ]

}