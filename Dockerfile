# 使用官方基础镜像
FROM nginx:latest

# 设置工作目录
WORKDIR /usr/share/nginx/html

# 复制本地 HTML 文件到容器
COPY html/index.html /usr/share/nginx/html/

# 替换默认 Nginx 配置（可选）
COPY nginx.conf /etc/nginx/nginx.conf

# 暴露端口
EXPOSE 80

# 以非 root 用户运行（安全加固）
RUN adduser --disabled-password --gecos '' appuser && \
    chown -R appuser /usr/share/nginx/html /etc/nginx
USER appuser

# 启动 Nginx
CMD ["nginx", "-g", "daemon off;"]
