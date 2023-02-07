resource "yandex_compute_instance" "nat" {
    name = "mikrotik-node-${terraform.workspace}"
    hostname = "mikrotik-node-${terraform.workspace}"
    zone = "ru-central1-a"
    platform_id = "standard-v1"
    folder_id = var.folder_id
    resources {
      cores = 2
      memory = 2
    }
    boot_disk {
      initialize_params {
        image_id = "fd84rbp1354f0g87qsup"
        size = 5
      }
    }
    network_interface {
        nat = true
        subnet_id = yandex_vpc_subnet.nat.id
        ip_address = "192.168.1.254"
    }
    metadata = {
        user-data = "${file("./users.yml")}"
  }
}

resource "local_file" "mikrotik_yml" {
  depends_on = [
    yandex_compute_instance.control_node,
    yandex_compute_instance.nat
  ]
  content     = templatefile("./modules/dev/mikrotik.tpl",
  {
    nat_ext_ip = yandex_compute_instance.nat.network_interface.0.nat_ip_address
    nat_private_ip = yandex_compute_instance.nat.network_interface.0.ip_address
    control_node_private_ip = yandex_compute_instance.control_node.network_interface.0.ip_address
    workspace = terraform.workspace
    mikrotik_login = var.mikrotik_login
    mikrotik_pass = var.mikrotik_pass
})
  filename = "./mikrotik.yml"
}

resource "null_resource" "deploy_mikrotik" {
  depends_on = [
    local_file.mikrotik_yml
  ]
  provisioner "local-exec" {
    command = "ansible-playbook -i ${yandex_compute_instance.nat.network_interface.0.nat_ip_address}, --timeout=120 mikrotik.yml"
  }
}