# php7-composer-docker-image

php7 installed on top of an Alpine base image.

Additional modules (check with php -m for a complete list)

- xdebug 
- mongodb 
- intl
- zip 
- redis
- apcu
- pdo_mysql
- sockets
- opcache
- soap

Special about this repo, if anything, is the entrypoint.sh file.
If the environment variable XDEBUG_CONFIG is set, the xdebug extension is enabled at container startup 
and the environment variable controls where [xdebug sends its data](https://xdebug.org/docs/remote).

If PHPStorm is being used, or any other IDE that adheres to the [settings of PHP_IDE_CONFIG](https://www.jetbrains.com/help/phpstorm/2017.1/zero-configuration-debugging.html), you can set that variable accordingly.

This helps to use the identical container at development (remote debugging) and production time (no performace impact because of xdebug)

As a simple goody, you can set the (absolute) path of the configuration file via enviornment variable `PHP_INI`.

Example for using `PHP_INI`, `XDEBUG_CONFIG` and `PHP_IDE_CONFIG`

    docker run \
        -e PHP_INI=/usr/local/etc/php/php.ini-development \
        -e XDEBUG_CONFIG="remote_host=__debugger_host__ remote_enable=1" \
        -e PHP_IDE_CONFIG="serverName=__some_name__" \
        --rm -it thomsch98/php7-composer php --ini