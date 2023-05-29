variable "nodes_private_ip_k8s" {
    description = "ip адреса k8s"
    type= map
}


variable "node_internal_ip_bgw" {
    description = "ip int адрес worker-bgw"
    type= string
}

variable "node_external_ip_bgw" {
    description = "ip ext адрес worker-bgw"
    type= string
}

variable "admin_bgw_external_ip" {
    description = "ip ext адрес admin-bgw"
    type= string
}

variable "admin_bgw_internal_ip" {
    description = "ip int адрес admin-bgw"
    type= string
}
