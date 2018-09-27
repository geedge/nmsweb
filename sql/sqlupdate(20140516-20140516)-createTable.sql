--修改创建表存储过程的注释
create or replace procedure pro_createTable(tabName IN VARCHAR2,filedAndType IN VARCHAR2,indexfileds in varchar2)
Authid Current_User----使存储过程可以使用role权限
is
---
     c_oracle_data_dir             CONSTANT VARCHAR2(200) :='/data/d4/oradata/ict/nmspartition/'; --表空间文件存放的路径
     c_tablespace_init_size        CONSTANT VARCHAR2(10) :='10M'; --表空间初始化大小
     c_tablespace_extend_size      CONSTANT VARCHAR2(10) :='5M'; --表空间每次自动扩长大小
     c_log_table_name              CONSTANT VARCHAR2(100) :='PRO_EXEC_LOG'; --日志记录在此表内
     c_cur_pro_name                CONSTANT VARCHAR2(100) :='pro_createTable'; --当前存储过程的名称
---
     v_create_tablespace_sql       VARCHAR2(5000);
     v_log_table_sql               VARCHAR2(5000);
     v_sql1                        VARCHAR2(5000);
---    
     part_time                     VARCHAR2(64);--第一个分区的后缀名
     part_time_format              VARCHAR2(64);--第一个分区的时间比较字符串
     part_time2                    VARCHAR2(64);--第二个分区的后缀名
     part_time2_format             VARCHAR2(64);--第二个分区的时间比较字符串
begin
--------------------------------------- 
--修改为按天分区后的修改     
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''1'',''1.创建以表名命名的表空间（用于主键索引） begin'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT;    
     
     --创建以表名命名的表空间（用于主键索引）
     v_create_tablespace_sql := 'CREATE BIGFILE TABLESPACE '||tabName||' DATAFILE '''||c_oracle_data_dir||tabName||'.dbf'' SIZE '||c_tablespace_init_size||' AUTOEXTEND ON NEXT '||c_tablespace_extend_size||' MAXSIZE UNLIMITED';
     execute immediate v_create_tablespace_sql;
     
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''2'',''2.创建以表名命名的表空间（用于主键索引） end'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT; 
---------------------------------------    
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''3'',''3.查询当前时间 begin'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT;    
     
     --查询当前时间
     select to_char(sysdate,'yyyyMMdd') into part_time from dual; 
     select to_char(sysdate,'yyyy-MM-dd HH24:MI:SS') into part_time_format from dual; 
     
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''4'',''4.查询当前时间:'||part_time||' end'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT; 
---------------------------------------   
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''5'',''5.创建第一个分区的表空间 begin'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT; 
         
     --创建第一个分区的表空间
     v_create_tablespace_sql := 'CREATE BIGFILE TABLESPACE '||tabName||'_'||part_time||' DATAFILE '''||c_oracle_data_dir||tabName||'_'||part_time||'.dbf'' SIZE '||c_tablespace_init_size||' AUTOEXTEND ON NEXT '||c_tablespace_extend_size||' MAXSIZE UNLIMITED';
     execute immediate v_create_tablespace_sql;
     
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''6'',''6.创建第一个分区的表空间 end'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT; 
---------------------------------------      
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''7'',''7.查询第二天的时间 begin'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT; 
         
     --查询第二天的时间，避免错过定时创建分区的执行时间
     select to_char(sysdate+1,'yyyyMMdd') into part_time2 from dual; 
     select to_char(sysdate+1,'yyyy-MM-dd HH24:MI:SS') into part_time2_format from dual; 
     
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''8'',''8.查询第二天的时间:'||part_time2||' end'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT; 
---------------------------------------     
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''9'',''9.创建第二个分区的表空间 begin'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT;  
          
     --创建第二个分区的表空间
     v_create_tablespace_sql := 'CREATE BIGFILE TABLESPACE '||tabName||'_'||part_time2||' DATAFILE '''||c_oracle_data_dir||tabName||'_'||part_time2||'.dbf'' SIZE '||c_tablespace_init_size||' AUTOEXTEND ON NEXT '||c_tablespace_extend_size||' MAXSIZE UNLIMITED';
     execute immediate v_create_tablespace_sql;
     
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''10'',''10.创建第二个分区的表空间 end'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT; 
--------------------------------------   
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''11'',''11.建表 begin'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT; 
     
     --建表
     v_sql1 :='create table '||tabName ||'(id number not null primary key,detection_info_id number not null ,'||filedAndType||',DETECTIONED_STATE varchar(2),SEQ_ID number,DETECTION_SET_INFO_ID number,data_check_time DATE,data_arrive_time DATE,data_check_time_digital number,data_arrive_time_digital number,foreign KEY(detection_info_id) REFERENCES detection_info(id))'||
              'partition by range(DATA_CHECK_TIME)'||'(partition '||tabName||'_'||part_time||' values less than(to_date('''||part_time_format||''',''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) tablespace '||tabName||'_'||part_time||' storage(initial 10M next 10M maxextents unlimited ),'||
                                                      'partition '||tabName||'_'||part_time2||' values less than(to_date('''||part_time2_format||''',''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) tablespace '||tabName||'_'||part_time2||' storage(initial 10M next 10M maxextents unlimited ))';
     EXECUTE IMMEDIATE v_sql1;
     
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''12'',''12.建表 end'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT;       
---------------------------------------
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''13'',''13.创建seq begin'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT; 
     
     --创建seq
     pro_createSeq(tabName);
     
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''14'',''14.创建seq end'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT; 
---------------------------------------
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''15'',''15.创建触发器 begin'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT; 
     
     --创建触发器
     pro_createTrigger(tabName);
     
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''16'',''16.创建触发器 end'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT;  
---------------------------------------
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''17'',''17.创建索引 begin'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT;  
     
     --创建索引    
     pro_createindex(tabName,indexfileds);  
     
     v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''18'',''18.创建索引 end'')';
     EXECUTE IMMEDIATE v_log_table_sql;
     COMMIT; 
----------------------------------------
EXCEPTION
     --异常处理机制，记录相关的ora错误号以及相关异常信息
     WHEN OTHERS THEN
     BEGIN
         ROLLBACK;
         v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''-1'',''error:'||SQLERRM||''')';
         EXECUTE IMMEDIATE v_log_table_sql;
         COMMIT;
     END;
end pro_createTable;


--修改创建SEQ的存储过程：添加日志信息
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


--修改创建触发器的存储过程：添加日志信息
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


--创建索引，添加日志
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

