resource "local_file" "inventory-k8s" {
  depends_on = [
    yandex_compute_instance.control_node,
    yandex_compute_instance.worker_node
  ]
  content     = templatefile("./modules/dev/k8s/ansible/inventory.tpl",
  {
    control_node_private_ip = yandex_compute_instance.control_node.network_interface.0.ip_address
    nat_ext_ip = yandex_compute_instance.nat.network_interface.0.nat_ip_address
    control_node_hostname = yandex_compute_instance.control_node.hostname
    worker_nodes = yandex_compute_instance.worker_node[*]
})
  filename = "./modules/dev/k8s/ansible/files/inventory.yml"
}

