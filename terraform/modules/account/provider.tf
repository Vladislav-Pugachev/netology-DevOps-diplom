terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.84.0"
      configuration_aliases = [ yandex.account ]
    }
  }
}


provider "yandex" {
 alias = "account"
 token     = var.token
 cloud_id  = var.cloud_id
}