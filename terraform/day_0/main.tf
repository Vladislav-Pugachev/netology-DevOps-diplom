module "folder" {
    source = "./modules/folder"
    cloud_id  = var.cloud_id
    for_each = toset("${var.env}")
    workdir = "${each.key}"
}

module "vpc" {
    source = "./modules/vpc"
    cloud_id  = var.cloud_id
    depends_on = [module.folder]
}

module "registry" {
    source = "./modules/registry"
    cloud_id  = var.cloud_id
    depends_on = [module.account]
}


module "account" {
    source = "./modules/account"
    cloud_id  = var.cloud_id
    depends_on = [module.folder]
}
module "backend" {
    source = "./modules/backend"
    cloud_id  = var.cloud_id
    access_key= module.account.user-access-key-cred-backend
    secret_key= module.account.user-secret-key-cred-backend
    depends_on = [module.account]
} 

# module "nat" {
#     source = "./modules/nat"
#     cloud_id  = var.cloud_id
#     depends_on = [module.vpc]
# } 

module "web-app" {
    source = "./modules/web_app"
    cloud_id  = var.cloud_id
    access_key= module.account.user-access-key-cred-web
    secret_key= module.account.user-secret-key-cred-web
    depends_on = [module.account]
} 

module "ci_cd" {
    source = "./modules/ci_cd"
    cloud_id  = var.cloud_id
    depends_on = [module.vpc]
} 
module "provider" {
    source = "./modules/provider"
    cloud_id  = var.cloud_id
    access_key= module.account.user-access-key-cred-backend
    secret_key= module.account.user-secret-key-cred-backend
    yadb_endpoint=module.backend.yadb_endpoint
    depends_on = [module.backend]
} 