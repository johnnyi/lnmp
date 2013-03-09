#!/bin/bash
SRV1=/usr/local/lnmp/source/nginx-1.0.14.tar.gz
SRV2=/usr/local/lnmp/source/pcre-8.10.tar.gz
filename1=`basename ${SRV1}`
dirname1=`echo ${filename1} | sed 's/.tar.gz//g'`
filename2=`basename ${SRV2}`
dirname2=`echo ${filename2} | sed 's/.tar.gz//g'`
export CONF=/usr/local/lnmp/conf



[ -z ${LOCAL} ] && LOCAL=/usr/local


[ -d /usr/local/src/${dirname1} ] && rm -rf /usr/local/src/${dirname1}
tar zxvf /usr/local/lnmp/source/${filename1} -C /usr/local/src
tar zxvf /usr/local/lnmp/source/${filename2} -C /usr/local/src

cd /usr/local/src/${dirname1}
./configure --user=www --group=www --prefix=/usr/local/nginx-1.0.14 --with-http_stub_status_module --with-http_ssl_module --with-pcre=/usr/local/src/${dirname2}

make -j4
make install
