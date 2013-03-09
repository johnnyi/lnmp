#!/bin/bash
#Author : Yi Xiaohui
#MSN    : yxh_benet@hotmail.com
#TEL    : 13524060620

 if [ `id -u` -eq 0 ] ; then
    	:
    else
	echo You must be root.
    	exit
 fi

 export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
 export LOCAL=/usr/local
 
 if [ -d /usr/local/lnmp ] ; then
         export export SVNDIR=/usr/local/lnmp
    else
        export SVNDIR=`pwd`
 fi

 
 svn up $ {SVNDIR}
 
 export libiconv_VERSION=libiconv-1.11
 
 chmod +x ${SVNDIR}/sbin/*.sh

 while [ -z ${select} ] ; do
 
     echo "[0] Exit"
     echo "[A] Yum Update"
     echo "[B] Libiconv"
     echo "[C] Freetype"
     echo "[D] Libpng"
     echo "[E] Jpegsrc"
     echo "[F] Libmcrypt"
     echo "[G] Mhash"
     echo "[H] Mcryph"
     echo "[I] Pcre"
     echo "[J] Gd"
     echo "[K] Mysql-5.5.8"
     echo "[L] PHP-5.3.4"
     echo "[M] Nginx"
     echo "[N] Proftpd"
     echo "[O] Svn"
     echo "[P] Mysql+Proftp"
     echo "[Q] Apache"
     echo "[R] Mysql4"
     echo "[S] Php4"
     echo -n ":"

     
     read select 
     case ${select} in
        A)
          ${SVNDIR}/sbin/init_yum.sh
          ;;
        B)
          ${SVNDIR}/sbin/init_libiconv.sh 
          ;;
        C)
          ${SVNDIR}/sbin/init_freetype.sh
          ;;
        D)
          ${SVNDIR}/sbin/init_libpng.sh
          ;;  
        E)
          ${SVNDIR}/sbin/init_jpegsrc.sh
          ;;
        F)
          ${SVNDIR}/sbin/init_libmcrypt.sh
          ;;
        G)
          ${SVNDIR}/sbin/init_mhash.sh
          ;;
        H)
          ${SVNDIR}/sbin/init_mcryph.sh
          ;;
        I)
          ${SVNDIR}/sbin/init_pcre.sh
          ;;
        J)
          ${SVNDIR}/sbin/init_gd.sh
          ;;
        K)
          ${SVNDIR}/sbin/init_mysql_5.5.8.sh
          ;;
        L)
          ${SVNDIR}/sbin/init_php5.3.4.sh
          ;;
        M)
          ${SVNDIR}/sbin/init_nginx.sh
          ;;
        N)
          ${SVNDIR}/sbin/init_proftp.sh
          ;;
        O)
          ${SVNDIR}/sbin/init_svn.sh
          ;;
        P)${SVNDIR}/sbin/init_mysql_ftp.sh
          ;;
        Q)${SVNDIR}/sbin/init_httpd.sh
          ;;
        R)${SVNDIR}/sbin/init_mysql4.sh
          ;;
        S)${SVNDIR}/sbin/init_php4.sh
          ;;
        0)
          :
          ;;
        *)
         echo "Select from underside"
         unset select
         continue
         ;;
    
     esac      



 done

 unset SVNDIR
