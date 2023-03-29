terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.84.0"
    }
  }
}


resource "local_file" "provider-config" {
  content     = templatefile("./modules/provider/provider.tpl",
  {
    bucket_id = "pvv-netology-diplom-backend"
    ydb_end_point = var.yadb_endpoint
    access_key = var.access_key
    secret_key = var.secret_key
    dynamodb_table = "pvv-netology-diplom"
    folders = data.yandex_resourcemanager_folder.folder
})
  filename = "../day_1/provider.tf"
}

resource "local_file" "tfvars" {
  content     = templatefile("./modules/provider/tfvars.tpl",
  {
    cloud_id= var.cloud_id
    token = var.token_false
    folders = data.yandex_resourcemanager_folder.folder

})
  filename = "../day_1/terraform.tfvars"
}