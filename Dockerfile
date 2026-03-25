# 使用超轻量的 alpine 作为基础镜像
FROM alpine:latest

# 安装 socat
RUN apk add --no-cache socat tzdata

# 设置时区为上海，方便查看正确的日志时间
ENV TZ=Asia/Shanghai

# 暴露你的服务端口 (可以根据需要修改)
EXPOSE 23112/udp

# 将启动脚本复制到镜像中并赋予执行权限
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 默认运行命令，将本地 23112 的 UDP 流量转发到 Cloudflare MASQUE 的 443 端口
CMD ["/entrypoint.sh"]
