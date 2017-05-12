# php7-composer-docker-image

php7 installed on top of an Alpine base image.

Additional modules (check with php -m for aomplete list)

- xdebug 
- mongodb 
- intl
- zip 
- redis
- apcu
- pdo_mysql
- sockets
- opcache

Special about this repo, if anything, is the entrypoint.sh file.
If the environment variable XDEBUG_CONFIG is set, the xdebug extension is enabled at container startup 
and the environment variable controls where [xdebug sends its data](https://xdebug.org/docs/remote).

If PHPStorm is being used, or any other IDE that adheres to the [settings of PHP_IDE_CONFIG](https://www.jetbrains.com/help/phpstorm/2017.1/zero-configuration-debugging.html), you can set that variable accordingly.

This helps to use the identical container at development (remote debugging) and production time (no performace impact because of xdebug)
