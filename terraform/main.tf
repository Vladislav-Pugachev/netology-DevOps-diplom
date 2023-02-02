module "account" {
    source = "./modules/account"
    cloud_id = var.cloud_id
    token     = var.token
    providers = {
      yandex.account = yandex.account
    }
}

# module "pvc" {
#     depends_on = [
#       module.account
#     ]
#     source = "./modules/vpc"
#     cloud_id  = var.cloud_id
#     folder_id = data.yandex_resourcemanager_folder.folder.folder_id
#     providers = {
#        yandex.vpc = yandex.vpc
#     }
# }  


module "backend" {
    depends_on = [
      module.account
    ]
    source = "./modules/backend"
    token     = var.token
    cloud_id  = var.cloud_id
    folder_id = data.yandex_resourcemanager_folder.folder.folder_id
        providers = {
       yandex.vpc = yandex.vpc
    }
}  
