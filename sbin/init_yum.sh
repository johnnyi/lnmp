#!/bin/bash
# Author  : Yi XiaoHui
# MSN     : yxh_benet@hotmail.com
# QQ      : 398774310
# E-Mail  : yxhbenet@vip.qq.com

SRV=http://source.holdlinux.com/soft/linux/yum/epel-release-6-5.noarch.rpm

wget -c -P /usr/local/src ${SRV}
cd /usr/local/src
rpm -Uvh epel-release-6-5.noarch.rpm

yum -y install lrzsz libxml* libevent* libjpeg*  perl-libwww-perl  dialog ntp vim-enhanced vixie-cron gcc gcc-c++ gcc-g77 flex bison autoconf automake glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel libtool* zlib-devel libxml2-devel libjpeg-devel libpng-devel libtiff-devel fontconfig-devel freetype-devel libXpm-devel gettext-devel curl curl-devel pam-devel e2fsprogs-devel krb5-devel libidn libidn-devel openssl openssl-devel openldap openldap-devel net-snmp net-snmp-devel nss_ldap openldap-clients openldap-servers libtidy libtidy-devel glibc* cpan subversion  


