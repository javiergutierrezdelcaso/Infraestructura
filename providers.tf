terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }

  cloud {
    organization = "ecoanalyzer-org"

    workspaces {
      name = "Infraestructura"
    }
  }
}

provider "azurerm" {
  features {}

  use_oidc        = true
  client_id       = var.client_id
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}
