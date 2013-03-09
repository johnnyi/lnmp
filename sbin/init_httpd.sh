#!/bin/bash

SRV=/usr/local/lnmp/source/httpd-2.2.3.tar.gz

[ -z ${LOCAL} ] && LOCAL=/usr/local

filename=`basename ${SRV}`
dirname=`echo ${filename} | sed 's/.tar.gz//g'`

[ -d /usr/local/src/${dirname} ] && rm -rf /usr/local/src/${dirname}
tar zxvf /usr/local/lnmp/source/${filename} -C /usr/local/src

cd /usr/local/src/${dirname}/srclib/apr

./configure 

make 
make install
cd ../apr-util
./configure --with-apr=/usr/local/apr
make 
make install
cd ../../
./configure --prefix=/usr/local/apache2 --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr --with-mpm=prefork --enable-so --enable-rewrite=static --enable-track-vars --enable-ssl
make -j4
make install
