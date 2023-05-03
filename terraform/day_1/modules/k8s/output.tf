output "nodes_private_ip_k8s" {
    value = merge({
        for node in yandex_compute_instance.worker_node[*]: node.hostname=>node.network_interface.0.ip_address
    },{"${yandex_compute_instance.control_node.hostname}"=yandex_compute_instance.control_node.network_interface.0.ip_address})
}