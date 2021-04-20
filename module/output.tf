output "resource_group_name" {

    value = var.resourcegroup == null ? azurerm_resource_group.main[0].name : var.resourcegroup
  
}