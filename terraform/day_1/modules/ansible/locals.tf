locals {
  loopback_control_node= cidrhost(join("/",[var.nodes_private_ip_k8s[join(terraform.workspace,["","-control-node"])],24]),254)
}
