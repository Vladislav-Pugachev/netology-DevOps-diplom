resource "yandex_compute_instance" "gitlab" {
    name = "gitlab-node-${terraform.workspace}"
    hostname = "gitlab-node-${terraform.workspace}"
    zone = "ru-central1-a"
    platform_id = "standard-v1"
    folder_id = data.yandex_resourcemanager_folder.folder.id
    resources {
      cores = 2
      memory = 8
    }
    boot_disk {
      initialize_params {
        image_id = "fd83vstafqja7ql1kj0b"
        size = 50
        type="network-ssd"
      }
    }
    network_interface {
        nat = true
        subnet_id = data.yandex_vpc_subnet.underlay_subnet.id
    }
    metadata = {
        user-data = "${file("./users.yml")}"
  }
}