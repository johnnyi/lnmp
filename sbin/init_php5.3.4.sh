#!/bin/bash
# Author  : Yi XiaoHui
# MSN     : yxh_benet@hotmail.com
# QQ      : 398774310
# E-Mail  : yxhbenet@vip.qq.com

[ -z ${LOCAL} ] && LOCAL=/usr/local
SNAME=php-5.3.4.tar.gz
SRV="http://source.holdlinux.com/soft/linux/nginx_php/php/$SNAME"
SRV2="http://source.holdlinux.com/soft/linux/nginx_php/php/suhosin/suhosin-patch-5.3.4-0.9.10.patch.gz"
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

cd /usr/local/src
wget -c -P /usr/local/src ${SRV2}
gzip -d suhosin-patch-5.3.4-0.9.10.patch.gz

[ -d /usr/local/src/${dirname} ] && rm -rf /usr/local/src/${dirname}
tar zxvf /usr/local/src/${filename} -C /usr/local/src
cp -frp /usr/lib64/libldap* /usr/lib
ln -sv /usr/lib64/mysql/libmysqlclient.so.16.0.0 /usr/lib/libmysqlclient.so.16.0.0
cd /usr/local/src/${dirname}
patch -p 1 -i ../suhosin-patch-5.3.4-0.9.10.patch
./configure --prefix=/usr/local/php-5.3.4 --with-config-file-path=/etc --with-mysql=/usr/local/mysql-5.5.8/ --with-mysqli=/usr/local/mysql-5.5.8/bin/mysql_config --with-iconv-dir=/usr/local --with-libxml-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --disable-rpath --enable-discard-path --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-fastcgi --enable-fpm --enable-force-cgi-redirect --enable-mbstrig --with-mcrypt --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-ldap --with-ldap-sasl

make ZEND_EXTRA_LIBS='-liconv' -j4
make install
/bin/cp -f $CONF/php.ini /etc/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 50M/g' /etc/php.ini
sed -i 's/;date.timezone =/date.timezone = PRC/g' /etc/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 300/g' /etc/php.ini
cd /usr/local/
ln -s /usr/local/php-5.3.4 /usr/local/php5
/bin/cp -f $CONF/php-fpm.conf  /usr/local/php5/etc/php-fpm.conf
/bin/cp -f $CONF/php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm
ulimit -SHn 51200 

