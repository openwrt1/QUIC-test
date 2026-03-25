#!/bin/sh

# 设置计划任务：每天凌晨 3 点杀掉 PID 1（即 socat），触发容器退出
echo "0 3 * * * kill 1" > /etc/crontabs/root

# 后台启动 Alpine 内置的 cron 守护进程
crond

# 使用单 -d 参数，仅输出连接提醒（Notice级别），不输出数据收发日志，既轻量又能看到谁连进来了
exec socat -d -T 1800 UDP4-LISTEN:23112,fork,reuseaddr UDP4:162.159.198.1:443