# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
resource "azurerm_public_ip" "main" {

  count = var.enabled && var.subnets_with_nat_gw != null ? 1 : 0

  name                = "${var.namespace}-publicip-${sum([count.index, 1])}"
  resource_group_name = join("", azurerm_resource_group.main.*.name)
  location            = join("", azurerm_resource_group.main.*.location)

  allocation_method       = var.public_ip_method
  sku                     = var.public_ip_sku
  ip_version              = var.public_ip_version
  idle_timeout_in_minutes = var.public_ip_idle_timeouts

  tags = var.tags

}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association
resource "azurerm_nat_gateway_public_ip_association" "main" {

  count = var.enabled && var.subnets_with_nat_gw != null ? 1 : 0

  nat_gateway_id       = join("", azurerm_nat_gateway.main.*.id)
  public_ip_address_id = join("", azurerm_public_ip.main.*.id)

}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association
resource "azurerm_subnet_nat_gateway_association" "main" {

  count = var.enabled && var.subnets_with_nat_gw != null ? length(var.subnets_with_nat_gw) : 0

  subnet_id      = azurerm_subnet.main[count.index].id
  nat_gateway_id = join("", azurerm_nat_gateway.main.*.id)

}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway
resource "azurerm_nat_gateway" "main" {

  count = var.enabled && var.subnets_with_nat_gw != null ? 1 : 0

  name                = "${var.namespace}-nat-gw-${sum([count.index, 1])}"
  resource_group_name = join("", azurerm_resource_group.main.*.name)
  location            = join("", azurerm_resource_group.main.*.location)

  sku_name = "Standard"

  tags = var.tags
}