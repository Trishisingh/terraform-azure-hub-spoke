#output "subnet_id" {
#  value = { for i in azurerm_subnet.example : i.id => i }
#}

#output "hub_net_id" {
#  value = { for i in azurerm_virtual_network.example : i.id => i if network.is_hub == true }
#}

output "hub_net_name" {
  value = local.hub_network_name[0]
}

output "hub_net_id" {
  value = var.enable_private_networks == true ? azurerm_virtual_network.example["${local.hub_network_name[0]}"].id : null
}

output "subnet_ids" {
  value = var.enable_private_networks == true ? values(azurerm_subnet.example)[*].id : null
}

output "subnet_names" {
  value = values(azurerm_subnet.example)[*].name
}

output "subnets" {
  value = {
    for sub in azurerm_subnet.example :
    sub.name => ({
      vnet_names                 = sub.virtual_network_name
      id                         = sub.id
      address_prefixes           = sub.address_prefixes
      subnet_resource_group_name = sub.resource_group_name

    })


  }
}

output "vnets" {
  value = {
    for vnet in azurerm_virtual_network.example :
    vnet.name => ({
      vnet_id                  = vnet.id
      vnet_address_space       = vnet.address_space
      vnet_resource_group_name = vnet.resource_group_name

    })


  }
}

output "hub_firewall_id" {

  value = var.create_hub_fw ? azurerm_subnet.az_fw_subnet[0].id : null
}

output "hub_pub_ip" {

  value = var.create_fw_public_ip && var.create_hub_fw ? azurerm_public_ip.example[0].id : null
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.example[0].id
}
