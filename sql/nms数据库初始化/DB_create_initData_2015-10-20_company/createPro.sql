--------------------------------------------
-- Export file for user NMST              --
-- Created by dell on 2015/7/14, 16:12:37 --
--------------------------------------------

spool createPro-clean.log

prompt
prompt Creating procedure PRO_CREATEINDEX
prompt ==================================
prompt
create or replace procedure pro_createIndex(tabName IN VARCHAR2,fileds IN VARCHAR2) is
---
     c_log_table_name              CONSTANT VARCHAR2(100) :='PRO_EXEC_LOG'; --日志记录在此表内
     c_cur_pro_name                CONSTANT VARCHAR2(100) :='pro_createIndex'; --当前存储过程的名称
---
     v_log_table_sql               VARCHAR2(5000);
     sposition1                    INTEGER;
     sposition2                    INTEGER;
     mysubstr                      VARCHAR2(100);
     starttimes                    INTEGER;
     splitStr                      VARCHAR2(10);
     v_sql1                        VARCHAR2(100);
begin
        starttimes := 1;
        sposition1 := 1;
        splitStr := ':';
        loop
            sposition2 := instr(fileds, splitStr, 1, starttimes);
            mysubstr   := substr(fileds, sposition1, sposition2 - sposition1);

            if mysubstr is null
            then
               exit;
            end if;

            v_sql1:='create index '||tabName||'_'||starttimes ||' on '||tabName||'('||mysubstr||') local';
            EXECUTE IMMEDIATE v_sql1;

            sposition1 := sposition2 + 1;
            starttimes := starttimes + 1;
            dbms_output.put_line(mysubstr);

            exit when sposition2 = 0;
        end loop;
        dbms_output.put_line('end');

EXCEPTION
       WHEN OTHERS THEN
       BEGIN
           ROLLBACK;
           v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''-1'',''error:'||SQLERRM||''')';
           EXECUTE IMMEDIATE v_log_table_sql;
           COMMIT;
       END;
end;
/

prompt
prompt Creating procedure PRO_CREATESEQ
prompt ================================
prompt
create or replace procedure pro_createSeq(tabName IN VARCHAR2) is
---
     c_log_table_name              CONSTANT VARCHAR2(100) :='PRO_EXEC_LOG'; --日志记录在此表内
     c_cur_pro_name                CONSTANT VARCHAR2(100) :='pro_createSeq'; --当前存储过程的名称
---
     v_log_table_sql               VARCHAR2(5000);
     v_sql1                        VARCHAR2(5000);
begin
    v_sql1 :='create sequence SEQ_'||tabName||'
              minvalue 1
              maxvalue 999999999999
              start with 1
              increment by 1
              cache 20
              cycle
              order';
    --将创建seq的sql语句存入日志表
    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''1'',''1.创建SEQ的SQL语句:'||v_sql1||''')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;

    EXECUTE IMMEDIATE v_sql1;

EXCEPTION
       WHEN OTHERS THEN
       BEGIN
           ROLLBACK;
           v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''-1'',''error:'||SQLERRM||''')';
           EXECUTE IMMEDIATE v_log_table_sql;
           COMMIT;
       END;
end pro_createSeq;
/

prompt
prompt Creating procedure PRO_CREATETABLE
prompt ==================================
prompt
create or replace procedure pro_createTable(tabName IN VARCHAR2,filedAndType IN VARCHAR2,indexfileds in varchar2)
--create or replace procedure pro_createTable
Authid Current_User----使存储过程可以使用role权限
is
 v_sql1            VARCHAR2(5000);
 v_sql2            VARCHAR2(500);
 C_DATE            VARCHAR2(64);
 tempstr           VARCHAR2(64);
 v_date            VARCHAR2(64);
 --tabName  VARCHAR2(100);
 --filedAndType  VARCHAR2(1000);
 --indexfileds varchar2(1000);
