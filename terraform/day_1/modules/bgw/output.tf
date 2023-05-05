output "node_external_ip_bgw" {
    value = yandex_compute_instance.bgw.network_interface.0.nat_ip_address
}
output "node_internal_ip_bgw" {
    value = yandex_compute_instance.bgw.network_interface.0.ip_address
}
