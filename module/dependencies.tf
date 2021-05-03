# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group
data "azurerm_resource_group" "main" {

  count = var.resourcegroup_name != null ? 1 : 0

  name = var.resourcegroup_name

}