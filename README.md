# ubuntu

ubuntu基础镜像封装

说明：

    本镜像内置mysql，只允许内部链接，如需外部链接请查看【mysql相关问题处理】或者网上自行查阅相关资料

## 镜像制作，如非制作请跳至 使用教程

1、创建容器

`docker compose -f setup.yml up`

2、复制容器安装程序
`sh ./setup.sh`

3、创建镜像

4、发布镜像

## 使用教程

1、推荐使用 docker compose 配置如下：

[docker-compose.yml](https://github.com/zys8119/web-monitoring/blob/ubuntu/docker-compose.yml) 或者点击该链接查看

```yaml
version: '3'
services:
  ubuntu-test:
    container_name: ubuntu-test
    image: zys8119/ubuntu:latest
    restart: always
    command: sh ./ubuntu-install.sh
    ports:
      - "80:80"
    volumes:
      # nginx服务配置
      - "./nginx/conf.d:/etc/nginx/conf.d"
      - "./nginx/sites-enabled:/etc/nginx/sites-enabled"
      # 相关日志
      - "./logs/pm2:/root/.pm2/logs/"
      - "./logs/nginx:/var/log/nginx"
```

2、执行compose

`docker compose -f docker-compose.yml up `

## mysql相关问题处理

1、ER_NOT_SUPPORTED_AUTH_MODE: Client does not support authentication protocol requested by server; consider upgrading MySQL client

说明：因内部node服务默认密码为：rootroot， 故下面设置成 rootroot， 如需自定义请自行修改密码及 /node/wisdom.serve.config.js 中的 mysqlConfig 字段

`mysql> alter user 'root'@'localhost' identified with mysql_native_password by 'rootroot';`

2、ER_BAD_DB_ERROR: Unknown database 'system_monitoring_node'

`mysql> CREATE DATABASE IF NOT EXISTS system_monitoring_node;`

3、ER_NO_SUCH_TABLE: Table 'system_monitoring_node.*' doesn't exist

[同步数据库：HTTP GET 请求接口 http://localhost:40030/syncMysqlAuto](http://localhost:40030/syncMysqlAuto)

4、外部工具链接mysql需要开启外部支持

`mysql> update mysql.user set host='%' where user='root';`

`mysql> flush privileges;`

修改mysql配置文件 `vi /etc/mysql/mysql.conf.d/mysqld.cnf` ，找到以下内容并禁用

```yaml
# bind-address          = 127.0.0.1
# mysqlx-bind-address   = 127.0.0.1
```

`service mysql restart`


# liunx 命令

`ps -ax | grep mysql`

`kill p pid`
