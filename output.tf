#output "subnet_id" {
#  value = { for i in azurerm_subnet.example : i.id => i }
#}

#output "hub_net_id" {
#  value = { for i in azurerm_virtual_network.example : i.id => i if network.is_hub == true }
#}
