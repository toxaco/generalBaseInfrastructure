FROM php:5.6-fpm
ENV SSH_KEY id_efc6468efd14481c3db849b88f41b51f
ARG host=172.18.0.1
WORKDIR /var/www/html

# Update Repo
RUN echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list \
     && echo 'APT::Install-Recommends "0";' > /etc/apt/apt.conf.d/99norecommends \
     && apt-get update >/dev/null

# Install
RUN apt-get install -my \
        git \
        vim \
        htop \
        nginx-light \
        ssh-client \
        supervisor \
        wget \
        zip \
        g++ \
	    poppler-utils \
	    gnupg \
	    zlib1g-dev \
	    libicu-dev \
	    libssl-dev \
        libmcrypt-dev \
        libpcre3-dev \
        libcurl4-openssl-dev \
        libxml2-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libmemcached-dev \
        dirmngr --install-recommends \
        net-tools \
        awscli

RUN pecl install mongo
RUN pecl install redis

RUN docker-php-ext-install \
        bcmath \
        mysqli \
        pcntl \
        pdo \
        pdo_mysql \
        zip \
        gd \
        soap \
        intl \
        -j$(nproc) gd

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-configure intl

# Enable Extensions
RUN docker-php-ext-enable \
    mongo \
    redis

# Install MongoDb
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list
RUN apt-get update && apt-get install -y mongodb-org

# Setup php
RUN echo "date.timezone=Europe/London" >  /usr/local/etc/php/conf.d/timezone.ini
RUN echo "upload_max_filesize = 10M;" > /usr/local/etc/php/conf.d/uploads.ini \
    && echo "post_max_size = 11M;" >> /usr/local/etc/php/conf.d/uploads.ini

# Install composer
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/1b137f8bf6db3e79a38a5bc45324414a6b1f9df2/web/installer -O - -q | php -- && cp composer.phar /usr/local/bin/composer

# Install node and npm
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -y nodejs
RUN y|npm i -g webpack && y|npm i -g typescript && y|npm i -g yarn

# Configure sudoers for better dev experience ;-)
RUN echo "Defaults umask=0002" >> /etc/sudoers && echo "Defaults umask_override" >> /etc/sudoers

# Install xdebug (xdebug-2.5.5max version for PHP-5 [06/2018])
# RUN pecl install xdebug-2.5.5
# RUN docker-php-ext-enable xdebug \
#      && sed -i '1 a xdebug.remote_autostart=true' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
#      && sed -i '1 a xdebug.idekey=phpstorm' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
#      && sed -i '1 a xdebug.remote_mode=req' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
#      && sed -i '1 a xdebug.remote_handler=dbgp' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
#      && sed -i '1 a xdebug.remote_connect_back=0 ' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
#      && sed -i '1 a xdebug.remote_port=9000' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
#      && sed -i '1 a xdebug.remote_host=10.254.254.254' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
#      && sed -i '1 a xdebug.remote_enable=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
#      && sed -i '1 a xdebug.max_nesting_level=500' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Install Memcache.
# RUN cd /tmp \
#     && curl -o php-memcache.tgz http://pecl.php.net/get/memcache-3.0.8.tgz \
#     && tar -xzvf php-memcache.tgz \
#     && cd memcache-3.0.8 \
#     && curl -o memcache-faulty-inline.patch http://git.alpinelinux.org/cgit/aports/plain/main/php5-memcache/memcache-faulty-inline.patch?h=3.4-stable \
#     && patch -p1 -i memcache-faulty-inline.patch \
#     && phpize \
#     && ./configure --prefix=/usr \
#     && make INSTALL_ROOT=/ install \
#     && install -d ./etc/php/conf.d \
#     && echo "extension=memcache.so" > /usr/local/etc/php/conf.d/memcache.ini

VOLUME /var/www/html
VOLUME /var/lib/nginx
VOLUME /tmp
VOLUME /tmp/nginx
VOLUME /tmp/nginx/cache
VOLUME /tmp/nginx/fcgicache

# Remove apt cache to make the image smaller
RUN apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get purge -y --auto-remove