#!/bin/bash
# Author  : Yi XiaoHui
# MSN     : yxh_benet@hotmail.com
# QQ      : 398774310
# E-Mail  : yxhbenet@vip.qq.com

[ -z ${LOCAL} ] && LOCAL=/usr/local
/usr/sbin/groupadd mysql
/usr/sbin/useradd -g mysql -M -s /bin/false mysql

SRV=http://source.holdlinux.com/soft/linux/nginx_php/mysql/mysql-5.1.33.tar.gz
wget -c -P /usr/local/src ${SRV}

filename=`basename ${SRV}`
dirname=`echo ${filename} | sed 's/.tar.gz//g'`

[ -d /usr/local/src/${dirname} ] && rm -rf /usr/local/src/${dirname}
tar zxvf /usr/local/src/${filename} -C /usr/local/src

cd /usr/local/src/${dirname}

./configure --prefix=/usr/local/mysql --without-debug --with-client-ldflags=-all-static --with-mysqld-ldflags=-all-static --enable-assembler --with-extra-charsets=gbk,gb2312,utf8 --with-pthread --enable-thread-safe-client --with-plugins=innobase

make -j4
make install

cd /usr/local/mysql
cp share/mysql/my-medium.cnf /etc/my.cnf
cp share/mysql/mysql.server /etc/init.d/mysqld
chmod +x /etc/init.d/mysqld
/bin/sed -i "s/skip-federated/\#skip-federated/g" /etc/my.cnf
/usr/local/mysql/bin/mysql_install_db --user=mysql
/etc/init.d/mysqld start
chkconfig --add mysqld
chkconfig mysqld on

#/usr/local/mysql/bin/mysqladmin -u root password $mysqlrootpwd

#cat > /tmp/mysql_sec_script<<EOF
#use mysql;
#update user set password=password('$mysqlrootpwd') where user='root';
#delete from user where not (user='root') ;
#delete from user where user='root' and password=''; 
#drop database test;
#DROP USER ''@'%';
#flush privileges;
#EOF

#/usr/local/mysql/bin/mysql -u root -p$mysqlrootpwd -h localhost < /tmp/mysql_sec_script

#rm -f /tmp/mysql_sec_script
