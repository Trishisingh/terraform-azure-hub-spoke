locals {
  subnets = flatten([for name, network in var.network_details : [for subnet in network.subnet_details : {
    vnet               = name
    sub_name           = subnet.sub_name
    sub_address_prefix = subnet.sub_address_prefix

  }]])

  hub_network_name    = flatten([for name, network in var.network_details : name if network.is_hub == true])
  spoke_network_names = flatten([for name, network in var.network_details : name if network.is_hub == false])
}
