FROM php:7.4-apache

RUN apt-get update && apt-get install -y unzip wget

RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql

WORKDIR /var/www/html/

COPY check_db_file.sh /usr/local/bin/check_db_file
RUN chmod +x /usr/local/bin/check_db_file

# use open source version
RUN wget https://www.open3a.de/multiCMSDownload.php?filedl=143 -O open3A.zip

RUN unzip open3A.zip

RUN mkdir startup

RUN chmod 666 system/DBData/Installation.pfdb.php
RUN mkdir system/session && chmod 755 system/session
RUN chown -R www-data:www-data /var/www/html

# copy in specific startup folder for later copy if file not yet existing in mounted folder
RUN cp system/DBData/Installation.pfdb.php startup/Installation.pfdb.php

CMD ["check_db_file"]