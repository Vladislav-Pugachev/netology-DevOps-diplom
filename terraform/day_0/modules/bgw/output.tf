output "admin_bgw_external_ip" {
    value = yandex_compute_instance.bgw.network_interface.0.nat_ip_address
}

output "admin_bgw_internal_ip" {
    value = yandex_compute_instance.bgw.network_interface.0.ip_address
}