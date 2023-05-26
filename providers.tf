terraform {
  backend "azurerm" {
    resource_group_name  = "tfstateresourcegroup"
    storage_account_name = "tfstate"
    container_name       = "tfstate"
    key                  = "devlatestnew.terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
}
