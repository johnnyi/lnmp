#!/bin/bash
# Author  : Yi XiaoHui
# MSN     : yxh_benet@hotmail.com
# QQ      : 398774310
# E-Mail  : yxhbenet@vip.qq.com

[ -z ${LOCAL} ] && LOCAL=/usr/local
SRV1=http://source.holdlinux.com/soft/linux/nginx_php/imagick/ImageMagick.tar.gz
SRV2=http://source.holdlinux.com/soft/linux/nginx_php/imagick/imagick-2.3.0.tgz

wget -c -P /usr/local/src ${SRV1}
wget -c -P /usr/local/src ${SRV2}

filename1=`basename ${SRV1}`
dirname1=`echo ${filename1} | sed 's/.tar.gz//g'`

/usr/bin/cpan -i ExtUtils::CBuilder 

[ -d /usr/local/src/${dirname1} ] && rm -rf /usr/local/src/${dirname1}
tar zxf /usr/local/src/${filename1} -C /usr/local/src
cd /usr/local/src/ImageMagick-6.5.1-2
./configure --prefix=/usr
make
make install

filename2=`basename ${SRV2}`
dirname2=`echo ${filename2} | sed 's/.tgz//g'`

[ -d /usr/local/src/${dirname2} ] && rm -rf /usr/local/src/${dirname2}
tar zxf /usr/local/src/${filename2} -C /usr/local/src
cd /usr/local/src/${dirname2}
/usr/local/php5/bin/phpize
./configure --with-php-config=/usr/local/php5/bin/php-config
make -j4
make install
echo "68719476736" >/proc/sys/kernel/shmmax