begin
-- tabName:='DI_RST_FD';
-- filedAndType:='rst_fd_log Number';
-- indexfileds:='data_check_time:seq_id:detection_set_info_id:rst_fd_log:';
--获取系统当前年
select to_char(sysdate, 'yyyy') into C_DATE from dual;
--获取系统当前时间是本年第周
select to_char(sysdate, 'iw')  into tempstr from dual;
--获取当前日期字符串
--select to_char(sysdate, 'yyyy-MM-dd HH24:MI:SS')  into v_date from dual;
--获取当前日期的下周第一天
select to_char(trunc(sysdate+7,'d'),'yyyy-MM-dd HH24:MI:SS') into v_date from dual;
--v_sql1 := 'create table dxytest(detection_info_id number not null primary key,testid Number,data_check_time DATE,data_arrive_time DATE,data_check_time_digital number,data_arrive_time_digital number,foreign KEY(detection_info_id) REFERENCES detection_info(id))partition by range(DATA_CHECK_TIME)(partition di_2012w35 values less than(to_date(''2012-08-29 09:35:34'',''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) tablespace di_2012w35 storage(initial 10M next 10M maxextents unlimited ))';
v_sql1 :='create table '||tabName ||'(detection_info_id number not null primary key,'||filedAndType||',DETECTIONED_STATE varchar(2),SEQ_ID number,DETECTION_SET_INFO_ID number,data_check_time DATE,data_arrive_time DATE,data_check_time_digital number,data_arrive_time_digital number)'||
'partition by range(DATA_CHECK_TIME)'||'(partition DI_W'||C_DATE||''||tempstr||' values less than(to_date('''||v_date||''',''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) tablespace di_w'||C_DATE||tempstr||' storage(initial 10M next 10M maxextents unlimited ))';
--v_sql1 :='create table '||tabName ||'(detection_info_id number not null primary key,'||filedAndType||',DETECTIONED_STATE varchar(2),SEQ_ID number,DETECTION_SET_INFO_ID number,data_check_time DATE,data_arrive_time DATE,data_check_time_digital number,data_arrive_time_digital number,foreign KEY(detection_info_id) REFERENCES detection_info(id))'||
--'partition by range(DATA_CHECK_TIME)'||'(partition DI_W'||C_DATE||''||tempstr||' values less than(to_date('''||v_date||''',''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) tablespace di_w'||C_DATE||tempstr||' storage(initial 10M next 10M maxextents unlimited ))';
dbms_output.put_line(v_sql1);
EXECUTE IMMEDIATE v_sql1;
--创建seq 使用detection_info_id为主键故不再创建Seq
--pro_createSeq(tabName);
--创建触发器 使用detection_info_id为主键故不再创建主键触发器
--pro_createTrigger(tabName);
--创建索引
pro_createindex(tabName,indexfileds);
EXCEPTION
WHEN OTHERS THEN
v_sql2 :='insert into PROCEDURE_LOG(ID,PRO_NAME,PRO_SQL,ER_INFO) values(null,''pro_createTable'','||v_sql1||','||sqlerrm||')';
   EXECUTE IMMEDIATE v_sql2;
   dbms_output.put_line(sqlerrm);
ROLLBACK;
end pro_createTable;
/

prompt
prompt Creating procedure PRO_CREATETRIGGER
prompt ====================================
prompt
create or replace procedure pro_createTrigger(tabName IN VARCHAR2) is
---
     c_log_table_name              CONSTANT VARCHAR2(100) :='PRO_EXEC_LOG'; --日志记录在此表内
     c_cur_pro_name                CONSTANT VARCHAR2(100) :='pro_createTrigger'; --当前存储过程的名称
---
     v_log_table_sql               VARCHAR2(5000);
     v_sql1                        VARCHAR2(5000);
begin
    v_sql1 :='Create Or Replace Trigger B_I_'||tabName ||' before insert on '||tabName||' for each row
              declare

              begin
              if ( :new.id is null )   --insert
              then
                   select seq_'||tabName ||'.nextVal into :new.id from dual;
              end if;
                   end B_I_'||tabName||';';
    --将创建触发器的sql语句存入日志表
    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''1'',''1.创建触发器的SQL语句:'||v_sql1||''')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;

    EXECUTE IMMEDIATE v_sql1;

EXCEPTION
    WHEN OTHERS THEN
       BEGIN
           ROLLBACK;
           v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''-1'',''error:'||SQLERRM||''')';
           EXECUTE IMMEDIATE v_log_table_sql;
           COMMIT;
       END;
