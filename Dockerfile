FROM python:3.11-slim

WORKDIR /app

COPY udp_echo.py .

CMD ["python", "udp_echo.py"]
