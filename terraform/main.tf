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

module "aks" {
  source              = "./modules/aks"
  cluster_name        = "aks-${local.tags.project}"
  dns_prefix          = "weather"
  location            = local.location
  resource_group_name = local.resource_group_name
  environment         = local.environment
  tags                = local.tags

  enable_auto_scaling = true
  max_count           = 2
  min_count           = 1
  vm_size             = "Standard_B2s"
}

module "postgres" {
  source              = "./modules/postgresql"
  db_name             = "postgres-${local.tags.project}"
  resource_group_name = local.resource_group_name
  location            = local.location
  environment         = local.environment
  tags                = local.tags

  admin_username = var.db_user
  admin_password = var.db_pass
}

module "storage" {
  source               = "./modules/storage"
  storage_account_name = "stweatherapp"
  resource_group_name  = local.resource_group_name
  location             = local.location
  environment          = local.environment
  tags                 = local.tags

  container_name = "weather-app"
}

module "acr" {
  source              = "./modules/acr"
  acr_name            = "acrweatherapp"
  location            = local.location
  resource_group_name = local.resource_group_name
  tags                = local.tags
}
