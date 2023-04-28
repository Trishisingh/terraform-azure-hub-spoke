output "subnet_id" {
  value = { for i in azurerm_subnet.example : i.id => i }
}
