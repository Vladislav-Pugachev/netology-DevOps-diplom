output "ip_address_bgw" {
    value = yandex_compute_instance.bgw.network_interface.0.nat_ip_address
}
output "node_private_ip_bgw" {
    value = {
    "${yandex_compute_instance.bgw.hostname}" = yandex_compute_instance.bgw.network_interface.0.ip_address
    }
}
