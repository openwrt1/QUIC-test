# 使用超轻量的 alpine 作为基础镜像
FROM alpine:latest

# 安装 socat
RUN apk add --no-cache socat

# 暴露你的服务端口 (可以根据需要修改)
EXPOSE 23112/udp

# 默认运行命令，将本地 23112 的 UDP 流量转发到 Cloudflare MASQUE 的 443 端口
CMD ["socat", "UDP4-LISTEN:23112,fork,reuseaddr", "UDP4:162.159.198.1:443"]
