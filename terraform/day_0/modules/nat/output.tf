output "nat_external_ip" {
    value = yandex_compute_instance.nat.network_interface.0.nat_ip_address
}