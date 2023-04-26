output "bgw_external_ip" {
    value = yandex_compute_instance.bgw.network_interface.0.nat_ip_address
}