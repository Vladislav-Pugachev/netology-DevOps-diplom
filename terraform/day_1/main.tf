module "dev" {
    count = terraform.workspace == "dev" ? 1 : 0
    source = "./modules/dev"
    providers = {
      yandex.dev = yandex.dev
     }
    cloud_id  = var.cloud_id
    folder_id = var.folder_id_dev
    subnet = var.subnet_dev
    k8s_contole_node = var.k8s_contole_node_dev
    k8s_contole_worker = var.k8s_contole_worker_dev
    mikrotik_login=var.mikrotik_login
    mikrotik_pass=var.mikrotik_pass
}

module "prod" {
    count = terraform.workspace == "prod" ? 1 : 0
    source = "./modules/prod"
    providers = {
      yandex.prod = yandex.prod
     }
    cloud_id  = var.cloud_id
    folder_id = var.folder_id_prod
    mikrotik_login=var.mikrotik_login
    mikrotik_pass=var.mikrotik_pass
}