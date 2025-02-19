#第一阶段：构建应用
FROM node:lts-alpine as build

#设置工作目录
WORKDIR /app

#下载依赖和构建
COPY . .
RUN npm ci
RUN npm run build

#第二阶段：使用 Nginx 提供静态文件服务
FROM nginx:alpine

#复制构建后的静态文件到 Nginx 默认的静态文件目录
COPY --from=build /app/dist /usr/share/nginx/html

#可选：自定义 Nginx 配置（如果你有特定的需求）
#COPY nginx.conf /etc/nginx/nginx.conf

#暴露端口
EXPOSE 80
EXPOSE 443

#启动 Nginx
CMD ["nginx", "-g", "daemon off;"]