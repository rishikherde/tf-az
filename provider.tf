terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name = "tf-rg-24072"
    storage_account_name = "tfteststore123"
    container_name = "tfstatefile"
    key = "terraform.tfstate"
  }
}

provider "azurerm" {
    features {}

    client_id = var.azure_client_id
    client_secret = var.azure_client_secret
    subscription_id = var.azure_subscription_id
    tenant_id = var.azure_tenant_id
}