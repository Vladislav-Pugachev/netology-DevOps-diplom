module "vpc" {
    providers = {
    yandex.dev = yandex.dev
    yandex.prod = yandex.prod
  }
      source = "./modules/vpc"
      folder_id=local.folder_id_vpc
}

module "bgw" {
  depends_on = [module.vpc]
    providers = {
    yandex.dev = yandex.dev
    yandex.prod = yandex.prod
  }
      source = "./modules/bgw"
      folder_id=local.folder_id_vpc
      subnet_id_bgw=module.vpc.subnet_id_bgw
}

module "k8s" {
  depends_on = [module.bgw]
    providers = {
    yandex.dev = yandex.dev
    yandex.prod = yandex.prod
  }
      source = "./modules/k8s"
      folder_id=local.folder_id_vpc
      subnet_id_k8s=module.vpc.subnet_id_k8s
      node_external_ip_bgw=module.bgw.node_external_ip_bgw
}

module "network" {
  depends_on = [module.k8s, module.bgw]
    source = "./modules/network"
    nodes_private_ip_k8s=module.k8s.nodes_private_ip_k8s
    node_internal_ip_bgw=module.bgw.node_internal_ip_bgw
    node_external_ip_bgw=module.bgw.node_external_ip_bgw
    admin_bgw_external_ip=var.admin_bgw_external_ip
    admin_bgw_internal_ip=var.admin_bgw_internal_ip
}

module "ansible" {
  depends_on = [module.network]
    source = "./modules/ansible"
    nodes_private_ip_k8s=module.k8s.nodes_private_ip_k8s
    node_internal_ip_bgw=module.bgw.node_internal_ip_bgw
    node_external_ip_bgw=module.bgw.node_external_ip_bgw
    admin_bgw_external_ip=var.admin_bgw_external_ip
    admin_bgw_internal_ip=var.admin_bgw_internal_ip
}