wget -O /tmp/packer.zip https://releases.hashicorp.com/packer/1.2.4/packer_1.2.4_linux_amd64.zip
wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip /tmp/packer.zip -d ~/bin
unzip /tmp/terraform.zip -d ~/bin
~/bin/packer validate deployments/template.json &&
~/bin/packer build deployments/template.json &&
export TF_VAR_image_id=$(curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITALOCEAN_API_TOKEN" "https://api.digitalocean.com/v2/images?page=1&per_page=3&private=true" | jq ."images[] | select(.name == \"valhalla-snapshot-ubuntu-$CIRCLE_BUILD_NUM\") | .id" )
echo $TF_VAR_image_id
cd infra && ~/bin/terraform init && ~/bin/terraform apply && cd .. &&
git add infra && git commit -m "Deployed $CIRCLE_BUILD_NUM [skip ci]" &&
git push origin master