terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.84.0"
      configuration_aliases = [ yandex.pvc ]
    }
  }
}

provider "yandex" {
  alias = "pvc"
  cloud_id  = var.cloud_id
  service_account_key_file = data.local_file.key-json.content
  folder_id= data.yandex_resourcemanager_folder.folder.id
}

resource "yandex_vpc_network" "default" {
  name = "foobar"
}

data "yandex_resourcemanager_folder" "folder" {
    name     = "folder-${terraform.workspace}"
  cloud_id = var.cloud_id
}

data "local_file" "key-json" {
    filename = "./key.json"
}