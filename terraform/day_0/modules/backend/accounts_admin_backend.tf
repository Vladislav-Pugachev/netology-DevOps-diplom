resource "yandex_iam_service_account" "editor-backend" {
  name        = "editor-backend-env-${var.workdir}"
  description = "service account for terraform backend"
  folder_id = "${data.yandex_resourcemanager_folder.folder.id}"
  depends_on = [data.yandex_resourcemanager_folder.folder]
}

resource "yandex_iam_service_account_key" "editor-backend-sa-auth-key" {
  service_account_id = "${yandex_iam_service_account.editor-backend.id}"
  description        = "key for service account editor backend"
  key_algorithm      = "RSA_4096"
}


resource "yandex_iam_service_account_static_access_key" "editor-bucket-static-key" {
  service_account_id = "${yandex_iam_service_account.editor-backend.id}"
  description        = "static access key for object storage"
}


resource "local_file" "aws-config" {
  content     = templatefile("${path.module}/aws_config.tpl",
  {
    "secret_key" = "${yandex_iam_service_account_static_access_key.editor-bucket-static-key.secret_key}"
    "access_key"  = "${yandex_iam_service_account_static_access_key.editor-bucket-static-key.access_key}"
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
