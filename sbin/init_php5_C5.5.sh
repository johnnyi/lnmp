#!/bin/bash
# Author  : Yi XiaoHui
# MSN     : yxh_benet@hotmail.com
# QQ      : 398774310
# E-Mail  : yxhbenet@vip.qq.com

[ -z ${LOCAL} ] && LOCAL=/usr/local
SNAME=php-5.3.3.tar.gz
SRV="http://source.holdlinux.com/soft/linux/nginx_php/php/$SNAME"
export CONF=/usr/local/lnmp/conf

echo "============================check files=================================="
if [ -s /usr/local/src/$SNAME ]; then
  echo "$SNAME [found]"
  else
  echo "Error: $SNAME not found!!!download now......"
  wget -c -P /usr/local/src ${SRV}
fi

filename=`basename ${SRV}`
dirname=`echo ${filename} | sed 's/.tar.gz//g'`

[ -d /usr/local/src/${dirname} ] && rm -rf /usr/local/src/${dirname}
tar zxvf /usr/local/src/${filename} -C /usr/local/src
cd /usr/local/src/${dirname}

./configure --prefix=/usr/local/php-5.3.3 --with-config-file-path=/etc --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-iconv-dir=/usr/local --with-libxml-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --disable-rpath --enable-discard-path --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-fastcgi --enable-fpm --enable-force-cgi-redirect --enable-mbstrig --with-mcrypt --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-ldap --with-ldap-sasl

make ZEND_EXTRA_LIBS='-liconv' -j4
make install
/bin/cp -f $CONF/php.ini /etc/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 50M/g' /etc/php.ini
sed -i 's/;date.timezone =/date.timezone = PRC/g' /etc/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 300/g' /etc/php.ini
cd /usr/local/
ln -s /usr/local/php-5.3.3 php5
/bin/cp -f $CONF/php-fpm.conf  /usr/local/php5/etc/php-fpm.conf
echo "/usr/local/php5/sbin/php-fpm " >> /etc/rc.local
ulimit -SHn 51200 