end pro_createTrigger;
/

prompt
prompt Creating procedure PRO_RECORD_LOG_INFO
prompt ======================================
prompt
create or replace procedure PRO_RECORD_LOG_INFO(proname in VARCHAR2, sequence in VARCHAR2,log_cont in VARCHAR2)
is
-------------------------------------------------------------------------
--可配置
   c_log_table_name         CONSTANT VARCHAR2(100) :='PRO_EXEC_LOG'; --日志记录在此表内
-------------------------------------------------------------------------
--变量
   v_log_table_sql          VARCHAR2(2000);----记录日志sql语句
   v_log_id                 NUMBER;----日志记录编号
   v_log_cont               VARCHAR2(2000);----用于存放过滤特殊字符后的日志信息
   pragma autonomous_transaction;----自治事务（在父存储过程回滚的时候，仍可以记录日志信息）
begin
   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   v_log_cont :=replace(log_cont,'''','"');--对单引号特殊字符进行过滤
   v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES('||v_log_id||','''||proname||''','''||sequence||''','''||v_log_cont||''')';
   EXECUTE IMMEDIATE v_log_table_sql;
   COMMIT;
end PRO_RECORD_LOG_INFO;
/

prompt
prompt Creating procedure PRO_CREATE_TABLESPACE
prompt ========================================
prompt
create or replace procedure pro_create_tablespace(spaceName IN VARCHAR2,spacePath IN VARCHAR2)
Authid Current_User----使存储过程可以使用role权限
 is
-------------------------------------------------
--可配置
     c_cur_pro_func_desc           CONSTANT VARCHAR2(100) :='pro_create_tablespace'; --当前存储过程的功能描述
     c_init_size                   CONSTANT VARCHAR2(10) :='100M';--表空间初始大小
     c_next_size                   CONSTANT VARCHAR2(10) :='10M';--表空间扩展大小
--变量
     space_sql                     VARCHAR2(5000);
     isExist                       INT;--记录是否存在

-------------------------------------------------
begin
-------------------------------------------------
    --查看表空间是否存在
    space_sql:='select count(*)  from user_tablespaces t where t.tablespace_name='''||spaceName||'''';
    execute immediate space_sql into isExist;
    
    --表空间不存在，则创建
    if isExist=0 then
       space_sql :='create tablespace '||spaceName||' datafile '''||spacePath||''' size '||c_init_size||' autoextend on next '||c_next_size||' maxsize unlimited ';
       EXECUTE IMMEDIATE space_sql;
    else
       PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'','tablespace:'||spaceName||' is exist');
    end if;
-------------------------------------------------
EXCEPTION 
    WHEN OTHERS THEN
    BEGIN
         ROLLBACK;
         PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'-1','error:'||SQLERRM);
    END;
end pro_create_tablespace;
/

prompt
prompt Creating procedure PRO_DEL_ONE_PART
prompt ===================================
prompt
create or replace procedure pro_del_one_part(v_table_name IN VARCHAR2,v_par_sequence IN VARCHAR2,v_partition_name IN VARCHAR2)
Authid Current_User----使存储过程可以使用role权限
AS
-------------------------------------------------------------------------------------------------------------

--此过程的功能
--每次执行可以自动删除分区，删除指定的表空间
--当前版本：1. 0
--作         者：hyx
--日         期：2013.11.01
---
-------------------------------------------------------------------------------------------------------------
--变量声明
   --c_table_name_prefix      CONSTANT VARCHAR2(100) :=''; ----表空间名前缀（注意：一定要大写）
   c_cur_pro_name           CONSTANT VARCHAR2(100) :='pro_del_part_by_day'; --当前存储过程的名称
-------------------------------------------------------------------------------------------------------------
   v_del_partition_sql      VARCHAR2(2000); --删除分区sql语句

-------------------------------------------------------------------------------------------------------------
BEGIN

   ----------------------------------------------------------

   PRO_RECORD_LOG_INFO(c_cur_pro_name,v_par_sequence||'3','3.删除'||v_table_name||'表分区 begin');

   ----删除指定表分区
   v_del_partition_sql := 'alter table '||v_table_name||' drop partition '||v_partition_name||' update indexes';

   execute immediate v_del_partition_sql;

   PRO_RECORD_LOG_INFO(c_cur_pro_name,v_par_sequence||'4','4.删除'||v_table_name||'表分区 end');

   -------------------------- --------------------------------

EXCEPTION
    --异常处理机制，记录相关的ora错误号以及相关异常信息
    WHEN OTHERS THEN
    BEGIN
         ROLLBACK;
         PRO_RECORD_LOG_INFO(c_cur_pro_name,'-1','error:'||SQLERRM);

    END;
END pro_del_one_part;
/

prompt
prompt Creating procedure PRO_DEL_PARTITIONS
prompt =====================================
prompt
create or replace procedure PRO_DEL_PARTITIONS(v_par_sequence IN VARCHAR2,v_cur_sql IN VARCHAR2)
Authid Current_User----使存储过程可以使用role权限
is
--------------------------------------------------------------
--可配置
  c_cur_pro_name                CONSTANT VARCHAR2(100) :='PRO_DEL_PARTITIONS'; --当前存储过程的名称

--变量
  v_table_name                  VARCHAR2(2000); --表名
  v_partition_name              VARCHAR2(2000); --表分区名
  v_sequence_count              NUMBER :=0; --此存储过程的步骤编号
  v_full_sequence               VARCHAR2(100);--步骤编号全称
--游标
  type cur_type is ref cursor;
  cur cur_type;
  CT_COLUMNS  user_tab_partitions%ROWTYPE;--定义CT_COLUMNS：表名%rowtype 或者游标名%rowtype
--------------------------------------------------------------
BEGIN
  OPEN cur for v_cur_sql;

    LOOP
      v_sequence_count := v_sequence_count + 1;
      FETCH cur INTO CT_COLUMNS;
      EXIT WHEN cur%NOTFOUND;
--------------------------------------------------------------
          v_table_name :=CT_COLUMNS.table_name;--表名
          v_partition_name :=CT_COLUMNS.partition_name;--表分区名

          v_full_sequence := v_par_sequence||v_sequence_count;

          PRO_RECORD_LOG_INFO(c_cur_pro_name,v_full_sequence,v_sequence_count||'.删除'||v_table_name||'表指定的表空间和表分区 begin');


          --删除detection_info表指定的表空间和表分区
          pro_del_one_part(v_table_name,v_full_sequence||'_',v_partition_name);

          v_sequence_count := v_sequence_count + 1;
          v_full_sequence := v_par_sequence||v_sequence_count;

          PRO_RECORD_LOG_INFO(c_cur_pro_name,v_full_sequence,v_sequence_count||'.删除'||v_table_name||'表指定的表空间和表分区 end');

--------------------------------------------------------------
    END LOOP;
  CLOSE cur;
  EXCEPTION
      --异常处理机制，记录相关的ora错误号以及相关异常信息
      WHEN OTHERS THEN
         BEGIN
           ROLLBACK;
           PRO_RECORD_LOG_INFO(c_cur_pro_name,'-1','error:'||SQLERRM);
         END;
END PRO_DEL_PARTITIONS;
/

prompt
prompt Creating procedure PRO_EXTEND_PARTITION
prompt =======================================
prompt
create or replace procedure pro_extend_partition(spaceName IN VARCHAR2,partstr IN VARCHAR2)
Authid Current_User----使存储过程可以使用role权限
is
-------------------------------------------------------------
--可配置
     c_cur_pro_func_desc           CONSTANT VARCHAR2(100) :='pro_extend_partition'; --当前存储过程的功能描述
-------------------------------------------------------------
--变量
     space_sql                     VARCHAR2(5000);
     isExist                       INT;--记录是否存在
-------------------------------------------------------------  
--游标
     --从监测类别定义表中查询出已经创建的自定义监测类别表
     Cursor cur is
             select cti.table_name  extendtabName
             from check_type_info cti where cti.crete_state = 0;
     CT_COLUMNS cur%ROWTYPE;
-------------------------------------------------------------
begin
     OPEN cur();
         LOOP
              FETCH cur INTO CT_COLUMNS;
              EXIT WHEN cur%NOTFOUND;
                   --查看表分区是否存在
                   space_sql:='select count(*)  from user_tab_partitions utp where  utp.table_name = '''||CT_COLUMNS.extendtabName||''' and partition_name='''||spaceName||'''' ;
                   execute immediate space_sql into isExist;
                    
                   --表分区不存在，则创建
                   if isExist=0 then
                       space_sql :='alter table '||CT_COLUMNS.extendtabName||' add partition '||spaceName||' values less than ('||partstr||')
                                   tablespace '||spaceName||' storage(initial 5m next 100k minextents 1 maxextents unlimited pctincrease 0)';
                       EXECUTE IMMEDIATE space_sql;
                   else
                       PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'','talbe:'||CT_COLUMNS.extendtabName||'-partition:'||spaceName||' is exist');
                   end if;
         END LOOP;
     CLOSE cur;
-------------------------------------------------------------
EXCEPTION --异常处理机制，记录相关的ora错误号以及相关异常信息
    WHEN OTHERS THEN
    BEGIN
         ROLLBACK;
         PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'-1','error:'||SQLERRM);
    END;
-------------------------------------------------------------
end pro_extend_partition;
/

prompt
prompt Creating procedure PRO_EXTEND_TABLE_PARTITION
prompt =============================================
prompt
create or replace procedure pro_extend_table_partition(spaceName IN VARCHAR2,partstr IN VARCHAR2,tableName IN VARCHAR2)
Authid Current_User----使存储过程可以使用role权限
is
-------------------------------------------------------------
--可配置
     c_cur_pro_func_desc           CONSTANT VARCHAR2(100) :='pro_extend_table_partition'; --当前存储过程的功能描述
--变量
     space_sql                     VARCHAR2(5000);
     isExist                       INT;--记录是否存在
-------------------------------------------------------------
begin
   --查看表分区是否存在
   space_sql:='select count(*)  from user_tab_partitions utp where  utp.table_name = '''||tableName||''' and partition_name='''||spaceName||'''' ;
   execute immediate space_sql into isExist;
                    
   --表分区不存在，则创建
   if isExist=0 then
        space_sql :='alter table '||tableName||' add partition '||spaceName||' values less than ('||partstr||')
                    tablespace '||spaceName||' storage(initial 5m next 100k minextents 1 maxextents unlimited pctincrease 0)';
        EXECUTE IMMEDIATE space_sql;
   else
       PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'','talbe:'||tableName||'-partition:'||spaceName||' is exist');
   end if;
      
EXCEPTION 
    WHEN OTHERS THEN
    BEGIN
         ROLLBACK;
         PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'-1','error:'||SQLERRM);
    END;
end pro_extend_table_partition;
/

prompt
prompt Creating procedure PRO_DRIVER_ADD_PARTITION
prompt ===========================================
prompt
create or replace procedure pro_driver_add_Partition
Authid Current_User----使存储过程可以使用role权限
IS
-------------------------------------------------------------------------------------------------------------

--此过程的功能:
--      每次执行可以自动生成制定的表空间，自动添加分区(已存在的表空间和分区，不再创建)
--  1.创建表空间
--  2.为固定表增加表分区 :DETECTION_INFO_WARNING、DI_SYSTEMINFO_DISK、DI_SYSTEMINFO_NET、DETECTION_INFO
--  3.为动态表增加分区：从监测类别定义表中查询出已经创建的自定义监测类别表
--当 前 版 本：1. 0
--作       者：hyx
--日       期：2013.10.31
-------------------------------------------------------------------------------------------------------------
---可配置
   c_add_part_time               CONSTANT NUMBER :=1;--指定创建下几周的表分区（默认为1：创建下周的表分区；0：创建当前周的表分区）
   c_cur_pro_func_desc           CONSTANT VARCHAR2(100) :='addPartitonByTime'; --当前存储过程的功能描述   
---
-------------------------------------------------------------------------------------------------------------
---变量
   v_oracle_data_dir             VARCHAR2(200); --表空间文件存放的路径
   v_table_name                  VARCHAR2(2000); --表名--表名一定要大写
   v_cur_year_week               VARCHAR2(20); --本周所属年及本周为第几周
   end_date                      VARCHAR2(20); --本周结束时间
   tempstr                       VARCHAR2(100); --分区名称
   space_path                    VARCHAR2(500); --分区文件存放路径
   space_sql                    VARCHAR2(500); 
---
-------------------------------------------------------------------------------------------------------------

BEGIN
-----------------------------------------------------------
-- 获取表空间路径
-----------------------------------------------------------
   execute immediate 'SET ROLE ALL';--启用当前用户的所有角色
   space_sql:='select  distinct substr(FILE_NAME,1,instr(FILE_NAME,''/'',''-1'',1))  from dba_data_files t where t.tablespace_name = ''USERS''';--users为默认用户表空间
   execute immediate  space_sql into v_oracle_data_dir;
-----------------------------------------------------------
--计算新增分区时间范围，生成分区名称：DI_W+年+周（未考虑年末年初的特殊情况，可能会得到如2014年12月31日为2014年的第一周，实际应该为2015年第一周）
-----------------------------------------------------------   

   --获取下一周所在的年及所在的周（iw是从周一到周日算一周，每年的第一个星期一为第一周）（IYYY及IW为iso的标准，YYYY及WW为oracle的标准，使用要统一）
   select to_char(sysdate+7*c_add_part_time, 'IYYYIW') into v_cur_year_week from dual;
   --获取下下周的第一天（为了获得新建分区的时间范围：小于此时间）（trunc：是从周日到周六为一周；'d':获取时间所在周的第一天，即周日，但是iw每周的第一天则是周一，所以需要加1）
   select to_char(trunc(sysdate+7+7*c_add_part_time,'d')+1,'yyyy-mm-dd') into end_date from dual;
   --拼写分区名称
   tempstr := 'DI_W'||v_cur_year_week;
   --拼写分区文件名
   space_path := v_oracle_data_dir||tempstr||'.dbf';
   
-----------------------------------------------------------
--创建表空间
-----------------------------------------------------------
   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'1','1.创建表空间 begin');

   pro_create_tablespace(tempstr,space_path);
  
   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'2','2.创建表空间 end');
      
