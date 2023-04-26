terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.84.0"
      configuration_aliases = [ yandex.dev, yandex.prod ]
    }
  }
}