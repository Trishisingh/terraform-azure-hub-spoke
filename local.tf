locals {
  subnets = flatten([for name, network in var.network_details : [for subnet in network.subnet_details : {
    vnet                                          = name
    resource_group_name                           = network.resource_group_name
    sub_name                                      = subnet.sub_name
    sub_address_prefix                            = subnet.sub_address_prefix
    private_endpoint_network_policies_enabled     = subnet.private_endpoint_network_policies_enabled
    private_link_service_network_policies_enabled = subnet.private_link_service_network_policies_enabled
    service_endpoints                             = subnet.service_endpoints
  }]])

  hub_network_name                        = flatten([for name, network in var.network_details : name if network.is_hub == true])
  spoke_network_names                     = flatten([for name, network in var.network_details : name if network.is_hub == false])
  spoke_network_names_resource_group_name = flatten([for name, network in var.network_details : { name = name, resource_group_name = network.resource_group_name } if network.is_hub == false])
  dns_link_networks                       = flatten([for name, network in var.network_details : name if network.link_to_private_dns == true])
  all_resource_group_name                 = flatten([for name, network in var.network_details : network.resource_group_name if network.link_to_private_dns == true])
  hub_resource_group_name                 = flatten([for name, network in var.network_details : network.resource_group_name if network.link_to_private_dns == true && network.is_hub == true])
}
