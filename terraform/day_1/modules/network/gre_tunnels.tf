resource "local_file" "gre_tunnels_k8s" {
  for_each = var.node_network_k8s
  content     = templatefile("./modules/network/gre_tunnels_k8s.tpl",
  {
    name=each.key
    lo = cidrhost(each.value,254)
    local = cidrhost(each.value,253)
    remote = cidrhost(var.node_network_bgw["${terraform.workspace}-bgw-node"],253)
    addresses = cidrhost(local.subnet_gre[each.key],2)
    routes_to = cidrhost(var.node_network_bgw["${terraform.workspace}-bgw-node"],254)
    routes_via = cidrhost(local.subnet_gre[each.key],1)
})
  filename = "./modules/ansible/netplan/gre_tunnels/${each.key}.yaml"
}

resource "local_file" "gre_tunnels_bgw" {
  content     = templatefile("./modules/network/gre_tunnels_bgw.tpl",
  {
    lo = cidrhost(var.node_network_bgw["${terraform.workspace}-bgw-node"],254)
    local = cidrhost(var.node_network_bgw["${terraform.workspace}-bgw-node"],253)
    remotes = var.node_network_k8s
    addresses_tunnel = local.subnet_gre
})
  filename = "./modules/ansible/netplan/gre_tunnels/${terraform.workspace}-bgw-node.yaml"
}
