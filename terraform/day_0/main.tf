module "folder" {
    source = "./modules/folder"
    token     = var.token
    cloud_id  = var.cloud_id
    for_each = toset("${var.env}")
    workdir = "${each.key}"
}
module "account" {
    source = "./modules/account"
    token     = var.token
    cloud_id  = var.cloud_id
    for_each = toset("${var.env_day_1}")
    workdir = "${each.key}"
    depends_on = [module.folder]
}
module "backend" {
    source = "./modules/backend"
    token     = var.token
    cloud_id  = var.cloud_id
    for_each = toset("${var.env_backend}")
    workdir = "${each.key}"
    depends_on = [module.folder]
} 

module "provider" {
    source = "./modules/provider"
    depends_on = [module.backend]
} 
