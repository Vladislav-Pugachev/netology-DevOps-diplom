output "subnet_id_bgw" {
    value=yandex_vpc_subnet.subnet_bwg.id
}

output "subnet_id_k8s" {
    value={for k,g in yandex_vpc_subnet.subnet: k=>g.id}
}
