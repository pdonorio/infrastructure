resource "digitalocean_volume" "test_volume" {
  region      = "lon1"
  name        = "test-volume"
  size        = 20
}

resource "digitalocean_droplet" "test_server" {
  image = "30970148"
  name = "test-server"
  region = "lon1"
  size = "s-1vcpu-2gb"
  ssh_keys = [21715247]
  volume_ids = ["${digitalocean_volume.test_volume.id}"]
}

resource "digitalocean_firewall" "test_firewall" {
  name = "test-firewall"

  droplet_ids = ["${digitalocean_droplet.test_server.id}"]

  inbound_rule = [
    {
      protocol           = "tcp"
      port_range         = "22"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "tcp"
      port_range         = "80"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "tcp"
      port_range         = "443"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
  ]

  outbound_rule = [
    {
      protocol                = "tcp"
      port_range              = "80"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    }
  ]
}