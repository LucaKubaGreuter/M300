terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.70.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

locals {
  resource_group_name = "rg-lucgr-001"
  location            = "northeurope"
  environment         = "dev"
  tags = {
    project     = "weather-app"
    environment = local.environment
  }
}

module "vm" {
  source              = "./modules/vm"
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  vm_name        = "weather-vm"
  admin_username = var.vm_admin_user
  ssh_public_key = file("~/.ssh/id_rsa.pub")
}

module "storage" {
  source               = "./modules/storage"
  storage_account_name = "stweatherapp"
  resource_group_name  = local.resource_group_name
  location             = local.location
  environment          = local.environment
  tags                 = local.tags

  container_names = ["weather-app", "backup"]
}
