resource "digitalocean_tag" "valhalla_tag" {
  name = "dmz" 
}


resource "digitalocean_droplet" "valhalla_web" {
  count  = 2
	name   = "valhalla-qa${count.index+1}"
	size   = "512mb"
	image  = "35350781"
	region = "nyc1"
	ssh_keys = [19215830]
  tags    = ["${digitalocean_tag.valhalla_tag.id}"]
	user_data = <<-EOF
  #cloud-config
  runcmd:
    - /usr/bin/docker run -d -p 3000:3000 platzi
  EOF
}

resource "digitalocean_loadbalancer" "valhalla_loadbalancer" {
  name = "valhallaloadbalancer"
  region = "nyc1"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 3000
    target_protocol = "http"
  }

  healthcheck {
    port = 3000
    protocol = "http"
    path = "/"
  }

  droplet_tag = "${digitalocean_tag.valhalla_tag.name}"
}