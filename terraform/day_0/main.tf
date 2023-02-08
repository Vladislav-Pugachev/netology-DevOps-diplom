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

resource "local_file" "tfvars" {
#    for_each = data.yandex_resourcemanager_folder.folder["${each.key}"]
  content     = templatefile("./tfvars.tpl",
  {
    cloud_id= "${var.cloud_id}"
    token = "${var.cloud_id}"
    mikrotik_login="${var.mikrotik_login}"
    mikrotik_pass="${var.mikrotik_pass}"
    folders = data.yandex_resourcemanager_folder.folder

})
  filename = "../day_1/terraform.tfvars"
}