-----------------------------------------------------------
--为固定表增加表分区   
-----------------------------------------------------------
   v_table_name :='DETECTION_INFO_WARNING';
   
   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'3','3.为'||v_table_name||'表创建表空间和表分区 begin');

   pro_extend_table_partition(tempstr,'to_date('''||end_date||' 00:00:00'',''SYYYY-MM-DD HH24:MI:SS'')',v_table_name);

   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'4','4.为'||v_table_name||'表创建表空间和表分区 end');

-----------------------------------------------------------
   v_table_name :='DI_SYSTEMINFO_DISK';
   
   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'5','5.为'||v_table_name||'表创建表空间和表分区 begin');

   pro_extend_table_partition(tempstr,'to_date('''||end_date||' 00:00:00'',''SYYYY-MM-DD HH24:MI:SS'')',v_table_name);

   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'6','6.为'||v_table_name||'表创建表空间和表分区 end');
   
-----------------------------------------------------------
   v_table_name :='DI_SYSTEMINFO_NET';

   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'7','7.为'||v_table_name||'表创建表空间和表分区 begin');

   pro_extend_table_partition(tempstr,'to_date('''||end_date||' 00:00:00'',''SYYYY-MM-DD HH24:MI:SS'')',v_table_name);

   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'8','8.为'||v_table_name||'表创建表空间和表分区 end');
   
