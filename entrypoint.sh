#!/bin/sh

# 设置计划任务：每天凌晨 3 点杀掉 PID 1（即 socat），触发容器退出
echo "0 3 * * * kill 1" > /etc/crontabs/root

# 后台启动 Alpine 内置的 cron 守护进程
crond

# 使用 exec 启动 socat，使其接管 PID 1。这能确保它能正常收到退出信号
# 添加了 -d -d -d 参数来输出连接和断开的详细日志
exec socat -d -d -d -T 1800 UDP4-LISTEN:23112,fork,reuseaddr UDP4:162.159.198.1:443