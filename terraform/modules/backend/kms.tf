resource "yandex_kms_symmetric_key" "key-a" {
  folder_id = var.folder_id
  name              = "for-bucket-symetric-key"
  description       = "description for key"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"
}