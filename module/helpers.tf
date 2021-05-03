# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "vnet_name" {

  count = var.enabled ? 1 : 0

  byte_length = 8

}