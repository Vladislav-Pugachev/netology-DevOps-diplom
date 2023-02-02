terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.84.0"
    }
  }
}

provider "yandex" {
 token     = var.token
 cloud_id  = var.cloud_id
}
provider "yandex" {
  alias = "vpc"
  cloud_id  = var.cloud_id
  service_account_key_file = data.local_file.admin-resourse-cred-json.content
  folder_id= data.yandex_resourcemanager_folder.folder.id
}

provider "yandex" {
 alias = "account"
 token     = var.token
 cloud_id  = var.cloud_id
}