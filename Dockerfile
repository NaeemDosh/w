FROM ubuntu:22.04
LABEL author="Radityo P W (radityo.p.w@gmail.com)"
ARG DEBIAN_FRONTEND=noninteractive
# Install PHP 8.2 and other required packages
RUN apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y php8.2
RUN apt-get install -y --no-install-recommends apache2

# Add PHP repository for newer versions
RUN apt-get install -y --no-install-recommends software-properties-common 
#RUN   add-apt-repository ppa:ondrej/php 
RUN  apt-get update && apt-get install software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt install php8.2 -y
RUN apt update
RUN apt update
RUN apt install -y php8.2-cli
RUN apt update
RUN apt install -y php8.2-fpm
RUN apt update
RUN apt install -y php8.2-opcache
RUN apt update
RUN apt install -y php8.2-mbstring
RUN apt install -y php8.2-xml
RUN apt install -y php8.2-zip
RUN apt install -y php8.2-mysql
# Install PHP 8.2 and necessary extensions
RUN apt-get install php8.2 
RUN apt-get install php8.2-cli 
RUN apt-get install php8.2-fpm 
RUN apt-get install php8.2-opcache 
RUN apt-get install   php8.2-mbstring 
RUN apt-get install   php8.2-xml 
RUN apt-get install    php8.2-zip 
RUN apt-get install    php8.2-mysql

# Install additional packages for building PHP ZTS
RUN apt-get install -y --no-install-recommends \
    curl \
    wget \
    gcc \
    make \
    autoconf \
    libc-dev \
    pkg-config \
    libpcre3-dev \
    zlib1g-dev

# Install PHP ZTS support
RUN apt-get install -y --no-install-recommends php8.2-dev

# Enable Apache modules
RUN a2enmod php8.2 rewrite

# Copy HTML files into Apache root directory
COPY html/ /var/www/html/

# Change PHP settings
RUN sed -i \
    -e 's/max_execution_time = .*/max_execution_time = 700/' \
    -e 's/max_input_time = .*/max_input_time = 700/' \
    -e 's/memory_limit = .*/memory_limit = 512M/' \
    /etc/php/8.2/apache2/php.ini

# Expose port 80 for Apache
EXPOSE 80

# Start Apache service
CMD ["apache2ctl", "-D", "FOREGROUND"]
