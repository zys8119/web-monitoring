apt update
apt install wget -y
apt install vim -y
tar -xvf node-v19.1.0-linux-arm64.tar.gz
ln -s /node-v19.1.0-linux-arm64/bin/node /usr/local/bin/node
ln -s /node-v19.1.0-linux-arm64/bin/npm /usr/local/bin/npm
npm config set registry https://registry.npmmirror.com/
npm i pm2 -g
ln -s /node-v19.1.0-linux-arm64/bin/pm2 /usr/local/bin/pm2
apt install nginx -y
nginx
echo "服务挂起"
tail -f /dev/null