-----------------------------------------------------------
   v_table_name :='DETECTION_INFO';
   
   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'9','9.为'||v_table_name||'表创建表空间和表分区 begin');

   pro_extend_table_partition(tempstr,'to_date('''||end_date||' 00:00:00'',''SYYYY-MM-DD HH24:MI:SS'')',v_table_name);

   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'10','10.为'||v_table_name||'表创建表空间和表分区 end');
   
-----------------------------------------------------------
--为动态表增加分区
-----------------------------------------------------------
   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'11','11.创建表空间，并为动态表创建分区 begin');

   pro_extend_partition(tempstr,'to_date('''||end_date||' 00:00:00'',''SYYYY-MM-DD HH24:MI:SS'')');
   
   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'12','12.创建表空间，并为动态表创建分区 end');

-----------------------------------------------------------

EXCEPTION
    --异常处理机制，记录相关的ora错误号以及相关异常信息
    WHEN OTHERS THEN
    BEGIN
         ROLLBACK;
         PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'-1','error:'||SQLERRM);
    END;
END;
/

prompt
prompt Creating procedure PRO_DRIVER_DEL_PARTITION
prompt ===========================================
prompt
create or replace procedure pro_driver_del_Partition
Authid Current_User----使存储过程可以使用role权限
is
------------- ----------------------------------------
--功能：删除指定周的表空间和分区（分区名称来自user_tab_partitions表）
--   1.删除动态表分区
--   2.删除detection_info表分区（有外键）
--   3.删除表空间
------------- ----------------------------------------
--可配置
     c_cur_pro_func_desc      CONSTANT VARCHAR2(100) :='delPartitonByTime'; --当前存储过程的功能描述
     c_week                   CONSTANT NUMBER :=7;----指定删除多少周的分区和表空间（0：删除当前周的表空间及分区；1：删除一周之前的表空间及分区；-1：删除一周之后的表空间及分区）
