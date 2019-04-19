FROM php:7.2-apache

RUN docker-php-ext-install pdo_mysql

#git, vimのインストール
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y git vim \
 && apt-get clean

#Smartyのインストール
RUN mkdir /usr/local/lib/php/smarty
RUN cd /usr/local/lib/php/smarty \
 && git clone https://github.com/smarty-php/smarty.git \
 && mv smarty/libs . \
 && rm -rf smarty

#composer 1.8.5のインストール
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php --install-dir="/usr/local/bin" --filename="composer" \
 && php -r "unlink('composer-setup.php');"
