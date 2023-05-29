resource "local_file" "bird_conf_admin_bgw" {
  content     = templatefile("./modules/network/bird_conf_admin.tpl",
  {
    lo_admin = cidrhost(join("/",[var.admin_bgw_internal_ip,24]),254)
})
  filename = "./modules/ansible/roles/bird/files/admin_bgw.conf"
}

resource "local_file" "bird_conf_admin_bgw_to_env" {
  content     = templatefile("./modules/network/bird_conf_admin_to_env.tpl",
  {
    lo_admin = cidrhost(join("/",[var.admin_bgw_internal_ip,24]),254)
    as_bgw = local.as_bgw
    node_internal_ip_bgw=var.node_internal_ip_bgw
    workspace="${terraform.workspace}"
})
  filename = "./modules/ansible/roles/bird/files/to_${terraform.workspace}_bgw.conf"
}

resource "local_file" "bird_conf_env_bgw" {
  content     = templatefile("./modules/network/bird_conf_env_bgw.tpl",
  {
    lo_admin = cidrhost(join("/",[var.admin_bgw_internal_ip,24]),254)
    as_bgw = local.as_bgw
    node_internal_ip_bgw=var.node_internal_ip_bgw
    workspace="${terraform.workspace}"
    prefix_list=local.prefix_list
    remotes = var.nodes_private_ip_k8s
})
  filename = "./modules/ansible/roles/bird/files/${terraform.workspace}_bgw.conf"
}