output "external_ip_address_app" {
  value = yandex_compute_instance.app.network_interface.0.nat_ip_address
 # value = yandex_compute_instance.app.0.network_interface.0.nat_ip_address
}

output "external_ip_address_balancer" {
#  value = "${yandex_lb_network_load_balancer.app.listener[0].external_address_spec.0.address}"
  value = "${[for s in yandex_lb_network_load_balancer.app.listener: s.external_address_spec.*.address].0[0]}"
}
