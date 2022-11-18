echo "更新apt ---> apt update"
apt update
echo "安装wget ---> apt install wget -y"
apt install wget -y
echo "安装vim ---> apt install vim -y"
apt install vim -y
echo "安装unzip ---> apt install unzip -y"
apt install unzip -y
echo "获取web-monitoring资源 ---> https://github.com/zys8119/web-monitoring/archive/refs/heads/master.zip"
wget https://github.com/zys8119/web-monitoring/archive/refs/heads/master.zip
echo "解压web-monitoring资源 ---> unzip master.zip"
unzip master.zip
echo "拷贝前后端资源 ---> cp -r /web-monitoring-master/web /   &&  cp -r /web-monitoring-master/node / "
cp -r /web-monitoring-master/web /
cp -r /web-monitoring-master/node /
echo "获取node ---> wget https://nodejs.org/dist/v19.1.0/node-v19.1.0-linux-arm64.tar.gz"
wget https://nodejs.org/dist/v19.1.0/node-v19.1.0-linux-arm64.tar.gz
echo "解压node ---> tar -xvf node-v19.1.0-linux-arm64.tar.gz"
tar -xvf node-v19.1.0-linux-arm64.tar.gz
echo "创建node软链接 ---> ln -s /node-v19.1.0-linux-arm64/bin/node /usr/local/bin/node && ln -s /node-v19.1.0-linux-arm64/bin/npm /usr/local/bin/npm"
ln -s /node-v19.1.0-linux-arm64/bin/node /usr/local/bin/node
ln -s /node-v19.1.0-linux-arm64/bin/npm /usr/local/bin/npm
echo "设置npm 淘宝镜像 ---> npm config set registry https://registry.npmmirror.com/"
npm config set registry https://registry.npmmirror.com/
echo "安装pm2 ---> npm i pm2 -g"
npm i pm2 -g
echo "创建pm2软链接 ---> ln -s /node-v19.1.0-linux-arm64/bin/pm2 /usr/local/bin/pm2"
ln -s /node-v19.1.0-linux-arm64/bin/pm2 /usr/local/bin/pm2
echo "安装node服务依赖同时运行本地node服务 ---> cd /node && npm install && pm2 start -n nodeServe npm -- run start && cd /"
cd /node && npm install && pm2 start -n nodeServe npm -- run start && cd /
echo "安装nginx ---> apt install nginx -y"
apt install nginx -y
echo "删除nginx默认配置 ---> rm /etc/nginx/sites-enabled/default"
rm /etc/nginx/sites-enabled/default
echo "复制web前端资源nginx配置 ---> cp /web-monitoring-master/nginx/sites-enabled/web.conf /etc/nginx/sites-enabled/web.conf"
cp /web-monitoring-master/nginx/sites-enabled/web.conf /etc/nginx/sites-enabled/web.conf
echo "启动nginx ---> nginx"
nginx
echo "安装mysql ---> apt install mysql-server -y"
apt install mysql-server -y
echo "mysqld服务挂起 ---> mysqld"
echo "程序已启动完成。"
mysqld
tail -f /dev/null
