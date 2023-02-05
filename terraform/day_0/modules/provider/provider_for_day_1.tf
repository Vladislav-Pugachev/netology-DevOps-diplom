resource "local_file" "provider-config" {
  content     = templatefile("./modules/provider/provider.tpl",
  {
    bucket_id = local.bucket_data.bucket_id
    ydb_end_point = local.bucket_data.ydb_end_point
    access_key = local.bucket_data.access_key
    secret_key = local.bucket_data.secret_key
    folder_id = var.folder
    dynamodb_table = "pvv-netology-diplom"
})
  filename = "../day_1/provider.tf"
}