#!/bin/bash

SRV=/usr/local/lnmp/source/php-4.4.4.tar.gz 

[ -z ${LOCAL} ] && LOCAL=/usr/local

filename=`basename ${SRV}`
dirname=`echo ${filename} | sed 's/.tar.gz//g'`

[ -d /usr/local/src/${dirname} ] && rm -rf /usr/local/src/${dirname}
tar zxvf /usr/local/lnmp/source/${filename} -C /usr/local/src

cd /usr/local/src/${dirname}

./configure --prefix=/usr/local/php44 --with-apxs2=/usr/local/apache2/bin/apxs --with-mysql=/usr/local/mysql4 --with-dom --disable-debug --enable-ftp --enable-inline-optimization --enable-safe-mode --enable-track-vars --enable-trans-sid --enable-gd-native-ttf --enable-sockets --enable-mbstring=all --with-zlib-dir=/usr/local

make -j4
make install

cp php.ini-dist /usr/local/lib/php.ini
