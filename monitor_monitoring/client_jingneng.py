import time
import requests
import socket
import json

# 配置
SERVER_URL = "http://172.171.2.132:5000/heartbeat"
CLIENT_ID = 'jingneng'  # 使用主机名作为ID（或自定义）

def send_heartbeat():
    """每5秒发送心跳"""
    while True:
        try:
            response = requests.post(
                SERVER_URL,
                json={"client_id": CLIENT_ID},
                timeout=3
            )
            print(f"[{CLIENT_ID}] 心跳成功: {response.text}")
        except Exception as e:
            print(f"[{CLIENT_ID}] 心跳失败: {e}")
        time.sleep(5)

if __name__ == '__main__':
    send_heartbeat()

