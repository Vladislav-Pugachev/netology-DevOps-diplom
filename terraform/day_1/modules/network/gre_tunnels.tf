resource "local_file" "gre_tunnels_k8s" {
  for_each = var.nodes_private_ip_k8s
  content     = templatefile("./modules/network/gre_tunnels_k8s.tpl",
  {
    name=each.key
    lo = cidrhost(join("/",[each.value,24]),254)
    local = each.value
    remote =var.node_internal_ip_bgw
    addresses = cidrhost(local.subnet_gre_k8s[each.key],2)
    routes_to = cidrhost(join("/",[var.node_internal_ip_bgw,24]),254)
    routes_via = cidrhost(local.subnet_gre_k8s[each.key],1)
    local_gw=cidrhost(join("/",[each.value,24]),1)
    workspace="${terraform.workspace}"   
})
  filename = "./modules/ansible/netplan/gre_tunnels/${each.key}.yaml"
}

resource "local_file" "gre_tunnels_work_bgw" {
  content     = templatefile("./modules/network/gre_tunnels_work_bgw.tpl",
  {
    lo = cidrhost(join("/",[var.node_internal_ip_bgw,24]),254)
    node_internal_ip_bgw = var.node_internal_ip_bgw
    remotes = var.nodes_private_ip_k8s
    addresses_tunnel = local.subnet_gre_k8s
    workspace="${terraform.workspace}"
    admin_bgw_external_ip=var.admin_bgw_external_ip
    admin_bgw_internal_ip=var.admin_bgw_internal_ip
    subnet_gre_bgw=local.subnet_gre_bgw
})
  filename = "./modules/ansible/netplan/gre_tunnels/${terraform.workspace}-bgw-node.yaml"
}


resource "local_file" "gre_tunnels_admin_bgw" {
  content     = templatefile("./modules/network/gre_tunnels_admin_bgw.tpl",
  {
    lo = cidrhost(join("/",[var.admin_bgw_internal_ip,24]),254)
    local = var.admin_bgw_internal_ip
    remotes = var.node_external_ip_bgw
    subnet_gre_bgw = local.subnet_gre_bgw
    node_internal_ip_bgw=var.node_internal_ip_bgw
    workspace="${terraform.workspace}"
})
  filename = "./modules/ansible/netplan/gre_tunnels/admin-bgw-node.yaml"
}