---
     v_del_date               VARCHAR2(200);----需要删除分区的日期
     v_cur_sql                VARCHAR2(2000);----游标sql
     v_table_name             VARCHAR2(2000); --表名
     v_tablespace_name        VARCHAR2(100); --要删除的表空间名称
-----------------------------------------------------
begin
------------------------------------------------------

   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'1','1.获取需要删除分区的日期 begin');

   ----获取需要删除分区的年+周
   select to_char(sysdate-c_week*7,'IYYYIW') into v_del_date from dual;

   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'2','2.获取需要删除分区的日期:'||v_del_date||' end');
   
   v_tablespace_name := 'DI_W'||v_del_date;
------------------------------------------------------
--删除指定的表空间
------------------------------------------------------

   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'3','3.删除动态表的表空间和分区 begin');

   --一、删除动态表的分区
   v_cur_sql :='select * from user_tab_partitions utp where  utp.table_name <> ''DETECTION_INFO'' and to_number(substr(utp.partition_name,-6))=to_number(substr('||v_del_date||',-6))';
   --删除指定周及之前的表空间和分区:<=
   --v_cur_sql :='select * from user_tab_partitions utp where  utp.table_name <> ''DETECTION_INFO'' and to_number(substr(utp.partition_name,-6))<=to_number(substr('||v_del_date||',-6))';
   
   PRO_DEL_PARTITIONS('3_',v_cur_sql);

   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'4','4.删除动态表的表空间和分区 end');

