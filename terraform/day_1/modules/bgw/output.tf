output "ip_address_bgw" {
    value = yandex_compute_instance.bgw.network_interface.0.nat_ip_address
}

output "node_network_bgw" {
    value = {
    "${yandex_compute_instance.bgw.hostname}" = data.yandex_vpc_subnet.subnet_bgw.v4_cidr_blocks[0]
    }
}
