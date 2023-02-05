resource "yandex_ydb_database_serverless" "ydb-for-terraform" {
  name      = "pvv-netology-diplom"
  folder_id = "${data.yandex_resourcemanager_folder.folder.id}"
  deletion_protection = false
}

resource "null_resource" "cluster" {
depends_on = [yandex_ydb_database_serverless.ydb-for-terraform]
provisioner "local-exec" {
  command = "aws dynamodb create-table --table-name pvv-netology-diplom --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --endpoint ${yandex_ydb_database_serverless.ydb-for-terraform.document_api_endpoint}"
}
}