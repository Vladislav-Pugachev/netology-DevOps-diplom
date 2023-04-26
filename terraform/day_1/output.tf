output "node_network_k8s" {
  value = module.k8s.node_network_k8s
}

output "node_network_bgw" {
  value = module.bgw.node_network_bgw
}

 output "ip_address_bgw" {
     value = module.bgw.ip_address_bgw
 }