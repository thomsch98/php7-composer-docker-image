#!/bin/ash

set -e

if [ "$1" == "php" ] ; then
    if [ -n "${PHP_INI}" ] ; then
        shift
        set -- php -c "${PHP_INI}" "$@"
        echo "PHP_INI='${PHP_INI}'. Using as configuration file."
    fi

    if [ -n "${XDEBUG_CONFIG}" ] ; then
    # XDEBUG_CONFIG="remote_host=172.17.0.1 remote_enable=1"

        if [ -n "${PHP_IDE_CONFIG}" ] ; then
        # PHP_IDE_CONFIG="serverName=some-server"
            (echo "${PHP_IDE_CONFIG}" | grep -q serverName) || echo "Warning: PHP_IDE_CONFIG does NOT contain serverName=..."
        fi

        (echo "${XDEBUG_CONFIG}" | grep -q remote_host) && (echo "${XDEBUG_CONFIG}" | grep -q remote_enable) || echo "XDEBUG_CONFIG MUST contain remote_host=... and remote_enable=1"

        echo "zend_extension=xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini
        echo "PHP_IDE_CONFIG='${PHP_IDE_CONFIG}'. XDEBUG_CONFIG='${XDEBUG_CONFIG}'. xdebug ENABLED"
    else
        echo "#zend_extension=xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini
        echo "XDEBUG_CONFIG empty. xdebug DISABLED"
    fi
fi

echo "Now running '$@'" 

exec "$@"
