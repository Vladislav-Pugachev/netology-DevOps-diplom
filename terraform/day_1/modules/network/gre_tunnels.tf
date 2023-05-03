resource "local_file" "gre_tunnels_k8s" {
  for_each = var.nodes_private_ip_k8s
  content     = templatefile("./modules/network/gre_tunnels_k8s.tpl",
  {
    name=each.key
    lo = cidrhost(join("/",[each.value,24]),254)
    local = each.value
    remote =var.node_private_ip_bgw["${terraform.workspace}-bgw-node"]
    addresses = cidrhost(local.subnet_gre[each.key],2)
    routes_to = cidrhost(join("/",[var.node_private_ip_bgw["${terraform.workspace}-bgw-node"],24]),254)
    routes_via = cidrhost(local.subnet_gre[each.key],1)
})
  filename = "./modules/ansible/netplan/gre_tunnels/${each.key}.yaml"
}

resource "local_file" "gre_tunnels_bgw" {
  content     = templatefile("./modules/network/gre_tunnels_bgw.tpl",
  {
    lo = cidrhost(join("/",[var.node_private_ip_bgw["${terraform.workspace}-bgw-node"],24]),254)
    local = var.node_private_ip_bgw["${terraform.workspace}-bgw-node"]
    remotes = var.nodes_private_ip_k8s
    addresses_tunnel = local.subnet_gre
})
  filename = "./modules/ansible/netplan/gre_tunnels/${terraform.workspace}-bgw-node.yaml"
}
