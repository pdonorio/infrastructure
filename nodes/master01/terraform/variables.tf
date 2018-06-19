# General variables
variable "do_token" {}

variable "region" {
  default = "lon1"
}

# Volume variables
variable "volume_size" {
  default = 20
}

variable "volume_name" {
  default = "master-volume"
}

variable "volume_description" {
  default = "Master volume"
}

# Droplet variables
variable "droplet_image" {
  default = "30970148"
}

variable "droplet_name" {
  default = "master-server"
}

variable "droplet_size" {
  default = "s-1vcpu-2gb"
}

variable "droplet_backups" {
  default = false
}

variable "droplet_monitoring" {
  default = false
}

variable "droplet_ipv6" {
  default = false
}

variable "droplet_private_networking" {
  default = false
}

variable "droplet_ssh_keys" {
  default = [21715247]
}

# Firewall variables
variable "firewall_name" {
  default = "master-server-firewall"
}
