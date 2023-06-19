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

module "bgw" {
    source = "./modules/bgw"
    cloud_id  = var.cloud_id
    depends_on = [module.vpc]
} 

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
    api_token_gitlab=var.api_token_gitlab
    depends_on = [module.vpc]
}

module "gitlab" {
    source = "./modules/gitlab"
}


module "provider" {
    source = "./modules/provider"
    depends_on = [module.backend]
    cloud_id  = var.cloud_id
    access_key= module.account.user-access-key-cred-backend
    secret_key= module.account.user-secret-key-cred-backend
    yadb_endpoint=module.backend.yadb_endpoint
    admin_bgw_external_ip=module.bgw.admin_bgw_external_ip
    admin_bgw_internal_ip=module.bgw.admin_bgw_internal_ip
//    folder_ws=module.folder.folder_ws
} 