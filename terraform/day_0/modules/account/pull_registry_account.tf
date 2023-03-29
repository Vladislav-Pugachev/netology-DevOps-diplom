resource "yandex_iam_service_account" "user-registry" {
  name        = "user-registry"
  description = "service account for pull and push image in registry"
  folder_id = data.yandex_resourcemanager_folder.folder_admin.id
  depends_on = [data.yandex_resourcemanager_folder.folder_admin]
}

 resource "yandex_iam_service_account_key" "puller-registry-sa-auth-key" {
  service_account_id = "${yandex_iam_service_account.user-registry.id}"
  description        = "key for service account in registry"
  key_algorithm      = "RSA_4096"
}


resource "yandex_resourcemanager_folder_iam_binding" "puller-image" {
  folder_id = "${data.yandex_resourcemanager_folder.folder_admin.id}"
  role               = "container-registry.images.puller"

  members = [
    "serviceAccount:${yandex_iam_service_account.user-registry.id}",
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "pusher-image" {
  folder_id = "${data.yandex_resourcemanager_folder.folder_admin.id}"
  role               = "container-registry.images.pusher"

  members = [
    "serviceAccount:${yandex_iam_service_account.user-registry.id}",
  ]
}

resource "local_file" "user-registry-cred-json" {
  content     = jsonencode({
    "id" = yandex_iam_service_account_key.puller-registry-sa-auth-key.id
    "service_account_id"  = yandex_iam_service_account_key.puller-registry-sa-auth-key.service_account_id
    "created_at" = yandex_iam_service_account_key.puller-registry-sa-auth-key.created_at
    "key_algorithm" = yandex_iam_service_account_key.puller-registry-sa-auth-key.key_algorithm
    "public_key" = yandex_iam_service_account_key.puller-registry-sa-auth-key.public_key
    "private_key" = yandex_iam_service_account_key.puller-registry-sa-auth-key.private_key
})
  filename = "./user-registry.json"

  provisioner "local-exec" {
  command = "rm ./${self.filename}"
  when=destroy
  }
}