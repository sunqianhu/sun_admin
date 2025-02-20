#构建应用
FROM node:lts-alpine as build

WORKDIR /app

COPY . .
RUN npm ci
RUN npm run build

#nginx服务
FROM nginx:alpine

WORKDIR /usr/share/nginx/html
COPY --from=build /app/dist .

EXPOSE 80
EXPOSE 443

COPY docker/nginx.conf /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon off;"]