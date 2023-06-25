data "yandex_resourcemanager_folder" "folder" {
  name     = "folder-${terraform.workspace}"
  cloud_id = var.cloud_id
}

data "yandex_vpc_subnet" "underlay_subnet" {
  folder_id= data.yandex_resourcemanager_folder.folder.id
  name = "underlay_subnet"
}

data "external" "gitlab_token" {
  depends_on = [ null_resource.token_gitlab ]
  program = ["bash", "${path.module}/token_gitlab.sh"]
}

data "yandex_compute_image" "gitlab" {
  family = "ubuntu-2204-lts"
}
