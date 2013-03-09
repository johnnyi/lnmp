#!/bin/bash
# Author  : Yi XiaoHui
# MSN     : yxh_benet@hotmail.com
# QQ      : 398774310
# E-Mail  : yxhbenet@vip.qq.com

[ -z ${LOCAL} ] && LOCAL=/usr/local
SRV=http://source.holdlinux.com/soft/linux/nginx_php/jpegsrc/jpegsrc.v6b.tar.gz

wget -c -P /usr/local/src ${SRV}

filename=`basename ${SRV}`
dirname=`echo ${filename} | sed 's/.tar.gz//g'`

[ -d /usr/local/src/${dirname} ] && rm -rf /usr/local/src/${dirname}
tar zxvf /usr/local/src/${filename} -C /usr/local/src

cd /usr/local/src/${dirname}

./configure --enable-static --enable-shared 
cp /usr/bin/libtool .
make -j4
mkdir -p /usr/local/man/man1/
make install
make install-lib

