FROM node:24.3.0-alpine as build
WORKDIR /app

COPY . .
RUN npm ci
RUN npm run build

#nginx服务
FROM sunqianhu/php_nginx:php8235nginx1319

WORKDIR /var/www/html
COPY --from=build /app/dist .

EXPOSE 80
EXPOSE 443

COPY docker/nginx.conf /usr/local/nginx-1.31.9/conf/nginx.conf
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
