#!/bin/bash
# Author  : Yi XiaoHui
# MSN     : yxh_benet@hotmail.com
# QQ      : 398774310
# E-Mail  : yxhbenet@vip.qq.com

[ -z ${LOCAL} ] && LOCAL=/usr/local
SRV1=http://source.holdlinux.com/soft/linux/nginx_php/svn/subversion-1.4.4.tar.gz
SRV2=http://source.holdlinux.com/soft/linux/nginx_php/svn/subversion-deps-1.4.4.tar.gz
wget -c -P /usr/local/src ${SRV1}
wget -c -P /usr/local/src ${SRV2}


filename1=`basename ${SRV1}`
filename2=`basename ${SRV2}`
dirname=`echo ${filename1} | sed 's/.tar.gz//g'`

[ -d /usr/local/src/${dirname} ] && rm -rf /usr/local/src/${dirname}
tar zxvf /usr/local/src/${filename1} -C /usr/local/src
tar zxvf /usr/local/src/${filename2} -C /usr/local/src

cd /usr/local/src/${dirname}

./configure --prefix=/usr/local/svn 

make -j4
make install


