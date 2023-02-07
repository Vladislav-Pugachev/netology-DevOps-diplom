resource "local_file" "script-k8s" {
  content     = templatefile("./modules/dev/script.tpl",
  {
    nat_ext_ip = yandex_compute_instance.nat.network_interface.0.nat_ip_address
})
  filename = "./script.sh"
}

