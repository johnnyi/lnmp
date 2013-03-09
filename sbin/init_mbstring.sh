#!/bin/bash

cd /usr/local/src/php-5.3.3/ext/mbstring/
/usr/local/php5/bin/phpize
./configure --with-php-config=/usr/local/php5/bin/php-config

make -j4
make install


