resource "yandex_iam_service_account" "web-image-uploader" {
  name        = "web-image-uploader"
  description = "service account for web app"
  folder_id = data.yandex_resourcemanager_folder.folder_admin.id
}



resource "yandex_iam_service_account_static_access_key" "web-image-uploader-static-key" {
  service_account_id = "${yandex_iam_service_account.web-image-uploader.id}"
  description        = "static access key for object storage"
}

resource "yandex_resourcemanager_folder_iam_binding" "web-upload" {
  folder_id = data.yandex_resourcemanager_folder.folder_admin.id
  role               = "storage.editor"

  members = [
    "serviceAccount:${yandex_iam_service_account.web-image-uploader.id}",
  ]
}


resource "local_file" "user-web-cred-json" {
  content     = jsonencode({
    "secret_key" = "${yandex_iam_service_account_static_access_key.web-image-uploader-static-key.secret_key}"
    "access_key"  = "${yandex_iam_service_account_static_access_key.web-image-uploader-static-key.access_key}"
})
  filename = "./user-web.json"

  provisioner "local-exec" {
  command = "rm ./${self.filename}"
  when=destroy
  }
}