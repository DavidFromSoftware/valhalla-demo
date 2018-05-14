# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}


resource "digitalocean_droplet" "web" {
  name   = "34318987"
  size   = "512mb"
  image  = "valhala-snap02"
  region = "nyc1"
  ssh_keys = [19215830]
  user_data = <<EOF
#cloud-config
coreos:
	units:
		- name: 'valhalla.service'
		command: 'start'
		content: |
			[Unit]
			Description=Valhalla Demo
			After=docker.service

			[Service]
			ExecStart=/usr/bin/docker run -d -p 3000:3000 platzi

EOF
}