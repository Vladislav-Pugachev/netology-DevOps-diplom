locals {
  bucket_data = jsondecode(data.local_file.data-bucket.content)
}
