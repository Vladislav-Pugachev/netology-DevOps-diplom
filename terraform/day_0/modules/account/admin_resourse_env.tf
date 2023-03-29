resource "yandex_iam_service_account" "admin-resourse" {
  for_each = toset("${var.env_day_1}")
  name        = "admin-resourse-env-${each.key}"
  description = "service account for CRUD resourse in work environment"
  folder_id = "${data.yandex_resourcemanager_folder.folder_work_env[each.key].id}"
  depends_on = [data.yandex_resourcemanager_folder.folder_work_env]
}

 resource "yandex_iam_service_account_key" "admin-resourse-sa-auth-key" {
  for_each = toset("${var.env_day_1}")
  service_account_id = "${yandex_iam_service_account.admin-resourse[each.key].id}"
  description        = "key for service account admin resourse"
  key_algorithm      = "RSA_4096"
}


resource "yandex_resourcemanager_folder_iam_binding" "compute-admin-sa" {
  for_each = toset("${var.env_day_1}")
  folder_id = "${data.yandex_resourcemanager_folder.folder_work_env[each.key].id}"
  role               = "compute.admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.admin-resourse[each.key].id}",
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "vpc-admin-iam" {
  for_each = toset("${var.env_day_1}")
  folder_id = "${data.yandex_resourcemanager_folder.folder_work_env[each.key].id}"
  role               = "vpc.admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.admin-resourse[each.key].id}",
  ]
}

resource "local_file" "admin-resourse-cred-json" {
  for_each = toset("${var.env_day_1}")
  content     = jsonencode({
    "id" = yandex_iam_service_account_key.admin-resourse-sa-auth-key[each.key].id
    "service_account_id"  = yandex_iam_service_account_key.admin-resourse-sa-auth-key[each.key].service_account_id
    "created_at" = yandex_iam_service_account_key.admin-resourse-sa-auth-key[each.key].created_at
    "key_algorithm" = yandex_iam_service_account_key.admin-resourse-sa-auth-key[each.key].key_algorithm
    "public_key" = yandex_iam_service_account_key.admin-resourse-sa-auth-key[each.key].public_key
    "private_key" = yandex_iam_service_account_key.admin-resourse-sa-auth-key[each.key].private_key
})
  filename = "./admin-resourse-env-${each.key}.json"
      provisioner "local-exec" {
    command = "ln -s $(pwd)/admin-resourse-env-${each.key}.json ../day_1/admin-resourse-env-${each.key}.json"
  }
  provisioner "local-exec" {
  command = "rm ../day_1/${self.filename}"
  when=destroy
  }
}




