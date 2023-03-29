resource "yandex_iam_service_account" "editor-backend" {
  name        = "editor-backend"
  description = "service account for terraform backend"
  folder_id = data.yandex_resourcemanager_folder.folder_admin.id
  depends_on = [data.yandex_resourcemanager_folder.folder_admin]
}

resource "yandex_iam_service_account_key" "editor-backend-sa-auth-key" {
  service_account_id = "${yandex_iam_service_account.editor-backend.id}"
  description        = "key for service account editor backend"
  key_algorithm      = "RSA_4096"
}


resource "yandex_iam_service_account_static_access_key" "editor-backend-static-key" {
  service_account_id = "${yandex_iam_service_account.editor-backend.id}"
  description        = "static access key for object storage"
}


resource "yandex_resourcemanager_folder_iam_binding" "editor-backend" {
  folder_id = "${data.yandex_resourcemanager_folder.folder_admin.id}"
  role               = "storage.editor"

  members = [
    "serviceAccount:${yandex_iam_service_account.editor-backend.id}",
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "editor-ydb" {
  folder_id = "${data.yandex_resourcemanager_folder.folder_admin.id}"
  role               = "ydb.editor"

  members = [
    "serviceAccount:${yandex_iam_service_account.editor-backend.id}",
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "encrypt-kms" {
  folder_id = "${data.yandex_resourcemanager_folder.folder_admin.id}"
  role               = "kms.keys.encrypterDecrypter"

  members = [
    "serviceAccount:${yandex_iam_service_account.editor-backend.id}",
  ]
}

resource "local_file" "aws-config" {
  content     = templatefile("${path.module}/aws_config.tpl",
  {
    "secret_key" = "${yandex_iam_service_account_static_access_key.editor-backend-static-key.secret_key}"
    "access_key"  = "${yandex_iam_service_account_static_access_key.editor-backend-static-key.access_key}"
})
  filename = "./aws/credentials"

  provisioner "local-exec" {
    command = "ln -s $(pwd)/aws/credentials $HOME/.aws/credentials"
  }
  provisioner "local-exec" {
    command = "rm $HOME/.aws/credentials"
    when=destroy
  }
}
