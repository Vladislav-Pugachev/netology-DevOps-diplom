resource "local_file" "provider-config" {
  content     = templatefile("./modules/provider/provider.tpl",
  {
    bucket_id = "pvv-netology-diplom-backend"
    ydb_end_point = var.yadb_endpoint
    access_key = var.access_key
    secret_key = var.secret_key
    dynamodb_table = "pvv-netology-diplom"
})
  filename = "../day_1/provider.tf"
}

# resource "local_file" "workspace_tfvars" {
#   for_each = local.folder_ws_id
#   content     = templatefile("./modules/provider/workspace.tpl",
#   {
#     cloud_id= var.cloud_id
#     folder_id = each.value
#     workspace = each.key
#     admin_bgw_external_ip=var.admin_bgw_external_ip
#     admin_bgw_internal_ip=var.admin_bgw_internal_ip
# })
#   filename = "../day_1/${each.key}.tfvars"
# }