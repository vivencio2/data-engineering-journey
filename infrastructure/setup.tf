terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "0016cc42-e680-4d66-b4bc-7919432b6c00"
}

resource "azurerm_resource_group" "group-continuous-learner" {
  name     = "rg-de-continuous-learner"
  location = "West Europe"
}

resource "azurerm_data_factory" "continuous-learner" {
  name                = "df-continuous-learner"
  location            = azurerm_resource_group.group-continuous-learner.location
  resource_group_name = azurerm_resource_group.group-continuous-learner.name
}

resource "azurerm_storage_account" "lake-continuous-learner" {
  name                     = "dlcontinuouslearner"
  resource_group_name      = azurerm_resource_group.group-continuous-learner.name
  location                 = azurerm_resource_group.group-continuous-learner.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}
