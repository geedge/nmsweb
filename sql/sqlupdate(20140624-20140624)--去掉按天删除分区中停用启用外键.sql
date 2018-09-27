
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
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'5','5.删除'||v_table_name||'表包含外键表的分区及表空间 begin');


   --三、删除包含外键表的分区及表空间
   v_cur_sql :='select * from user_tab_partitions utp where  utp.table_name = ''DETECTION_INFO'' and  to_date(substr(utp.partition_name,-8),''yyyy-MM-dd'')<=to_date('||v_del_date||',''yyyy-MM-dd'')';
   PRO_DELTABSPACE('5_',v_cur_sql);
   
   select SEQ_PRO_EXEC_LOG.nextval into v_log_id from dual;
   PRO_RECORD_LOG_INFO(c_log_table_name,v_log_id,c_cur_pro_name,'6','6.删除'||v_table_name||'表包含外键表的分区及表空间 end');

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