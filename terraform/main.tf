module "account" {
    source = "./modules/account"
    cloud_id = var.cloud_id
    token     = var.token
    providers = {
      yandex = yandex.account
    }
}

module "pvc" {
    source = "./modules/vpc"
    cloud_id  = var.cloud_id
    providers = {
       yandex = yandex.pvc
    }
}  

data "yandex_resourcemanager_folder" "folder" {
    name     = "folder-${terraform.workspace}"
  cloud_id = var.cloud_id
}

data "local_file" "key-json" {
    filename = "./key.json"
    depends_on = [
      module.account
    ]
}