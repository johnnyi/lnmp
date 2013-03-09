#!/bin/bash
#
PATH=$PATH:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin
#

ftpdb="proftpd"
dbuser="root"
dbpass="duiduila"
dbhost="localhost"
dbport=3306

fpasswd=""
optwrap=""

while [ $# -gt 0 ]; do
        o=$1
        case $o in
                -d) backdir=$2; shift
                ;;
                -u) dbuser=$2; shift
                ;;
                -p) dbpass=$2; shift
                ;;
                -h) dbhost=$2; shift
                ;;
                -P) dbport=$2; shift
                ;;
                -w) optwrap=$2; shift
                ;;
                -f) fpasswd=$2; shift
                ;;
        esac
        shift
done

echo "$fpasswd"
if [ -n "$fpasswd" ]; then
        dbpass=`grep "$dbhost:$dbport:$dbuser" $fpasswd | awk -F: '{print $4}'`
fi

mysql="mysql -u $dbuser -p'$dbpass' -h $dbhost -P $dbport"

SQL="create database if not exists $ftpdb;"
CMD="echo \"$SQL\" | $mysql"
eval $CMD

SQL="create table if not exists $ftpdb.ftpgroups
(
        groupname     varchar(30) NOT NULL, 
        gid           int(11) NOT NULL DEFAULT '1000', 
        members       varchar(255) NOT NULL 
);"
CMD="echo \"$SQL\" | $mysql"
eval $CMD

SQL="create table if not exists $ftpdb.ftpusers
(
  userid       varchar(30) NOT NULL, 
  passwd       varchar(80) NOT NULL, 
  uid          int(10) UNSIGNED NOT NULL DEFAULT '58', 
  gid          int(10) UNSIGNED NOT NULL DEFAULT '58', 
  homedir      varchar(255) NOT NULL, 
  shell        varchar(255) NOT NULL DEFAULT '/sbin/nologin', 
  count        int(10) UNSIGNED NOT NULL DEFAULT '0', 
  host         varchar(30) NOT NULL, 
  lastlogin    varchar(30) NOT NULL, 
  UNIQUE KEY (userid) 
);"
CMD="echo \"$SQL\" | $mysql"
eval $CMD

SQL="create table if not exists $ftpdb.quotalimits
(
  name              varchar(30) DEFAULT NULL, 
  quota_type        enum('user','group','class','all') NOT NULL DEFAULT 'user', 
  per_session       enum('false','true') NOT NULL DEFAULT 'false', 
  limit_type        enum('soft','hard') NOT NULL DEFAULT 'soft', 
  bytes_in_avail    float NOT NULL DEFAULT '0', 
  bytes_out_avail   float NOT NULL DEFAULT '0', 
  bytes_xfer_avail  float NOT NULL DEFAULT '0', 
  files_in_avail    int(10) UNSIGNED NOT NULL DEFAULT '0', 
  files_out_avail   int(10) UNSIGNED NOT NULL DEFAULT '0', 
  files_xfer_avail  int(10) UNSIGNED NOT NULL DEFAULT '0' 
);"
CMD="echo \"$SQL\" | $mysql"
eval $CMD

SQL="create table if not exists $ftpdb.quotatallies
(
  name              varchar(30) NOT NULL, 
  quota_type        enum('user','group','class','all') NOT NULL DEFAULT 'user', 
  bytes_in_used     float NOT NULL DEFAULT '0', 
  bytes_out_used    float NOT NULL DEFAULT '0', 
  bytes_xfer_used   float NOT NULL DEFAULT '0', 
  files_in_used     int(10) UNSIGNED NOT NULL DEFAULT '0', 
  files_out_used    int(10) UNSIGNED NOT NULL DEFAULT '0', 
  files_xfer_used   int(10) UNSIGNED NOT NULL DEFAULT '0' 
);"
CMD="echo \"$SQL\" | $mysql"
eval $CMD

#SQL="INSERT INTO  proftpd.ftpusers VALUES ('test', 'test', 5501, 5500, '/var/www', '/sbin/nologin',0,'','');"
#CMD="echo \"$SQL\" | $mysql"
#eval $CMD

SQL="grant all privileges on proftpd.* to proftpd@'localhost' identified by 'runproftpd';"
CMD="echo \"$SQL\" | $mysql"
eval $CMD
echo "it's insert over!"
