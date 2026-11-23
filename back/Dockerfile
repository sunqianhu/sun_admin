FROM composer:2.5.8 as composer
WORKDIR /app
COPY ./composer.json ./composer.lock .
RUN composer install --no-interaction --ignore-platform-reqs --no-scripts

#环境
FROM sunqianhu/php_nginx:php8235nginx1319
ARG VERSION=dev
WORKDIR /var/www/html

#代码
COPY . .
COPY --from=composer /app/vendor ./vendor
RUN composer dump-autoload --no-dev \
	&& printf '%s\n' "$VERSION" > VERSION \
	&& chown -R www-data:www-data /var/www/html \
	&& rm -rf docker/

#配置
COPY ./docker/.env .
COPY ./docker/nginx.conf /usr/local/nginx-1.31.9/conf/nginx.conf
COPY ./docker/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./docker/php.ini /usr/local/etc/php/php.ini
COPY ./docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80
EXPOSE 443

#启动
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
