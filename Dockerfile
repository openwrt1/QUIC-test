FROM python:3.11-slim

WORKDIR /app

COPY udp_echo.py .

EXPOSE 23112/udp

CMD ["python", "udp_echo.py"]
