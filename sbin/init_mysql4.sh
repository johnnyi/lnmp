#!/bin/bash
/usr/sbin/groupadd mysql
/usr/sbin/useradd -g mysql -M -s /bin/false mysql

SRV=/usr/local/lnmp/source/mysql-4.1.22.tar.gz 

[ -z ${LOCAL} ] && LOCAL=/usr/local

filename=`basename ${SRV}`
dirname=`echo ${filename} | sed 's/.tar.gz//g'`

[ -d /usr/local/src/${dirname} ] && rm -rf /usr/local/src/${dirname}
tar zxvf /usr/local/lnmp/source/${filename} -C /usr/local/src

cd /usr/local/src/${dirname}

./configure --prefix=/usr/local/mysql4 --without-debug --with-client-ldflags=-all-static --with-mysqld-ldflags=-all-static --enable-assembler --without-isam --with-extra-charsets=gbk,gb2312,utf8 --without-innodb --with-pthread --enable-thread-safe-client --localstatedir=/data/mysql && make && make install


cp support-files/mysql.server /etc/rc.d/init.d/mysqld
cp support-files/my-medium.cnf /etc/my.cnf
chmod 0700 /etc/rc.d/init.d/mysqld

mkdir /data
#cd /usr/local/libexec
#cp mysqld mysqld.backup
#strip mysqld
#/usr/local/bin/mysql_install_db --user=mysql

