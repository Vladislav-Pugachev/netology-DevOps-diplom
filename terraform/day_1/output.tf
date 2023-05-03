output "nodes_private_ip_k8s" {
  value = module.k8s.nodes_private_ip_k8s
}

 output "ip_address_bgw" {
     value = module.bgw.ip_address_bgw
 }