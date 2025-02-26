#composer包
FROM composer:2.5.8 as composer
WORKDIR /app
COPY ./composer.json ./composer.lock .
RUN composer install --no-interaction --ignore-platform-reqs --no-scripts

#环境
FROM sunqianhu/php_nginx:1.0.1
WORKDIR /var/www/html

COPY . .
COPY ./docker/.env .
COPY --from=composer /app/vendor ./vendor
COPY ./docker/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./docker/php.ini /usr/local/etc/php/php.ini
COPY ./docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN composer dump-autoload --no-dev
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
EXPOSE 443

#启动
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]