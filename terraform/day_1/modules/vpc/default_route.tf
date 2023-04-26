# resource "yandex_vpc_route_table" "default" {
#   provider = yandex.dev 
#   network_id = yandex_vpc_network.underlay.id
#   folder_id = var.folder_id
#   static_route {
#     destination_prefix = "0.0.0.0/0"
#     next_hop_address = cidrhost(local.subnet_bgw, 254)
#   }
# }