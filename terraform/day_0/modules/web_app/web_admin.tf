resource "yandex_iam_service_account" "web-image-uploader" {
  name        = "web-image-uploader"
  description = "service account for web app"
  folder_id = "${data.yandex_resourcemanager_folder.folder.id}"
}



resource "yandex_iam_service_account_static_access_key" "web-image-uploader-static-key" {
  service_account_id = "${yandex_iam_service_account.web-image-uploader.id}"
  description        = "static access key for object storage"
}


resource "local_file" "web-config" {
  content     = templatefile("${path.module}/web_cred.tpl",
  {
    "secret_key" = "${yandex_iam_service_account_static_access_key.web-image-uploader-static-key.secret_key}"
    "access_key"  = "${yandex_iam_service_account_static_access_key.web-image-uploader-static-key.access_key}"
})
  filename = "./web/credentials"
}
