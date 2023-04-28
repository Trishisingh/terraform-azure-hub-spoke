locals {
  subnets = flatten([for name, network in var.network_details : [for subnet in network.subnet_details : {
    vnet               = name
    sub_name           = subnet.sub_name
    sub_address_prefix = subnet.sub_address_prefix

  }]])
}
