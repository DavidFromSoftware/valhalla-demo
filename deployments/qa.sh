apt-get update && apt-get install -y node && apt-get install -y curl
npm install -g now
echo 'Deploying...'
URL=$(now --docker -t $NOW_TOKEN)
echo 'running acceptance on $URL'
curl --silent -L $URL