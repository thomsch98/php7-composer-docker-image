FROM php:7.1.8-fpm-alpine
ENV MEMCACHED_DEPS zlib-dev libmemcached-dev cyrus-sasl-dev git
ENV PHP_INI_DIR /usr/local/etc/php
RUN set -x \
	&& apk add --update --no-cache git imap-dev libmemcached libpng icu libxml2 \
	&& apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS $MEMCACHED_DEPS openssl-dev libxml2-dev \
		libtool pcre-dev libpng-dev icu-dev python \
	&& echo \
	&& ( \
		git clone https://github.com/edenhill/librdkafka.git /usr/src/librdkafka \
		&& cd /usr/src/librdkafka \
		&& ./configure --prefix=/usr \
		&& make -j "$(getconf _NPROCESSORS_ONLN)" \
		&& make install \
	    && rm -rf /usr/src/librdkafka \
		) \
	&& echo \
	&& git clone https://github.com/arnaud-lb/php-rdkafka.git /usr/src/php/ext/php-rdkafka \
    && docker-php-ext-configure /usr/src/php/ext/php-rdkafka \
    && docker-php-ext-install /usr/src/php/ext/php-rdkafka \
    && rm -rf /usr/src/php/ext/php-rdkafka \
	&& echo \
	&& docker-php-ext-install pdo_mysql intl zip sockets gd soap \
	&& echo \
	&& git clone -b php7 https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
    && docker-php-ext-configure /usr/src/php/ext/memcached --disable-memcached-sasl \
    && docker-php-ext-install /usr/src/php/ext/memcached \
    && rm -rf /usr/src/php/ext/memcached \
	&& echo \
	&& docker-php-ext-configure imap --with-imap --with-imap-ssl \
	&& docker-php-ext-install imap \
	&& echo \
	&& pecl channel-update pecl.php.net \
	&& pecl install xdebug mongodb redis apcu msgpack \
	&& docker-php-ext-enable mongodb opcache zip redis apcu sockets gd msgpack intl rdkafka soap \
	&& echo \
	&& apk del .phpize-deps \
	&& echo \
	&& touch /usr/local/etc/php/conf.d/xdebug.ini \
	&& chmod a+w /usr/local/etc/php/conf.d/xdebug.ini \
	&& php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
	&& echo

COPY entrypoint.sh /
COPY etc/* /usr/local/etc/php/

EXPOSE 9000
ENTRYPOINT [ "/entrypoint.sh" ]
VOLUME [ "/app" ]
WORKDIR /app
ENV HOME=/app
USER 1000:1000
