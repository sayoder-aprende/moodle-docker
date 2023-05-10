#!/bin/bash
set -x

cd /var/www/html/
curl https://moodle.org/plugins/download.php/28292/moosh_moodle41_2023010400.zip --output moosh.zip; unzip -o -q moosh.zip; rm -f moosh.zip
cd moosh; ln -f -s $PWD/moosh.php /usr/local/bin/moosh; cd ..;
