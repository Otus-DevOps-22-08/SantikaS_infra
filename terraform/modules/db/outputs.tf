output "external_ip_address_db" {
  value = yandex_compute_instance.db.network_interface.0.nat_ip_address
 # value = yandex_compute_instance.app.0.network_interface.0.nat_ip_address
}
output "internal_ip_address_db" {
  value = yandex_compute_instance.db.network_interface.0.ip_address
}
