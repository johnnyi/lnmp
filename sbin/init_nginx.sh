#!/bin/bash
# Author  : Yi XiaoHui
# MSN     : yxh_benet@hotmail.com
# QQ      : 398774310
# E-Mail  : yxhbenet@vip.qq.com

SRV1=http://source.holdlinux.com/soft/linux/nginx_php/nginx/nginx-1.0.14.tar.gz
SRV2=http://source.holdlinux.com/soft/linux/nginx_php/pcre/pcre-8.10.tar.gz

wget -c -P /usr/local/src ${SRV1}
wget -c -P /usr/local/src ${SRV2}

filename1=`basename ${SRV1}`
dirname1=`echo ${filename1} | sed 's/.tar.gz//g'`
filename2=`basename ${SRV2}`
dirname2=`echo ${filename2} | sed 's/.tar.gz//g'`
export CONF=/usr/local/lnmp/conf

echo "${dirname2}"

/usr/sbin/groupadd www -g 58
/usr/sbin/useradd -u 58 -g www www -s /sbin/nologin

[ -z ${LOCAL} ] && LOCAL=/usr/local


[ -d /usr/local/src/${dirname1} ] && rm -rf /usr/local/src/${dirname1}
tar zxvf /usr/local/src/${filename1} -C /usr/local/src
tar zxvf /usr/local/src/${filename2} -C /usr/local/src

cd /usr/local/src/${dirname1}
./configure --user=www --group=www --prefix=/usr/local/${dirname1} --with-http_stub_status_module --with-http_ssl_module --with-pcre=/usr/local/src/${dirname2}

make -j4
make install
if [ -d /data/httpd ] ;then
      echo "that's OK"
  else
      mkdir -p /data/httpd
      mkdir -p /data/log/nginx
      /bin/chown www.www /data -R
fi

/bin/ln -s /usr/local/${dirname1} /usr/local/nginx
/bin/cp -f $CONF/nginx.conf /usr/local/nginx/conf/
mkdir -p /usr/local/nginx/conf/vhosts
/bin/cp -f $CONF/fcgi.conf /usr/local/nginx/conf/
/bin/cp -f $CONF/nginx /etc/init.d/nginx
/bin/chmod +x /etc/init.d/nginx

