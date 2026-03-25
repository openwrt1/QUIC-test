import socket

HOST = "0.0.0.0"
PORT = 23112  # 和 ClawCloud 上填的 Container Port 一致

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((HOST, PORT))
print(f"UDP echo server listening on {HOST}:{PORT}", flush=True)

while True:
    data, addr = sock.recvfrom(65535)
    print(f"received {len(data)} bytes from {addr}: {data!r}", flush=True)
    sock.sendto(data, addr)
