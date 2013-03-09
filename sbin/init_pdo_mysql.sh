#!/bin/bash
# Author  : Yi XiaoHui
# MSN     : yxh_benet@hotmail.com
# QQ      : 398774310
# E-Mail  : yxhbenet@vip.qq.com

[ -z ${LOCAL} ] && LOCAL=/usr/local

SRV=http://source.holdlinux.com/soft/linux/nginx_php/pdo/PDO_MYSQL-1.0.2.tgz
wget -c -P /usr/local/src ${SRV}


filename=`basename ${SRV}`
dirname=`echo ${filename} | sed 's/.tgz//g'`

[ -d /usr/local/src/${dirname} ] && rm -rf /usr/local/src/${dirname}
tar zxf /usr/local/src/${filename} -C /usr/local/src

cd /usr/local/src/${dirname}
/usr/local/php5/bin/phpize
./configure --with-php-config=/usr/local/php5/bin/php-config --with-pdo-mysql=/usr/local/mysql

make -j4
make install


