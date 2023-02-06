# output "worker_private_ip" {
#     value= toset(yandex_compute_instance.worker_node.*.network_interface.0.ip_address) 
# }

output "worker_hostname" {
    value= {for k,g in yandex_compute_instance.worker_node:  k=>g.hostname}
}