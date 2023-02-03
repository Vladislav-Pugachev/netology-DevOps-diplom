
data "yandex_resourcemanager_folder" "folder" {
    name     = "folder-${terraform.workspace}"
  cloud_id = var.cloud_id
      depends_on = [
      module.account
    ]
}

data "local_file" "admin-resourse" {
    filename = "./admin-resourse.json"
    depends_on = [
      module.account
    ]
}

data "local_file" "admin-bucket" {
    filename = "./editor-backet.json"
    depends_on = [
      module.account
    ]
}