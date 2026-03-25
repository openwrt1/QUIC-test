import socket

LOCAL_HOST = "0.0.0.0"
LOCAL_PORT = 23112  # 和 ClawCloud 上填的 Container Port 一致
REMOTE_HOST = "162.159.192.1"  # Cloudflare WARP 官方接入点
REMOTE_PORT = 2408

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((LOCAL_HOST, LOCAL_PORT))
print(f"UDP Proxy listening on {LOCAL_HOST}:{LOCAL_PORT} -> forwarding to {REMOTE_HOST}:{REMOTE_PORT}", flush=True)

client_addr = None

while True:
    try:
        data, addr = sock.recvfrom(65535)
        
        if addr[0] == REMOTE_HOST and addr[1] == REMOTE_PORT:
            # 收到来自 Cloudflare 的响应数据，转发回本地 WARP 客户端
            if client_addr:
                sock.sendto(data, client_addr)
        else:
            # 收到本地 WARP 客户端的数据，记录客户端地址，并转发给 Cloudflare
            client_addr = addr
            sock.sendto(data, (REMOTE_HOST, REMOTE_PORT))
    except Exception as e:
        print(f"Error: {e}", flush=True)
