resource "yandex_compute_instance" "worker_node" {
  provider = yandex.dev
    depends_on = [yandex_compute_instance.control_node]
    count = length(["ru-central1-b", "ru-central1-c"])
    name = "worker-node-${index(["ru-central1-b", "ru-central1-c"],(["ru-central1-b", "ru-central1-c"][count.index]))+1}-${terraform.workspace}"
    hostname = "worker-node-${index(["ru-central1-b", "ru-central1-c"],(["ru-central1-b", "ru-central1-c"][count.index]))+1}-${terraform.workspace}"
    zone = ["ru-central1-b", "ru-central1-c"][count.index]
    platform_id = "standard-v1"
    folder_id = var.folder_id
    resources {
      cores = var.k8s_contole_worker["cores"]
      memory = var.k8s_contole_worker["memory"]
    }
    boot_disk {
      initialize_params {
        image_id = var.k8s_contole_worker["image_id"]
        size = var.k8s_contole_worker["local_disk"]
      }
    }
    network_interface {
        nat = false
        subnet_id = yandex_vpc_subnet.subnet[["ru-central1-b", "ru-central1-c"][count.index]].id
    }
    metadata = {
        user-data = "${file("./users.yml")}"
  }

}