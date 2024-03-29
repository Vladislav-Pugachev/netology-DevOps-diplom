locals {
  subnet_gre_k8s={
    "${terraform.workspace}-control-node" = "${terraform.workspace}" == "dev" ? "10.10.1.0/30": "10.20.1.0/30"
    "${terraform.workspace}-worker-node-1" = "${terraform.workspace}" == "dev" ? "10.10.2.0/30": "10.20.2.0/30"
    "${terraform.workspace}-worker-node-2" = "${terraform.workspace}" == "dev" ? "10.10.3.0/30": "10.20.3.0/30"
  }
}


locals {
  subnet_gre_bgw= "${terraform.workspace}" == "dev" ? "10.10.0.0/30": "10.20.0.0/30"
}

locals {
  as_bgw= "${terraform.workspace}" == "dev" ? "65001": "65002"
}


locals {
  prefix_list = jsonencode(values({for k,v in var.nodes_private_ip_k8s : k => join("/",[cidrhost(join("/",[v,24]),254),32])}))
}