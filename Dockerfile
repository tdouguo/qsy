# 使用官方的node环境作为基础镜像
FROM node:14

# 设置工作目录
WORKDIR /app

# 将package.json和package-lock.json复制到工作目录
COPY package*.json ./

# 安装项目依赖
RUN npm install

# 将项目源代码复制到工作目录
COPY . .

# 构建应用程序
RUN npm run build

# 使用nginx服务器来服务构建的文件
FROM nginx:1.17.1-alpine

# 将构建的文件从builder阶段复制到nginx目录
COPY --from=0 /app/dist /usr/share/nginx/html

# 暴露端口80，使其可以从Docker主机访问
EXPOSE 80

# 启动nginx
CMD ["nginx", "-g", "daemon off;"]
