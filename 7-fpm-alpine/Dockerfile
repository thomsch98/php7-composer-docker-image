FROM php:7.1.4-fpm-alpine
ENV MEMCACHED_DEPS zlib-dev libmemcached-dev cyrus-sasl-dev git
RUN set -x \
	&& apk add --update --no-cache git imap-dev libmemcached \
	&& apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS $MEMCACHED_DEPS openssl-dev libtool pcre-dev \
	&& pecl channel-update pecl.php.net \
	&& pecl install xdebug mongodb intl zip redis apcu \
	&& docker-php-ext-install pdo_mysql zip sockets \
	&& docker-php-ext-enable mongodb opcache zip redis apcu sockets
RUN git clone -b php7 https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
    && docker-php-ext-configure /usr/src/php/ext/memcached \
        --disable-memcached-sasl \
    && docker-php-ext-install /usr/src/php/ext/memcached \
    && rm -rf /usr/src/php/ext/memcached
RUN docker-php-ext-configure imap --with-imap --with-imap-ssl \
	&& docker-php-ext-install imap \
	&& apk del .phpize-deps \
	&& echo Done
RUN touch /usr/local/etc/php/conf.d/xdebug.ini \
	&& chmod a+w /usr/local/etc/php/conf.d/xdebug.ini \
	&& php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
	&& echo Done 

ADD entrypoint.sh /

EXPOSE 9000
ENTRYPOINT [ "/entrypoint.sh" ]
VOLUME [ "/app" ]
WORKDIR /app
ENV HOME=/app
USER 1000:1000