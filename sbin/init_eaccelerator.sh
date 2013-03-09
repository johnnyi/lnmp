#!/bin/bash
# Author  : Yi XiaoHui
# MSN     : yxh_benet@hotmail.com
# QQ      : 398774310
# E-Mail  : yxhbenet@vip.qq.com

[ -z ${LOCAL} ] && LOCAL=/usr/local

SRV=http://source.holdlinux.com/soft/linux/nginx_php/eaccelerator/eaccelerator-0.9.6.1.tar.bz2

wget -c -P /usr/local/src ${SRV}

filename=`basename ${SRV}`
dirname=`echo ${filename} | sed 's/.tar.bz2//g'`

[ -d /usr/local/src/${dirname} ] && rm -rf /usr/local/src/${dirname}
tar jxf /usr/local/src/${filename} -C /usr/local/src

cd /usr/local/src/${dirname}
/usr/local/php5/bin/phpize

sleep 5
./configure --enable-eaccelerator=shared --with-php-config=/usr/local/php5/bin/php-config

make -j4
make install


