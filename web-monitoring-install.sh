echo "更新apt"
apt update
echo "安装wget"
apt install wget -y
echo "安装vim"
apt install vim -y
echo "安装unzip"
apt install unzip -y
echo "安装web-monitoring资源"
wget https://github.com/zys8119/web-monitoring/archive/refs/heads/master.zip
unzip master.zip
cp -r /web-monitoring-master/web /web
cp -r /web-monitoring-master/node /web
echo "安装node"
wget https://nodejs.org/dist/v19.1.0/node-v19.1.0-linux-arm64.tar.gz
tar -xvf node-v19.1.0-linux-arm64.tar.gz
echo "创建软连"
ln -s /node-v19.1.0-linux-arm64/bin/node /usr/local/bin/node
ln -s /node-v19.1.0-linux-arm64/bin/npm /usr/local/bin/npm
echo "设置镜像"
npm config set registry https://registry.npmmirror.com/
echo "安装pm2"
npm i pm2 -g
echo "创建软连"
ln -s /node-v19.1.0-linux-arm64/bin/pm2 /usr/local/bin/pm2
echo "运行本地服务"
cd /node && npm install && pm2 start -n nodeServe npm -- run start && cd /
echo "安装nginx"
apt install nginx -y
echo "删除nginx默认配置"
rm /etc/nginx/sites-enabled/default
cp /web-monitoring-master/nginx/sites-enabled/web.conf /etc/nginx/sites-enabled/web.conf
nginx
echo "安装mysql"
apt install mysql-server -y
echo "服务挂起"
mysqld
tail -f /dev/null
