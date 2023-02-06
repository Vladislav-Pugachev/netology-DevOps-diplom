resource "local_file" "inventory-k8s" {
  content     = templatefile("./modules/dev/inventory.tpl",
  {
    control_node_ext_ip = yandex_compute_instance.control_node.network_interface.0.nat_ip_address
    control_node_private_ip = yandex_compute_instance.control_node.network_interface.0.ip_address
    control_node_hostname = yandex_compute_instance.control_node.hostname
    worker_nodes = yandex_compute_instance.worker_node[*]
})
  filename = "./modules/dev/inventory.yml"
}

