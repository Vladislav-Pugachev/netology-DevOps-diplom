variable "folder_id" {
  description =  "folder id"
  type = string
}

variable "subnet_id_k8s" {
    description = "Id подсети для k8s"
    type= map
}

variable "k8s_image" {
  description = "образ ВМ"
  type = map
  default = {
    "control_node"="fd8tckeqoshi403tks4l"
    "worker_node"="fd8tckeqoshi403tks4l"
  }
}