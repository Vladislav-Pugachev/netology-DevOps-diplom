resource "local_file" "data-for-provider-day-1-json" {
  content     = jsonencode({
    "bucket_id" = "${yandex_storage_bucket.bucket.id}"
    "ydb_end_point"  = "${yandex_ydb_database_serverless.ydb-for-terraform.document_api_endpoint}"
    "access_key" = "${yandex_iam_service_account_static_access_key.editor-bucket-static-key.access_key}"
    "secret_key" = "${yandex_iam_service_account_static_access_key.editor-bucket-static-key.secret_key}"
})
  filename = "./data-bucket.json"
}