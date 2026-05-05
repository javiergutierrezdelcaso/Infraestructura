terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }

  cloud {
    organization = "TU_ORG_TERRAFORM"

    workspaces {
      name = "ecoanalyzer-infra"
    }
  }
}

provider "azurerm" {
  features {}
}
