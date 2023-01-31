resource "local_file" "key-json" {
  content     = templatefile("/home/vlad/Documents/Netology/DevOps/diplom/terraform/modules/admin/key.tpl", {
    id = yandex_iam_service_account_key.default-sa-auth-key.id
    service_account_id  = yandex_iam_service_account_key.default-sa-auth-key.service_account_id
    created_at = yandex_iam_service_account_key.default-sa-auth-key.created_at
    key_algorithm = yandex_iam_service_account_key.default-sa-auth-key.key_algorithm
    public_key = yandex_iam_service_account_key.default-sa-auth-key.public_key
    private_key = yandex_iam_service_account_key.default-sa-auth-key.private_key
  })
  filename = "/home/vlad/Documents/Netology/DevOps/diplom/terraform/modules/admin/key1.json"
}