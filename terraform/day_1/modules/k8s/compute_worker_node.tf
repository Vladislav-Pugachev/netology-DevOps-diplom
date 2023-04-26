resource "yandex_compute_instance" "worker_node" {
  provider = yandex.dev
  depends_on = [yandex_compute_instance.control_node]
  allow_stopping_for_update = true
  count = length(["ru-central1-b", "ru-central1-c"])
  name = "${terraform.workspace}-worker-node-${index(["ru-central1-b", "ru-central1-c"],(["ru-central1-b", "ru-central1-c"][count.index]))+1}"
  hostname = "${terraform.workspace}-worker-node-${index(["ru-central1-b", "ru-central1-c"],(["ru-central1-b", "ru-central1-c"][count.index]))+1}"
  zone = ["ru-central1-b", "ru-central1-c"][count.index]
  platform_id = "standard-v1"
  folder_id = var.folder_id
  resources {
    cores = local.cores_worker_node
    memory = local.memory_worker_node
  }
  boot_disk {
    initialize_params {
      image_id = var.k8s_image["control_node"]
      size = local.size_worker_node
    }
  }
  network_interface {
      nat = false
      subnet_id = var.subnet_id_k8s[["ru-central1-b", "ru-central1-c"][count.index]]
      ip_address = cidrhost(data.yandex_vpc_subnet.subnet_k8s[["ru-central1-b", "ru-central1-c"][count.index]].v4_cidr_blocks[0], 253)
  }
  metadata = {
      user-data = "${file("./users.yml")}"
  }
}