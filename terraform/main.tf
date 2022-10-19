terraform {
  required_providers {
    yandex = {
      source = "yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone      = var.zone
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  #token = var.yc_tocken
  service_account_key_file = var.service_account_key_file
}

resource "yandex_compute_instance" "app" {
  name = "reddit-app"
  zone = var.zone_app
  #count = 2
  metadata = {
    user-data = "${file("meta.txt")}"
  }
  resources {
    cores  = 2
    memory = 2
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = var.subnet_id
    nat       = true
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = var.image_id
    }
  }

  connection {
    type  = "ssh"
    host  = yandex_compute_instance.app.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key)
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}
