wget -O packer.zip https://releases.hashicorp.com/packer/1.2.4/packer_1.2.4_linux_amd64.zip
unzip packer.zip
./packer validate deployments/template.json
./packer build deployments/template.json