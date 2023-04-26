data "yandex_vpc_subnet" "subnet_k8s" {
  provider = yandex.dev
  for_each = var.subnet_id_k8s
  subnet_id = each.value
}