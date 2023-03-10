resource "yandex_compute_instance" "control_node" {
  depends_on = [yandex_compute_instance.nat]
    name = "control-node-${terraform.workspace}"
    hostname = "control-node-${terraform.workspace}"
    zone = "ru-central1-a"
    platform_id = "standard-v1"
    folder_id = var.folder_id
    resources {
      cores = var.k8s_contole_node["cores"]
      memory = var.k8s_contole_node["memory"]
    }
    boot_disk {
      initialize_params {
        image_id = var.k8s_contole_node["image_id"]
        size = var.k8s_contole_node["local_disk"]
      }
    }
    network_interface {
        nat = false
        subnet_id = yandex_vpc_subnet.subnet["ru-central1-a"].id
        ip_address = "10.0.0.1"
    }
    metadata = {
        user-data = "${file("./users.yml")}"
  }
}