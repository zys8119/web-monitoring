echo "更新apt ---> apt update"
apt update
echo "安装wget ---> apt install wget -y"
apt install wget -y
echo "安装vim ---> apt install vim -y"
apt install vim -y
echo "安装unzip ---> apt install unzip -y"
apt install unzip -y
echo "获取node ---> wget https://nodejs.org/dist/v19.1.0/node-v19.1.0-linux-arm64.tar.gz"
wget https://nodejs.org/dist/v19.1.0/node-v19.1.0-linux-arm64.tar.gz
echo "解压node ---> tar -xvf node-v19.1.0-linux-arm64.tar.gz"
tar -xvf node-v19.1.0-linux-arm64.tar.gz
echo "删除压缩包 ---> rm node-v19.1.0-linux-arm64.tar.gz"
rm node-v19.1.0-linux-arm64.tar.gz
echo "移动node至 /etc/node"
mv node-v19.1.0-linux-arm64.tar.gz /etc/nodejs
echo "创建node软链接 ---> ln -s /etc/nodejs/bin/node /usr/local/bin/node && ln -s /etc/nodejs/bin/npm /usr/local/bin/npm"
ln -s /etc/nodejs/bin/node /usr/local/bin/node
ln -s /etc/nodejs/bin/npm /usr/local/bin/npm
echo "设置npm 淘宝镜像 ---> npm config set registry https://registry.npmmirror.com/"
npm config set registry https://registry.npmmirror.com/
echo "安装pm2 ---> npm i pm2 -g"
npm i pm2 -g
echo "创建pm2软链接 ---> ln -s /etc/nodejs/bin/pm2 /usr/local/bin/pm2"
ln -s /node-v19.1.0-linux-arm64/bin/pm2 /usr/local/bin/pm2
echo "安装nginx ---> apt install nginx -y"
apt install nginx -y
echo "安装mysql ---> apt install mysql-server -y"
apt install mysql-server -y
echo "启动mysql ---> service mysql start"
service mysql start
echo "程序已启动完成。"
tail -f /dev/null
