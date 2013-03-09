#!/bin/bash
# Author  : Yi XiaoHui
# MSN     : yxh_benet@hotmail.com
# QQ      : 398774310
# E-Mail  : yxhbenet@vip.qq.com

[ -z ${LOCAL} ] && LOCAL=/usr/local
/usr/sbin/groupadd mysql
/usr/sbin/useradd -g mysql -M -s /bin/false mysql

#sh /usr/local/lnmp/sbin/init_ncurese.sh

SRV1=http://source.holdlinux.com/soft/linux/nginx_php/mysql/mysql-5.5.8.tar.gz
SRV2=http://source.holdlinux.com/soft/linux/nginx_php/mysql/cmake/cmake-2.8.4.tar.gz
wget -c -P /usr/local/src ${SRV1}
wget -c -P /usr/local/src ${SRV2}



filename1=`basename ${SRV1}`
dirname1=`echo ${filename1} | sed 's/.tar.gz//g'`
filename2=`basename ${SRV2}`
dirname2=`echo ${filename2} | sed 's/.tar.gz//g'`

[ -d /usr/local/src/${dirname2} ] && rm -rf /usr/local/src/${dirname2}
tar zxvf /usr/local/src/${filename2} -C /usr/local/src

cd /usr/local/src/${dirname2}

./configure && make && make install

[ -d /usr/local/src/${dirname1} ] && rm -rf /usr/local/src/${dirname1}
tar zxvf /usr/local/src/${filename1} -C /usr/local/src

cd /usr/local/src/${dirname1}
cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql-5.5.8 -DMYSQL_DATADIR=/data/mysql/3306/data -DSYSCONFDIR=/data/mysql/3306/data/ -DCURSES_LIBRARY=/usr/ncurses/lib/libncurses.a -DCURSES_INCLUDE_PATH=/usr/ncurses/include/ -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DWITH_SSL=yes  -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8-general_ci -DWITH_READLINE=on
gmake
make install

mkdir -p /data/mysql/3306
cd /data/mysql/3306
/bin/cp  /usr/local/lnmp/conf/my_5.5.8.conf /data/mysql/3306/my.cnf 
ln -sv /data/mysql/3306/my.cnf  /etc/my.cnf

mkdir -p /usr/local/mysql-5.5.8/include/mysql
ln -s /usr/local/mysql-5.5.8/include/* /usr/local/mysql-5.5.8/include/mysql/
chown mysql.mysql /data/mysql -R
/usr/local/mysql-5.5.8/scripts/mysql_install_db --basedir=/usr/local/mysql-5.5.8/ --datadir=/data/mysql/3306/data --user=mysql --defaults-file=/data/mysql/3306/my.cnf

cp /usr/local/lnmp/conf/mysqld  /etc/rc.d/init.d/mysqld  > /dev/null 2>&1

chmod 755 /etc/rc.d/init.d/mysqld
chkconfig --add mysqld
/etc/rc.d/init.d/mysqld start > /dev/null 2>&1
chkconfig mysqld on
mkdir -p /data/mysql/3306/logs/binlog/
/bin/chown -R mysql.mysql /data/mysql/3306/logs/
ln -s /usr/local/mysql-5.5.8 /usr/local/mysql
rm -rf /usr/bin/mysql* > /dev/null 2>&1
cd  /usr/local/mysql-5.5.8/bin/
for i in *; do ln -s /usr/local/mysql-5.5.8/bin/$i /usr/bin/$i; done
echo "/usr/local/mysql-5.5.8/lib/" >> /etc/ld.so.conf
ldconfig


/usr/local/mysql/bin/mysqladmin -u root password $mysqlrootpwd

cat > /tmp/mysql_sec_script<<EOF
use mysql;
update user set password=password('$mysqlrootpwd') where user='root';
delete from user where not (user='root') ;
delete from user where user='root' and password=''; 
drop database test;
DROP USER ''@'%';
flush privileges;
EOF

#/usr/local/mysql/bin/mysql -u root -p$mysqlrootpwd -h localhost < /tmp/mysql_sec_script

#rm -f /tmp/mysql_sec_script
