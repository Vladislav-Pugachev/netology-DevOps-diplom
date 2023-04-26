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