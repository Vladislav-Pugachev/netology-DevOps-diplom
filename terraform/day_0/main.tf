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

module "nat" {
    source = "./modules/nat"
    token     = var.token
    cloud_id  = var.cloud_id
    depends_on = [module.folder]
} 

module "web-app" {
    source = "./modules/web_app"
    token     = var.token
    cloud_id  = var.cloud_id
    depends_on = [module.folder]
} 


module "provider" {
    source = "./modules/provider"
    depends_on = [module.backend]
} 

resource "local_file" "tfvars" {
  content     = templatefile("./tfvars.tpl",
  {
    cloud_id= var.cloud_id
    token = var.token
    folders = data.yandex_resourcemanager_folder.folder

})
  filename = "../day_1/terraform.tfvars"
}
