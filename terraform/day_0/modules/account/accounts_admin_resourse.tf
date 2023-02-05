resource "yandex_iam_service_account" "admin-resourse" {
  name        = "admin-resourse-env-${var.workdir}"
  description = "service account for CRUD resourse in folder"
  folder_id = "${data.yandex_resourcemanager_folder.folder.id}"
  depends_on = [data.yandex_resourcemanager_folder.folder]
}

 resource "yandex_iam_service_account_key" "admin-resourse-sa-auth-key" {
  service_account_id = "${yandex_iam_service_account.admin-resourse.id}"
  description        = "key for service account admin resourse"
  key_algorithm      = "RSA_4096"
}


resource "local_file" "admin-resourse-cred-json" {
  content     = jsonencode({
    "id" = yandex_iam_service_account_key.admin-resourse-sa-auth-key.id
    "service_account_id"  = yandex_iam_service_account_key.admin-resourse-sa-auth-key.service_account_id
    "created_at" = yandex_iam_service_account_key.admin-resourse-sa-auth-key.created_at
    "key_algorithm" = yandex_iam_service_account_key.admin-resourse-sa-auth-key.key_algorithm
    "public_key" = yandex_iam_service_account_key.admin-resourse-sa-auth-key.public_key
    "private_key" = yandex_iam_service_account_key.admin-resourse-sa-auth-key.private_key
})
  filename = "./admin-resourse-env-${var.workdir}.json"
      provisioner "local-exec" {
    command = "ln -s $(pwd)/admin-resourse-env-${var.workdir}.json ../day_1/admin-resourse-env-${var.workdir}.json"
  }
  provisioner "local-exec" {
  command = "rm ../day_1/${self.filename}"
  when=destroy
  }
}

