#composer包
FROM composer:2.5.8 as composer
WORKDIR /app
COPY ./composer.json ./composer.lock .
RUN composer install --no-interaction --ignore-platform-reqs --no-scripts

#环境
FROM php:8.2-fpm
WORKDIR /var/www/html

#系统依赖
RUN apt-get update && apt-get install -y \
	libzip-dev \
	zip \
	libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
	nginx \
	supervisor \
	&& docker-php-ext-install pdo pdo_mysql zip gd pcntl\
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY . .
COPY ./docker/.env .
COPY --from=composer /app/vendor ./vendor
RUN composer dump-autoload --no-dev
RUN chown -R www-data:www-data /var/www/html

#Nginx配置文件
COPY ./docker/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
EXPOSE 443

#启动
COPY ./docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]