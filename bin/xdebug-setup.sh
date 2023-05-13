# Install XDebug extension with PECL
./moodle-docker-compose exec webserver pecl install xdebug || exit 1

MOODLE_DOCKER_QUIET=1
hostip=$(./moodle-docker-compose exec webserver bash -c "/sbin/ip route | grep default | cut '-d ' -f 3")

# Set some wise setting for live debugging - change this as needed
read -r -d '' conf <<EOF
; Settings for Xdebug Docker configuration
xdebug.mode = debug
xdebug.client_host = $hostip
xdebug.start_with_request = yes
EOF
./moodle-docker-compose exec webserver bash -c "echo '$conf' > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini"

# Enable XDebug extension in Apache and restart the webserver container
./moodle-docker-compose exec webserver docker-php-ext-enable xdebug
./moodle-docker-compose restart webserver
