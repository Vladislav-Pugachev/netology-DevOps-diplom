resource "local_file" "tfvars" {
  content     = templatefile("./modules/provider/tfvars.tpl",
  {
    cloud_id= var.cloud_id
    token = var.token_false
    folders = data.yandex_resourcemanager_folder.folder
    admin_bgw_external_ip=var.admin_bgw_external_ip
    admin_bgw_internal_ip=var.admin_bgw_internal_ip

})
  filename = "../day_1/terraform.tfvars"
}