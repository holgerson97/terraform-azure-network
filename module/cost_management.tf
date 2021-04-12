resource "azurerm_storage_account" "cost_management" {

    count = var.cost_management == true ? 1 : 0

    depends_on = [
        azurerm_resource_group.main
    ]
}

resource "azurerm_cost_management_export_resource_group" "main" {

    count = var.cost_management == true ? 1 : 0

    depends_on = [
        azurerm_resource_group.main
    ]

}