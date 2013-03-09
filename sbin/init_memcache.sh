#!/bin/bash
# Author  : Yi XiaoHui
# MSN     : yxh_benet@hotmail.com
# QQ      : 398774310
# E-Mail  : yxhbenet@vip.qq.com

[ -z ${LOCAL} ] && LOCAL=/usr/local
SRV=http://source.holdlinux.com/soft/linux/nginx_php/memcache/memcache-2.2.5.tgz
wget -c -P /usr/local/src ${SRV}


filename=`basename ${SRV}`
dirname=`echo ${filename} | sed 's/.tgz//g'`

[ -d /usr/local/src/${dirname} ] && rm -rf /usr/local/src/${dirname}
tar zxf /usr/local/src/${filename} -C /usr/local/src

cd /usr/local/src/${dirname}
/usr/local/php5/bin/phpize
./configure --with-php-config=/usr/local/php5/bin/php-config

make -j4
make install


