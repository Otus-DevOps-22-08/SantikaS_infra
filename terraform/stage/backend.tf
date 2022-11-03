
#// Создание статического ключа доступа
#resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
#  service_account_id = "ajehgichlohv9jvluki7"
#  description        = "static access key for object storage"
#}


#// Создание бакета с использованием ключа
#resource "yandex_storage_bucket" "test" {
#  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
#  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
#  bucket     = "storage-backet"
#}


terraform {


  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "storage-backet"
    region     = "ru-central1-a"
    key        = "terraform.tfstate"
    #access_key = yandex_storage_bucket.test.access_key
    #secret_key = yandex_storage_bucket.test.secret_key
    access_key = "YCAJE5XI-GhebR53NKH1XSl9V"
    secret_key = "YCP6tAsRk1qjSvnp9MIkKvXXMD4sUhSr5yyXMOWs"

    skip_region_validation      = true
    skip_credentials_validation = true
   }
}
