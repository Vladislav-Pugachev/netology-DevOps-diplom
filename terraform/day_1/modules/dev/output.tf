output "worker_hostname" {
    value= {for k,g in yandex_compute_instance.worker_node:  k=>g.hostname}
}