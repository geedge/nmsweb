--赋予用户执行dbma_lock的权限:需要sys或者dba才能赋予权限
grant execute on dbms_lock to nms; 

--PRO_RECORD_LOG_INFO
create or replace procedure PRO_RECORD_LOG_INFO(log_table_name in VARCHAR2,id in number, proname in VARCHAR2, sequence in VARCHAR2,log_cont in VARCHAR2)
is
   v_log_table_sql          VARCHAR2(2000);----记录日志sql语句
   pragma autonomous_transaction;
begin
   v_log_table_sql :=  'INSERT INTO '||log_table_name||'(id,proname,sequence,log_cont) VALUES('||id||','''||proname||''','''||sequence||''','''||log_cont||''')';
   EXECUTE IMMEDIATE v_log_table_sql;
   COMMIT;
end PRO_RECORD_LOG_INFO; 
/

--pro_del_part_by_day
create or replace procedure pro_del_part_by_day(v_table_name IN VARCHAR2,v_par_sequence IN VARCHAR2,v_partition_name IN VARCHAR2)
Authid Current_User----使存储过程可以使用role权限
AS
-------------------------------------------------------------------------------------------------------------

--此过程的功能
--每次执行可以自动自动删除分区，删除指定的表空间，（按天）
--当前版本：1. 0
--作         者：hyx
--日         期：2013.11.01
---
-------------------------------------------------------------------------------------------------------------
--变量声明
   ----表空间名= 表空间名前缀 + 表名 + _ + 日期
   c_table_name_prefix      CONSTANT VARCHAR2(100) :=''; ----表空间名前缀（注意：一定要大写）
   c_log_table_name         CONSTANT VARCHAR2(100) :='PRO_EXEC_LOG'; --日志记录在此表内
   c_cur_pro_name           CONSTANT VARCHAR2(100) :='pro_del_part_by_day'; --当前存储过程的名称
-------------------------------------------------------------------------------------------------------------
   --v_log_table_sql          VARCHAR2(2000);----记录日志sql语句
   v_del_partition_sql      VARCHAR2(2000); --删除分区sql语句
   v_log_id                 NUMBER;--日志记录id
   
-------------------------------------------------------------------------------------------------------------
BEGIN
   
   ----------------------------------------------------------

   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,v_par_sequence||'3','3.删除'||v_table_name||'表分区 begin');


   ----删除指定表分区
   v_del_partition_sql := 'alter table '||v_table_name||' drop partition '||v_partition_name||' update indexes';
  
   execute immediate v_del_partition_sql;

   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,v_par_sequence||'4','4.删除'||v_table_name||'表分区 end');
   
   -------------------------- --------------------------------

   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,v_par_sequence||'5','5.删除'||v_table_name||'表 表空间 begin');


   ----删除指定表空间
   execute immediate 'drop tablespace '||c_table_name_prefix||v_partition_name||' including contents and datafiles';

   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,v_par_sequence||'6','6.删除'||v_table_name||'表 表空间 end');


   ----------------------------------------------------------
EXCEPTION
    --异常处理机制，记录相关的ora错误号以及相关异常信息
    WHEN OTHERS THEN
    BEGIN
         ROLLBACK;
         select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
         PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'-1','error:'||SQLERRM);

    END;
END pro_del_part_by_day;
/

--PRO_DELTABSPACE
create or replace procedure PRO_DELTABSPACE(v_par_sequence IN VARCHAR2,v_cur_sql IN VARCHAR2)
Authid Current_User----使存储过程可以使用role权限
is
--------------------------------------------------------------
--可配置
  c_log_table_name              CONSTANT VARCHAR2(100) :='PRO_EXEC_LOG'; --日志记录在此表内
  c_cur_pro_name                CONSTANT VARCHAR2(100) :='PRO_DELTABSPACE'; --当前存储过程的名称

--变量 
  v_table_name                  VARCHAR2(2000); --表名
  v_partition_name              VARCHAR2(2000); --表分区名
  v_sequence_count              NUMBER :=0; --此存储过程的步骤编号 
  v_full_sequence               VARCHAR2(100);--步骤编号全称
  --v_log_table_sql          VARCHAR2(2000);----记录日志sql语句
  v_log_id                 NUMBER;--日志记录id
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

          select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
          PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,v_full_sequence,v_sequence_count||'.删除'||v_table_name||'表指定的表空间和表分区 begin');


          --删除detection_info表指定的表空间和表分区
          pro_del_part_by_day(v_table_name,v_full_sequence||'_',v_partition_name);

          v_sequence_count := v_sequence_count + 1;
          v_full_sequence := v_par_sequence||v_sequence_count;
          
          select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
          PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,v_full_sequence,v_sequence_count||'.删除'||v_table_name||'表指定的表空间和表分区 end');
          
--------------------------------------------------------------
    END LOOP;
  CLOSE cur;
  EXCEPTION
      --异常处理机制，记录相关的ora错误号以及相关异常信息
      WHEN OTHERS THEN
         BEGIN
           ROLLBACK;
           select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
           PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'-1','error:'||SQLERRM);
         END;
END PRO_DELTABSPACE;
/

--pro_driver_del_Partition
create or replace procedure pro_driver_del_Partition
Authid Current_User----使存储过程可以使用role权限
is
------------- ----------------------------------------
--可配置
     c_log_table_name         CONSTANT VARCHAR2(100) :='PRO_EXEC_LOG'; --日志记录在此表内
--   c_user_name              CONSTANT VARCHAR2(100) :='NMS'; --用户名
     c_cur_pro_name           CONSTANT VARCHAR2(100) :='pro_driver_del_Partition'; --当前存储过程的名称
     c_day                    CONSTANT NUMBER :=7;----指定删除多少天前那天的分区和表空间
     c_count                  CONSTANT NUMBER :=3;----尝试停用或恢复外键的最大次数（当插入数据时，停用或启用外键会报异常）
     c_sleep_count            CONSTANT NUMBER :=5;----两次尝试停用或启用外键的间隔时间,单位：秒
     
---
     v_del_date               VARCHAR2(200);----需要删除分区的日期
     --v_log_table_sql          VARCHAR2(2000);----记录日志sql语句
     v_cur_sql                VARCHAR2(2000);----游标sql
     space_sql                VARCHAR2(2000);----sql语句变量
     v_table_name             VARCHAR2(2000); --表名
     v_count                  NUMBER :=0; --记录已尝试停用或恢复外键的次数（当插入数据时，停用或启用外键会报异常）
     v_log_id                 NUMBER;--日志记录id
-----------------------------------------------------
begin
------------------------------------------------------  

   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'1','1.获取需要删除分区的日期 begin');

   ----获取需要删除分区的日期--暂时未用到
   select to_char(sysdate-c_day,'yyyymmdd') into v_del_date from dual;

   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'2','2.获取需要删除分区的日期:'||v_del_date||' end');
   
------------------------------------------------------
--删除指定的表空间
------------------------------------------------------

   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'3','3.删除动态表的表空间和分区 begin');


   --一、删除动态表的表空间和分区
   v_cur_sql :='select * from user_tab_partitions utp where  utp.table_name <> ''DETECTION_INFO'' and  to_date(substr(utp.partition_name,-8),''yyyy-MM-dd'')<=to_date('||v_del_date||',''yyyy-MM-dd'')';
   PRO_DELTABSPACE('3_',v_cur_sql);

   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'4','4.删除动态表的表空间和分区 end');

------------------------------------------------------

   v_table_name :='DETECTION_INFO';

   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'5','5.暂时停用'||v_table_name||'表被用作外键表的外键 begin');

   
   -- 循环尝试停用detection_info表的外键
   <<continueTryDis>>
   LOOP 
      BEGIN 
           -- 尝试够一定次数，或者 一次执行成功  则退出循环         
           EXIT WHEN v_count=c_count;

           --二、暂时停用被用作外键表的外键
           space_sql :='alter table detection_info disable primary key cascade';
           EXECUTE IMMEDIATE space_sql;
           
           EXCEPTION
              --异常处理机制，记录相关的ora错误号以及相关异常信息
              WHEN OTHERS THEN
              BEGIN
                   --ROLLBACK;--停用失败后，不该回滚所有的事务，而是该再次尝试，即使尝试到一定次数都失败，也不可以回滚
                   
                   v_count := v_count + 1;
                   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
                   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'-1','error:'||SQLERRM||'，已尝试停用detection_info表的外键'||v_count||'次');

                  
                   --停用外键失败，则再次尝试,再次尝试前先睡眠一段时间 
                   dbms_lock.sleep(c_sleep_count);
                   GOTO continueTryDis;
              END;       
      END; 
      EXIT;  
   END LOOP;

   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'6','6.暂时停用'||v_table_name||'表被用作外键表的外键 end');

------------------------------------------------------
   v_table_name :='DETECTION_INFO';
 
   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'7','7.删除'||v_table_name||'表包含外键表的分区及表空间 begin');


   --三、删除包含外键表的分区及表空间
   v_cur_sql :='select * from user_tab_partitions utp where  utp.table_name = ''DETECTION_INFO'' and  to_date(substr(utp.partition_name,-8),''yyyy-MM-dd'')<=to_date('||v_del_date||',''yyyy-MM-dd'')';
   PRO_DELTABSPACE('7_',v_cur_sql);
   
   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'8','8.删除'||v_table_name||'表包含外键表的分区及表空间 end');

------------------------------------------------------
   v_table_name :='detection_info';

   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'9','9.恢复'||v_table_name||'表被用作外键表的外键 begin');

   
   -- 循环尝试启用detection_info表的外键
   v_count :=0;
   <<continueTryEna>>
   LOOP 
      BEGIN 
           -- 尝试够一定次数，或者 一次执行成功  则退出循环         
           EXIT WHEN v_count=c_count;

           --四、恢复被用作外键表的外键
           space_sql :='alter table detection_info enable primary key';
           EXECUTE IMMEDIATE space_sql;
           EXCEPTION
              --异常处理机制，记录相关的ora错误号以及相关异常信息
              WHEN OTHERS THEN
              BEGIN
                   --ROLLBACK;--停用失败后，不该回滚所有的事务，而是该再次尝试，即使尝试到一定次数都失败，也不可以回滚
                   
                   v_count := v_count + 1;
                   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
                   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'-1','error:'||SQLERRM||'，已尝试启用detection_info表的外键'||v_count||'次');

                   
                   --启用外键失败，则再次尝试,再次尝试前先睡眠一段时间 
                   dbms_lock.sleep(c_sleep_count);
                   GOTO continueTryEna;
              END;       
      END; 
      EXIT;   
   END LOOP;

   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'10','10.恢复'||v_table_name||'表被用作外键表的外键 end');
   

------------------------------------------------------
    EXCEPTION
      --异常处理机制，记录相关的ora错误号以及相关异常信息
      WHEN OTHERS THEN
      BEGIN
           ROLLBACK;

           select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
           PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'-1','error:'||SQLERRM);

      END;
end pro_driver_del_Partition;
/