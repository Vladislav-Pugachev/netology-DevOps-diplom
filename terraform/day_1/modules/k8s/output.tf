output "node_network_k8s" {
    value = {
        "${yandex_compute_instance.control_node.hostname}" = data.yandex_vpc_subnet.subnet_k8s["ru-central1-a"].v4_cidr_blocks[0]
        "${yandex_compute_instance.worker_node[0].hostname}"=data.yandex_vpc_subnet.subnet_k8s["ru-central1-b"].v4_cidr_blocks[0]
        "${yandex_compute_instance.worker_node[1].hostname}"=data.yandex_vpc_subnet.subnet_k8s["ru-central1-c"].v4_cidr_blocks[0]
    }
}