terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.84.0"
      configuration_aliases = [ yandex.pvc ]
    }
  }
}


resource "yandex_vpc_network" "default" {
folder_id = var.folder_id 
  name = "foobar"
}
