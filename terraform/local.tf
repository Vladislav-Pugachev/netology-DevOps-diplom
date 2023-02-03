locals {
  local_data = jsondecode(data.local_file.admin-bucket.content)
}