module "folder" {
    source = "./modules/admin"
    token= var.token
    cloud_id = var.cloud_id
}

provider "yandex" {
    alias = "dev"
    service_account_key_file = "/home/vlad/Documents/Netology/DevOps/diplom/terraform/modules/admin/key.json"
    # jsonencode({
    #     "id": module.folder.yandex_iam_service_account_key.default-sa-auth-key.id,
    #     "service_account_id": module.folder.yandex_iam_service_account_key.default-sa-auth-key.service_account_id,
    #     "created_at": module.folder.yandex_iam_service_account_key.default-sa-auth-key.created_at,
    #     "key_algorithm": module.folder.yandex_iam_service_account_key.default-sa-auth-key.key_algorithm,
    #     "public_key": module.folder.yandex_iam_service_account_key.default-sa-auth-key.public_key,
    #     "private_key": module.version = "value"
    # })
#"/home/vlad/Documents/Netology/DevOps/diplom/terraform/modules/admin/key.json"
    folder_id="b1g193vibslvb5de7fgu"
    cloud_id  = var.cloud_id
}

resource "yandex_vpc_network" "default" {
provider = yandex.dev
  name = "foobar"
  folder_id="b1g193vibslvb5de7fgu"
}