resource "yandex_compute_instance" "docker-host" {
  count = var.instance_count
  name = "docker-host-${count.index}"
  labels = {
    tags = "otus-reddit-${count.index}"
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = "${element(yandex_compute_instance.docker-host.network_interface[0].nat_ip_address, count.index)}"
    user  = "ubuntu"
    agent = false
    private_key = file(var.private_key)
  }

#  provisioner "file" {
#    content     = templatefile("${path.module}/mongod.conf", { db_url = yandex_compute_instance.db.network_interface.0.ip_address})
#    destination = "/tmp/mongod.conf"
#  }
#  provisioner "remote-exec" {
#    script = "${path.module}/files/deploy.sh"
#  }
}
