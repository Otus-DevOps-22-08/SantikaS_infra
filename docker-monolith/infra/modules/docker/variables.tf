  variable public_key_path {
  description = "Path to the public key used for ssh access"
}
  variable disk_image {
  description = "Disk image for docker"
  default = "docker-host"
}
  variable subnet_id {
  description = "Subnets for modules"

}
variable private_key_path {
  description = "Path to the privat key used for ssh access"
}

variable instance_count {
  description = "Instance count"
  #default = 1
}
