resource "yandex_kms_symmetric_key" "kms" {
  folder_id = "${data.yandex_resourcemanager_folder.folder.id}"
  name              = "for-bucket-symetric-key"
  description       = "description for key"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"
}