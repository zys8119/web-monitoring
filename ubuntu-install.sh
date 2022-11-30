echo "更新apt ---> apt update"
apt update

#todo 安装基础工具
echo "安装wget ---> apt install wget -y"
apt install wget -y
echo "安装vim ---> apt install vim -y"
apt install vim -y
echo "安装unzip ---> apt install unzip -y"
apt install unzip -y

#todo 安装nodejs
echo "获取node ---> wget https://nodejs.org/dist/v19.1.0/node-v19.1.0-linux-arm64.tar.gz"
wget https://nodejs.org/dist/v19.1.0/node-v19.1.0-linux-arm64.tar.gz
echo "解压node ---> tar -xvf node-v19.1.0-linux-arm64.tar.gz"
tar -xvf node-v19.1.0-linux-arm64.tar.gz
echo "删除压缩包 ---> rm node-v19.1.0-linux-arm64.tar.gz"
rm node-v19.1.0-linux-arm64.tar.gz
echo "移动node至 /etc/node"
mv node-v19.1.0-linux-arm64 /etc/nodejs
echo "创建node软链接 ---> ln -s /etc/nodejs/bin/node /usr/local/bin/node && ln -s /etc/nodejs/bin/npm /usr/local/bin/npm"
ln -s /etc/nodejs/bin/node /usr/local/bin/node
ln -s /etc/nodejs/bin/npm /usr/local/bin/npm
echo "设置npm 淘宝镜像 ---> npm config set registry https://registry.npmmirror.com/"
npm config set registry https://registry.npmmirror.com/

#todo 安装node脚手架命令
## pm2
echo "安装pm2 ---> npm i pm2 -g"
npm i pm2 -g
echo "创建pm2软链接 ---> ln -s /etc/nodejs/bin/pm2 /usr/local/bin/pm2"
ln -s /etc/nodejs/bin/pm2 /usr/local/bin/pm2
## n
echo "安装pm2 ---> npm i n -g"
npm i n -g
echo "创建pm2软链接 ---> ln -s /etc/nodejs/bin/n /usr/local/bin/n"
ln -s /etc/nodejs/bin/n /usr/local/bin/n
## nrm
echo "安装pm2 ---> npm i nrm -g"
npm i nrm -g
echo "创建pm2软链接 ---> ln -s /etc/nodejs/bin/nrm /usr/local/bin/nrm"
ln -s /etc/nodejs/bin/nrm /usr/local/bin/nrm

#todo 安装nginx
echo "安装nginx ---> apt install nginx -y"
apt install nginx -y
echo "初始化默认配置"
cp /web.conf /etc/nginx/sites-enabled/web.conf
rm /web.conf
echo "启动nginx ---> service nginx start"
service nginx start

#todo 安装mysql
echo "安装mysql ---> apt install mysql-server -y"
apt install mysql-server -y
echo "启动mysql ---> service mysql start"
service mysql start

#todo 程序已启动完成
echo "程序已启动完成。"
tail -f /dev/null
