resource "digitalocean_volume" "test_volume" {
  region      = "lon1"           # TODO: Make it configurable
  name        = "test-volume"    # TODO: c
  size        = 20               # TODO: c
  description = "Example volume" # TODO: c
}

resource "digitalocean_droplet" "test_server" {
  image              = "30970148"                                # TODO: c
  name               = "test-server"                             # TODO: c
  region             = "lon1"                                    # TODO: c
  size               = "s-1vcpu-2gb"                             # TODO: c
  backups            = false                                     # TODO: c
  monitoring         = false                                     # TODO: c
  ipv6               = false                                     # TODO: c
  private_networking = false                                     # TODO: c
  ssh_keys           = [21715247]                                # TODO: c
  volume_ids         = ["${digitalocean_volume.test_volume.id}"]
}

resource "digitalocean_firewall" "test_firewall" {
  name = "test-firewall" # TODO: c

  droplet_ids = ["${digitalocean_droplet.test_server.id}"]

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
    }
  ]
}
