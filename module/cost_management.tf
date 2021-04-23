resource "azurerm_storage_account" "cost_management" {

  count = var.cost_management == true ? 1 : 0

  name                = "costmanagement123"
  resource_group_name = join("", azurerm_resource_group.main.*.name)
  location            = join("", azurerm_resource_group.main.*.location)

  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [
    azurerm_resource_group.main
  ]

  tags = var.tags
}

resource "azurerm_cost_management_export_resource_group" "main" {

  count = var.cost_management == true ? 1 : 0

  name              = "costmanagement"
  resource_group_id = join("", azurerm_resource_group.main.*.id)

  recurrence_type         = var.cm_recurrence_type
  recurrence_period_start = var.cm_recurrence_period_start
  recurrence_period_end   = var.cm_recurrence_period_end

  delivery_info {
    storage_account_id = join("", azurerm_storage_account.cost_management.*.id)
    container_name     = "costexport"
    root_folder_path   = "root/updated"
  }

  query {
    type       = "Usage"
    time_frame = "WeekToDate"
  }

  depends_on = [
    azurerm_storage_account.cost_management,
    azurerm_resource_group.main
  ]

}

# TODO