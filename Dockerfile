FROM php:7.2-apache

#RUN docker-php-ext-install pdo_mysql

RUN apt-get update \
 && apt-get install -y git zlib1g-dev \
 && docker-php-ext-install zip \
 && a2enmod rewrite \
 && sed -i 's!/var/www/html!/var/www/public!g' /etc/apache2/sites-available/000-default.conf \
 && mv /var/www/html /var/www/public \
 && curl -sS https://getcomposer.org/installer \
  | php -- --install-dir=/usr/local/bin --filename=composer \
 && apt-get clean
WORKDIR /var/www


# git, vimのインストール
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y git vim \
 && apt-get clean

# Smartyのインストール
RUN mkdir /usr/local/lib/php/smarty
RUN cd /usr/local/lib/php/smarty \
 && git clone https://github.com/smarty-php/smarty.git \
 && mv smarty/libs . \
 && rm -rf smarty

# composer 1.8.5のインストール
#RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
# && php composer-setup.php --install-dir="/usr/local/bin" --filename="composer" \
# && php -r "unlink('composer-setup.php');"

#apacheの設定変更
# RUN sed -i "s#/var/www/html#/var/www/html/public##" /etc/apache2/sites-available/000-default.conf 

#php.iniの作成とSmartyのPathを通す
RUN sed "s#;include_path = \".:/php/includes\"#include_path = \".:/usr/local/lib/php/smarty/libs/\"##" /usr/local/etc/php/php.ini-production > /usr/local/etc/php/php.ini
