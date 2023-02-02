resource "yandex_ydb_database_serverless" "ydb-for-terraform" {
  name      = "terraform-state-lock"
  folder_id = var.folder_id
  deletion_protection = false
}