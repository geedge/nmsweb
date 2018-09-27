#!/bin/bash
#此脚本的功能：自动创建数据库需要的默认表空间、用户以及所需要的权限
#当  前  版 本：1. 0
#作         者：
#日         期：2015.7.8
#
############################################################################################################################################################
#注意事项：
#  1.需以oracle用户身份执行
#  2.手工配置时注意等号两边不能有空格
############################################################################################################################################################
#
#手工配置
#
#
#oracle数据库内用户名以及密码和表空间名称
#
username='nms'
password='"nms"'
tablespaceName='nms'
#oracle数据文件目录,创建默认用户表空间需要
#
OracleDataDir='/data/d4/oradata/ict'
#
#表空间初始化大小
#
TablespaceSize='10M'
#
#表空间每次自动扩长大小
#
TablespaceNextSize='50M'
#
############################################################################################################################################################
#
#检查是不是oracle用户?
#
WhoAmI=`whoami`
if [ "$WhoAmI" != "oracle" ]
then
        echo "Must run this as oracle!"
        exit 2
fi
#
############################################################################################################################################################
#
#创建oracle数据库内用户名以及默认表空间
#
echo "creating user $username..."
#
sqlplus /nolog <<EOF
connect / as sysdba
#alter system set sessions=200 scope=spfile;
#alter system set db_files=65533 scope=spfile;
create bigfile tablespace $tablespaceName datafile'$OracleDataDir/$tablespaceName.dbf' size $TablespaceSize reuse autoextend on next $TablespaceNextSize maxsize unlimited;
create user $username identified by $password default tablespace $tablespaceName quota unlimited on $tablespaceName;
grant dba to $username;
grant create table to $username;
grant create tablespace to $username;
grant drop tablespace to $username;
grant select on v_\$tablespace to $username;
grant select any dictionary to $username;
grant execute on dbms_lock to $username; 			 
exit
EOF
#
echo "Done creating user $username!"
#
############################################################################################################################################################
