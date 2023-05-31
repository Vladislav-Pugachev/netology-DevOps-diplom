locals {
  cores_control_node="${terraform.workspace}" == "dev" ? 4: 8
  cores_worker_node="${terraform.workspace}" == "dev" ? 2: 4
  memory_control_node="${terraform.workspace}" == "dev" ? 8: 16
  memory_worker_node="${terraform.workspace}" == "dev" ? 4: 8
  size_control_node="${terraform.workspace}" == "dev" ? 50: 60
  size_worker_node="${terraform.workspace}" == "dev" ? 80: 60
}