module "dev" {
    source = "./modules/dev"
    providers = {
      yandex.dev = yandex.dev
     }
    cloud_id  = var.cloud_id
    folder_id_dev = var.folder_id_dev
}

module "prod" {
    source = "./modules/prod"
    providers = {
      yandex.prod = yandex.prod
     }
    cloud_id  = var.cloud_id
    folder_id_prod = var.folder_id_prod
}