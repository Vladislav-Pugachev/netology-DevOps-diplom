output "nodes_private_ip_k8s" {
  value = module.k8s.nodes_private_ip_k8s
}

 output "node_external_ip_bgw" {
     value = module.bgw.node_external_ip_bgw
 }