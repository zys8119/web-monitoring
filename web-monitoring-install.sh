echo "更新apt"
apt update
echo "安装vim"
apt install vim -y
echo "安装nodejs"
apt install nodejs -y
echo "安装nginx"
apt install nginx -y
echo "启动nginx"
nginx
echo "服务挂起"
tail -f /dev/null
