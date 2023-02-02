
data "yandex_resourcemanager_folder" "folder" {
    name     = "folder-${terraform.workspace}"
  cloud_id = var.cloud_id
      depends_on = [
      module.account
    ]
}

data "local_file" "key-json" {
    filename = "./key.json"
    depends_on = [
      module.account
    ]
}