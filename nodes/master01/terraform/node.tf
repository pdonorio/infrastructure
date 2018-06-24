resource "digitalocean_volume" "master_volume" {
  region      = "${var.region}"
  name        = "${var.volume_name}"
  size        = "${var.volume_size}"
  description = "${var.volume_description}"
}

resource "digitalocean_droplet" "master_server" {
  image              = "${var.droplet_image}"
  name               = "${var.droplet_name}"
  region             = "${var.region}"
  size               = "${var.droplet_size}"
  backups            = "${var.droplet_backups}"
  monitoring         = "${var.droplet_monitoring}"
  ipv6               = "${var.droplet_ipv6}"
  private_networking = "${var.droplet_private_networking}"
  ssh_keys           = "${var.droplet_ssh_keys}"
  volume_ids         = ["${digitalocean_volume.master_volume.id}"]
}

resource "digitalocean_firewall" "master_server_firewall" {
  name = "${var.firewall_name}"

  droplet_ids = ["${digitalocean_droplet.master_server.id}"]

  inbound_rule = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "80"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "443"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]

  outbound_rule = [
    {
      protocol              = "icmp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "tcp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "udp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]
}
