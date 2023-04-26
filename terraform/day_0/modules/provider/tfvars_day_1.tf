resource "local_file" "tfvars" {
  content     = templatefile("./modules/provider/tfvars.tpl",
  {
    cloud_id= var.cloud_id
    token = var.token_false
    folders = data.yandex_resourcemanager_folder.folder
    bgw_ip_ext=var.bgw_ip_ext

})
  filename = "../day_1/terraform.tfvars"
}