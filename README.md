# web-monitoring

前端监控平台 docker 镜像

说明：

    1、本镜像代码已加密

    2、本镜像内置mysql，只允许内部链接，如需外部链接请网上自行查阅相关资料

# 镜像制作，如非制作请跳至 使用教程

1、创建容器

`docker compose -f setup.yml up`

2、复制容器安装程序
`sh ./setup.sh`

3、创建镜像

4、发布镜像

## 使用教程

本镜像依赖[web-monitoring](https://github.com/zys8119/web-monitoring)仓库

1、推荐使用 docker compose 配置如下：

[docker-compose.yml](https://github.com/zys8119/web-monitoring/blob/master/docker-compose.yml) 或者点击该链接查看

```yaml
# yaml 配置实例
version: '3'
services:
  web-monitoring:
    container_name: web-monitoring
    image: zys8119/web-monitoring:latest
    restart: always
    command: sh ./web-monitoring-install.sh
    ports:
    # 服务端口
      - "40010:40010"
    # mysql端口
      - "40020:3306"
      # web页面端口
      - "40030:80"
    volumes:
      # 前端资源
      - "./web:/web"
      # 服务资源
      - "./node:/node"
      # nginx服务配置
      - "./nginx/conf.d:/etc/nginx/conf.d"
      - "./nginx/sites-enabled:/etc/nginx/sites-enabled"
      # 其他
      - "./logs/pm2:/root/.pm2/logs/"
      - "./logs/nginx:/var/log/nginx"
```

2、执行compose

`docker compose -f docker-compose.yml up `
