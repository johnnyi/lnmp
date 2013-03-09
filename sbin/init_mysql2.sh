#!/bin/bash
/usr/sbin/groupadd mysql
/usr/sbin/useradd -g mysql -M -s /bin/false mysql

SRV=/usr/local/lnmp/source/mysql-5.1.33.tar.gz

[ -z ${LOCAL} ] && LOCAL=/usr/local

filename=`basename ${SRV}`
dirname=`echo ${filename} | sed 's/.tar.gz//g'`

[ -d /usr/local/src/${dirname} ] && rm -rf /usr/local/src/${dirname}
tar zxvf /usr/local/lnmp/source/${filename} -C /usr/local/src

cd /usr/local/src/${dirname}

./configure --prefix=/usr/local/mysql --without-debug --with-client-ldflags=-all-static --with-mysqld-ldflags=-all-static --enable-assembler --with-extra-charsets=gbk,gb2312,utf8 --with-pthread --enable-thread-safe-client --with-plugins=innobase

make -j4
make install

