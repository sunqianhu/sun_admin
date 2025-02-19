FROM composer as composer

WORKDIR /app

#安装依赖
COPY ./composer.json ./composer.lock .
RUN composer i --no-interaction --ignore-platform-reqs --no-scripts


FROM harbor.reefun.com/reefun/php:8.2-fpm-alpine-supervisord

#构建
WORKDIR /app
COPY . .
COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN composer dump-autoload \
  && chown -R www-data:www-data /app