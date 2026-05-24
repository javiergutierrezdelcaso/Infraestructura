terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatejavier"
    container_name       = "tfstate"
    key                  = "pro.tfstate"
  }
}