------------------------------------------------------
   v_table_name :='DETECTION_INFO';

   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'5','5.删除'||v_table_name||'表包含外键表的分区及表空间 begin');

   --三、删除包含外键表的分区
   v_cur_sql :='select * from user_tab_partitions utp where  utp.table_name = ''DETECTION_INFO'' and  to_number(substr(utp.partition_name,-6))=to_number(substr('||v_del_date||',-6))';
   --删除指定周及之前的表空间和分区:<=
   --v_cur_sql :='select * from user_tab_partitions utp where  utp.table_name = ''DETECTION_INFO'' and  to_number(substr(utp.partition_name,-6))<=to_number(substr('||v_del_date||',-6))';
   
   PRO_DEL_PARTITIONS('5_',v_cur_sql);

   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'6','6.删除'||v_table_name||'表包含外键表的分区及表空间 end');

------------------------------------------------------

   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'7','7.删除表 表空间 begin');

   ----删除表空间--每周所有分区表共用一个表空间
   execute immediate 'drop tablespace '||v_tablespace_name||' including contents and datafiles';

   PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'8','8.删除表 表空间 end');

----------------------------------------------------------

   EXCEPTION
      --异常处理机制，记录相关的ora错误号以及相关异常信息
      WHEN OTHERS THEN
      BEGIN
           ROLLBACK;
           PRO_RECORD_LOG_INFO(c_cur_pro_func_desc,'-1','error:'||SQLERRM);

      END;
end pro_driver_del_Partition;
/


spool off
