resource "yandex_iam_service_account_iam_binding" "compute-admin-sa" {
  service_account_id = "${yandex_iam_service_account.defaultSa.id}"
  role               = "compute.admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.defaultSa.id}",
  ]
}



resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
  service_account_id = "${yandex_iam_service_account.defaultSa.id}"
  role               = "admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.defaultSa.id}",
  ]
}

resource "yandex_iam_service_account_iam_binding" "editor" {
  service_account_id = "${yandex_iam_service_account.defaultSa.id}"
  role               = "editor"

  members = [
    "serviceAccount:${yandex_iam_service_account.defaultSa.id}",
  ]
}