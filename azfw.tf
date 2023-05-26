

resource "azurerm_subnet" "az_fw_subnet" {
  count                = var.create_hub_fw ? 1 : 0
  name                 = "AzureFirewallSubnet"
  resource_group_name  = local.hub_resource_group_name[0]
  virtual_network_name = local.hub_network_name[0]
  address_prefixes     = var.hub_fw_address_prefixes
  depends_on           = [azurerm_resource_group.network, azurerm_virtual_network.example]
}

resource "azurerm_public_ip" "example" {
  count               = var.create_fw_public_ip && var.create_hub_fw ? 1 : 0
  name                = var.fw_public_ip_name
  location            = var.resource_group_location
  resource_group_name = local.hub_resource_group_name[0]
  allocation_method   = var.fw_public_allocation_method
  sku                 = var.fw_public_ip_sku
  tags                = var.tags
  depends_on          = [azurerm_resource_group.network, azurerm_virtual_network.example]
}

resource "azurerm_firewall" "example" {
  count               = var.create_fw_public_ip && var.create_hub_fw ? 1 : 0
  name                = var.name_az_fw
  location            = var.resource_group_location
  resource_group_name = local.hub_resource_group_name[0]
  sku_name            = var.sku_az_fw
  sku_tier            = var.sku_tier_az_fw
  tags                = var.tags

  dynamic "ip_configuration" {

    for_each = var.sku_az_fw == "AZFW_VNet" ? toset([1]) : toset([])
    content {
      name                 = var.ip_config_name_az_fw
      subnet_id            = azurerm_subnet.az_fw_subnet[0].id
      public_ip_address_id = azurerm_public_ip.example[0].id
    }

  }

  dynamic "virtual_hub" {

    for_each = var.sku_az_fw == "AZFW_Hub" ? toset([1]) : toset([])
    content {
      virtual_hub_id = azurerm_virtual_network.example["${local.hub_network_name[0]}"].id
    }

  }
  depends_on = [azurerm_resource_group.network, azurerm_virtual_network.example]

}
