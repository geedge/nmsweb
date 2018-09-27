---------------------------------------------------
-- Export file for user NMS                      --
-- Created by dongxiaoyan on 2014/10/31, 9:17:28 --
---------------------------------------------------

spool procedures.log

prompt
prompt Creating procedure PRO_ADD_PART_ONE_DAY
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE pro_add_part_one_day(v_table_name IN VARCHAR2,v_par_sequence IN VARCHAR2)
Authid Current_User----使存储过程可以使用role权限
AS
-------------------------------------------------------------------------------------------------------------
--此过程的功能
--     根据传递的参数，生成制定的表空间，自动添加分区（按天）
--当前版本：1. 0
--作         者：hyx
--日         期：2013.10.31
---
-------------------------------------------------------------------------------------------------------------
---可配置
   --表空间名= 表空间名前缀 + 表名 + _ + 日期
   c_table_name_prefix      CONSTANT VARCHAR2(100) :=''; --不要配置，就配置为空，否长度超过最大限制，表空间名前缀（注意：一定要大写）
   c_oracle_data_dir             CONSTANT VARCHAR2(200) :='/data/d4/oradata/ict/nmspartition/'; --表空间文件存放的路径
   c_tablespace_init_size        CONSTANT VARCHAR2(10) :='10M'; --表空间初始化大小
   c_tablespace_extend_size      CONSTANT VARCHAR2(10) :='5M'; --表空间每次自动扩长大小
   c_log_table_name              CONSTANT VARCHAR2(100) :='PRO_EXEC_LOG'; --日志记录在此表内
   c_cur_pro_name                CONSTANT VARCHAR2(100) :='pro_add_part_one_day'; --当前存储过程的名称
---
-------------------------------------------------------------------------------------------------------------
   v_log_table_sql               VARCHAR2(2000);----记录日志sql语句
---
   v_last_tablespace_name_sql    VARCHAR2(2000);----获取相关表最近创建的表空间名sql语句
   v_last_tablespace_name        VARCHAR2(200);----相关表最近创建的表空间名
---
   v_tablespace_prefix_length    NUMBER;----相关表最近创建的表空间名（去除日期）长度
---
   v_last_tablespace_name_date   NUMBER; --相关表最近创建的表空间名日期
   v_next_tablespace_name_date   NUMBER; --新添加表空间日期
   v_create_tablespace_sql       VARCHAR2(2000); --创建下一个表空间的sql语句
   v_partition_time_date         NUMBER; ----取分区范围值
   v_add_partition_sql           VARCHAR2(2000); --增加表下一个分区sql语句
   v_sub_table_name              VARCHAR2(200);--表名超过21时，截取后表的名字

---
-------------------------------------------------------------------------------------------------------------
BEGIN
   ----------------------------------------------------------
    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'1'',''1.判断'||v_table_name||'表名长度是否大于21，如果大于，则从后往前截取21个字符 begin'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;

    --判断表名长度是否大于21，如果大于，则从后往前截取21个字符:因为之前定义的表有长度超过21的：22+9=31，超过最大长度了
    v_sub_table_name := v_table_name;
    if length(v_table_name)>21 then
        v_sub_table_name := substr(v_table_name,-21);
    end if;

    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'2'',''2.截取前表名：'||v_table_name||',截取后表名：'||v_sub_table_name||' end'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;
    ----------------------------------------------------------
    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'3'',''3.获取'||v_table_name||'表最近创建的表空间名 begin'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;

    --获取表最近创建的表空间名
    v_last_tablespace_name_sql := 'select name from (select * from v$tablespace where name like''%'||c_table_name_prefix||v_sub_table_name||'_2%'''||'order by name desc ) where rownum<2';
    execute immediate v_last_tablespace_name_sql into v_last_tablespace_name;

    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'4'',''4.获取'||v_table_name||'表最近创建的表空间名 end'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;
    ----------------------------------------------------------
    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'5'',''5.获取'||v_table_name||'表最近创建的表空间名前缀长度+1 begin'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;

    --获取表最近创建的表空间名前缀长度+1
    v_tablespace_prefix_length := LENGTH(CONCAT(c_table_name_prefix,v_sub_table_name)) + 2 ;

    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'6'',''6.获取'||v_table_name||'表最近创建的表空间名前缀长度+1 end'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;
    ----------------------------------------------------------
    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'7'',''7.获取'||v_table_name||'表最近创建的表空间名日期（去除表空间名）begin'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;

    --获取表最近创建的表空间名日期（去除表空间名）
    v_last_tablespace_name_date := to_number(substr(v_last_tablespace_name, v_tablespace_prefix_length, 8));
    --v_last_tablespace_name_date := to_number('20131106');--指定之前创建的最新的日期

    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'8'',''8.获取'||v_table_name||'表最近创建的表空间名日期（去除表空间名）:'||v_last_tablespace_name_date||' end'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;
    ----------------------------------------------------------
    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'9'',''9.获取'||v_table_name||'表新添加表空间日期 begin'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;

    --新添加表空间日期
    v_next_tablespace_name_date := to_char(to_date(v_last_tablespace_name_date,'yyyymmdd') + '1','yyyymmdd');

    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'10'',''10.获取'||v_table_name||'表新添加表空间日期 end'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;
    ----------------------------------------------------------
    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'11'',''11.为'||v_table_name||'表创建表空间 begin'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;

    --创建表空间    
    v_create_tablespace_sql := 'CREATE BIGFILE TABLESPACE '||c_table_name_prefix||v_sub_table_name||'_'||v_next_tablespace_name_date||' DATAFILE'||''''||c_oracle_data_dir||c_table_name_prefix||v_sub_table_name||'_'||v_next_tablespace_name_date||'.dbf'||''''||' SIZE '||c_tablespace_init_size||' AUTOEXTEND ON NEXT '||c_tablespace_extend_size||' MAXSIZE UNLIMITED';
    execute immediate v_create_tablespace_sql;

    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'12'',''12.为'||v_table_name||'表创建表空间:'||c_table_name_prefix||v_sub_table_name||'_'||v_next_tablespace_name_date||' end'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;
    ----------------------------------------------------------
    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'13'',''13.'||v_table_name||'表 获取下一天时间分区对应的时间 begin'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;

    --获取下一天时间分区对应的时间
    v_partition_time_date := to_char(to_date(v_last_tablespace_name_date,'yyyymmdd') + '2','yyyymmdd');

    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'14'',''14.'||v_table_name||'表 获取下一天时间分区对应的时间 end'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;
    ----------------------------------------------------------
    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'15'',''15.把表分区增加到'||v_table_name||'表 begin'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;

    --把表分区增加到相关表
    v_add_partition_sql := 'ALTER TABLE '||v_table_name||' ADD PARTITION '||v_sub_table_name||'_' ||
                 v_next_tablespace_name_date || ' values less than(' ||
                 'to_date('''||v_partition_time_date||''','||''''||'yyyymmdd'||''''||')'|| ') TABLESPACE '||c_table_name_prefix||v_sub_table_name||'_'||v_next_tablespace_name_date;
    execute immediate v_add_partition_sql;

    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_par_sequence||'16'',''16.把表分区'||v_sub_table_name||'_' ||v_next_tablespace_name_date||'增加到'||v_table_name||'表 end'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;
    ----------------------------------------------------------
EXCEPTION
    --异常处理机制，记录相关的ora错误号以及相关异常信息
    WHEN OTHERS THEN
    BEGIN
         ROLLBACK;
         v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''-1'',''error:'||SQLERRM||''')';
         EXECUTE IMMEDIATE v_log_table_sql;
         COMMIT;
         --ROLLBACK;
    END;

END;
/

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
prompt Creating procedure PRO_CREATEQUTESPACE
prompt ======================================
prompt
create or replace procedure PRO_CREATEQUTESPACE(spaceName IN VARCHAR2,spacePath IN VARCHAR2)
Authid Current_User----使存储过程可以使用role权限
is
space_sql VARCHAR2(5000);
execParm number;
proexecinfoid number;
execption_sql VARCHAR2(5000);

begin
   execParm := 0;
 space_sql :='create tablespace '||spaceName||' datafile '''||spacePath||''' size 50M  autoextend on default storage(initial 10M next 10M minextents 1 maxextents unlimited pctincrease 1)';
    execParm := 1;
    EXECUTE IMMEDIATE space_sql;
 --EXECUTE IMMEDIATE 'create tablespace '||spaceName||' datafile '''||spacePath||''' size 50M default
 --  storage(initial 10M next 10M minextents 1 maxextents unlimited pctincrease 1)';
  --execParm := 2;
 EXCEPTION WHEN OTHERS THEN
    select SEQ_PROEXECINFO.NEXTVAL into proexecinfoid from dual;
    execption_sql := 'insert into PROEXECINFO(ID,proname,param,prodesc) values('||proexecinfoid||',''PRO_CREATEQUTESPACE'','||execParm||','''||to_char(sysdate,'YYYY-MM-DD HH:MI')||spaceName||spacePath||''')';
    EXECUTE IMMEDIATE execption_sql;
--
   --dbms_output.put_line(sqlerrm);
--ROLLBACK;
end PRO_CREATEQUTESPACE;
--end;
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
prompt Creating procedure PRO_CREATETABLE
prompt ==================================
prompt
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
/

prompt
prompt Creating procedure PRO_CREATEWEEKSPACE
prompt ======================================
prompt
create or replace procedure PRO_CREATEWEEKSPACE(spaceName IN VARCHAR2,spacePath IN VARCHAR2)
Authid Current_User----使存储过程可以使用role权限
 is
space_sql VARCHAR2(5000);
execParm number;
proexecinfoid number;
execption_sql VARCHAR2(5000);

begin
   execParm := 0;
 space_sql :='create tablespace '||spaceName||' datafile '''||spacePath||''' size 100M  autoextend on default storage(initial 100M next 10M minextents 1 maxextents unlimited pctincrease 1)';
 --space_sql :='create tablespace '||spaceName||' datafile '''||spacePath||''' size 100M autoextend on next 10M maxsize unlimited ';
    execParm := 1;
    EXECUTE IMMEDIATE space_sql;
 --EXECUTE IMMEDIATE 'create tablespace '||spaceName||' datafile '''||spacePath||''' size 50M default
 --  storage(initial 10M next 10M minextents 1 maxextents unlimited pctincrease 1)';
  --execParm := 2;
 EXCEPTION WHEN OTHERS THEN
    select SEQ_PROEXECINFO.NEXTVAL into proexecinfoid from dual;
    execption_sql := 'insert into PROEXECINFO(ID,proname,param,prodesc) values('||proexecinfoid||',''PRO_CREATEQUTESPACE'','||execParm||','''||to_char(sysdate,'YYYY-MM-DD HH:MI')||spaceName||spacePath||''')';
    EXECUTE IMMEDIATE execption_sql;
--
   --dbms_output.put_line(sqlerrm);
--ROLLBACK;
end PRO_CREATEWEEKSPACE;
--end;
/

prompt
prompt Creating procedure PRO_RECORD_LOG_INFO
prompt ======================================
prompt
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

prompt
prompt Creating procedure PRO_DEL_PART_BY_DAY
prompt ======================================
prompt
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

prompt
prompt Creating procedure PRO_DELTABSPACE
prompt ==================================
prompt
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

prompt
prompt Creating procedure PRO_DELTABSPACE_NAME
prompt =======================================
prompt
create or replace procedure PRO_DELTABSPACE_NAME(tempstr IN VARCHAR2,user_name IN VARCHAR2,tablename IN VARCHAR2)
Authid Current_User
----使存储过程可以使用role权限
is
space_sql VARCHAR2(5000);
--execParm number;
proexecinfoid number;

begin
   -- execParm := 1;
   space_sql :='alter table '||user_name||'.'||tablename||' drop partition '||tempstr||' update indexes';
   -- execParm := 2;
     EXECUTE IMMEDIATE space_sql;
   -- execParm := 3;
    --EXCEPTION
      --WHEN OTHERS THEN
     --    dbms_output.put_line(sqlerrm);
    --  ROLLBACK;
    EXCEPTION
      WHEN OTHERS THEN
            select SEQ_PROEXECINFO.NEXTVAL into proexecinfoid from dual;
          -- EXECUTE IMMEDIATE 'insert into PROEXECINFO(ID,proname,param,prodesc) values(seq_proexecinfo.nextval,''PRO_DELTABSPACE'','||CT_COLUMNS.segment_name||','''||to_char(sysdate,'YYYY-MM-DD HH:MI')||CT_COLUMNS.segment_name||tempstr||space_sql||''')';
          dbms_output.put_line(sqlerrm);
      ROLLBACK;
end PRO_DELTABSPACE_NAME;
/

prompt
prompt Creating procedure PRO_DEL_WEEK_TABSPACE
prompt ========================================
prompt
create or replace procedure PRO_DEL_WEEK_TABSPACE(tempstr IN VARCHAR2,user_name IN VARCHAR2)
Authid Current_User----使存储过程可以使用role权限
is
space_sql VARCHAR2(5000);
--execParm number;
proexecinfoid number;
--extendtabName VARCHAR2(30);--要添加新分区的表
--游标
  --从监测类别定义表中查询出已经创建的自定义监测类别表
  Cursor cur is
  --SELECT distinct x.table_name
   -- FROM dba_tab_partitions x, dba_tab_partitions y
   --- WHERE x.tablespace_name =tempstr AND y.tablespace_name <> tempstr AND x.table_name=y.table_name
   -- order by x.table_name;
         select distinct segment_name from user_extents where  SEGMENT_TYPE='TABLE PARTITION' AND partition_name = tempstr and segment_name <> 'DETECTION_INFO';
        --select distinct segment_name from user_extents where partition_name = tempstr and segment_name <> 'DETECTION_INFO';
        -- select segment_name from dba_segments where tablespace_name = tempstr and segment_type like '%TABLE%';
  CT_COLUMNS cur%ROWTYPE;
begin
OPEN cur();
  LOOP
     FETCH cur INTO CT_COLUMNS;
    EXIT WHEN cur%NOTFOUND;
   -- execParm := 1;
   space_sql :='alter table '||user_name||'.'||CT_COLUMNS.segment_name||' drop partition '||tempstr||' update indexes';

   -- execParm := 2;
     EXECUTE IMMEDIATE space_sql;
   -- execParm := 3;
    --EXCEPTION
      --WHEN OTHERS THEN
     --    dbms_output.put_line(sqlerrm);
    --  ROLLBACK;
  end LOOP;
  CLOSE cur;
   -- EXCEPTION
   --   WHEN OTHERS THEN
    --        select SEQ_PROEXECINFO.NEXTVAL into proexecinfoid from dual;
    --       EXECUTE IMMEDIATE 'insert into PROEXECINFO(ID,proname,param,prodesc) values(seq_proexecinfo.nextval,''PRO_DEL_WEEK_TABSPACE'','||CT_COLUMNS.segment_name||','''||to_char(sysdate,'YYYY-MM-DD HH:MI')||CT_COLUMNS.segment_name||tempstr||space_sql||''')';
    --      dbms_output.put_line(sqlerrm);
   --   ROLLBACK;
end PRO_DEL_WEEK_TABSPACE;
/

prompt
prompt Creating procedure PRO_DEL_PARTITION
prompt ====================================
prompt
create or replace procedure pro_del_Partition
Authid Current_User----使存储过程可以使用role权限
 is
C_DATE            VARCHAR2(64);
tempstr           VARCHAR2(64);
user_name          VARCHAR2(64);
--space_path        varchar2(1000); --存储过程上次执行的时间
--end_date         VARCHAR2(32);--要添加新分区的表
space_sql          VARCHAR2(1024);
begin

--获取系统当前年
select to_char(sysdate+7, 'yyyy') into C_DATE from dual;
--获取系统下一周
select to_char(sysdate+7, 'iw') into tempstr from dual;
--如果当前新建的周是一年的第一周则，年为上一年
if tempstr = 1
   then select to_char(sysdate-7, 'yyyy') into C_DATE from dual;
end if;
--要删除的是7周前的分区
--tempstr := to_number(tempstr)-7;
select to_char(sysdate-6*12, 'iw') into tempstr from dual;
--要删除分区的名称组合
tempstr := 'DI_W'||C_DATE||''||tempstr;
--tempstr := 'DI_W201341';
user_name := 'NMS';
--到了表空间使用要过期之前，建立新的表空间之后删除旧的表空间：
--一、删除使用该表空间的表
PRO_DEL_WEEK_TABSPACE(tempstr,'NMS');
--space_sql :='alter table '||user_name||'.DETECTION_INFO drop partition '||tempstr||' update indexes';

--二、暂时停用被用作外键表的外键
--alter table NMS.detection_info disable primary key cascade;

space_sql :='alter table '||user_name||'.detection_info disable primary key cascade';
 EXECUTE IMMEDIATE space_sql;

--三、删除包含外键表的分区
--alter table  NMS.detection_info drop partition '||tempstr||' update indexes;
--alter table  NMS.detection_info drop partition '||tempstr||' including contents;
space_sql :='alter table '||user_name||'.detection_info drop partition '||tempstr||' update indexes ';

 EXECUTE IMMEDIATE space_sql;
--四、恢复被用作外键表的外键
--alter table  '||user_name||'.detection_info enable primary key;
--alter index /*nms.detection_info.*/SYS_C0010650 rebuild;

space_sql :='alter table  '||user_name||'.detection_info enable primary key';
 EXECUTE IMMEDIATE space_sql;

--五、删除分区
--drop tablespace '||tempstr||' including contents and datafiles cascade constraints update indexes;
space_sql :='drop tablespace '||tempstr||' including contents and datafiles';--and datafiles cascade constraints update indexes;
 EXECUTE IMMEDIATE space_sql;

end pro_del_Partition;
/

prompt
prompt Creating procedure PRO_EXTENDTABSPACE
prompt =====================================
prompt
create or replace procedure PRO_EXTENDTABSPACE(v_par_sequence IN VARCHAR2)
Authid Current_User----使存储过程可以使用role权限
is
----------------------------------------------------------

--可配置
   c_cur_pro_name                CONSTANT VARCHAR2(100) :='PRO_EXTENDTABSPACE'; --当前存储过程的名称
   c_log_table_name              CONSTANT VARCHAR2(100) :='PRO_EXEC_LOG'; --日志记录在此表内
--变量
  v_table_name                   VARCHAR2(2000); --表名
  v_sequence_count               NUMBER:=0 ; --此存储过程的步骤编号
  v_full_sequence                VARCHAR2(100);--步骤编号全称
  v_log_table_sql               VARCHAR2(2000);----记录日志sql语句

--游标
  --从监测类别定义表中查询出已经创建的自定义监测类别表
  --需要从表对象中查看，表是否创建，没创建的说明标识有问题，实际没创建表，就不用创建分区
  Cursor cur is
         select distinct cti.table_name  extendtabName
         from check_type_info cti
         left join user_tables ut on ut.table_name = cti.table_name
         where cti.crete_state = 0 and ut.table_name is not null;
  CT_COLUMNS cur%ROWTYPE;

-----------------------------------------------------------
BEGIN
  OPEN cur();
  LOOP
    v_sequence_count := v_sequence_count + 1;
    FETCH cur
      INTO CT_COLUMNS;
    EXIT WHEN cur%NOTFOUND;
-------------------------------------------------------------
    v_table_name :=CT_COLUMNS.extendtabName;--表名
    v_full_sequence := v_par_sequence||v_sequence_count;

    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_full_sequence||''','''||v_sequence_count||'.为'||v_table_name||'表创建表空间和表分区 begin'')';
    EXECUTE IMMEDIATE v_log_table_sql;
    COMMIT;

    --为detection_info表创建表空间和表分区
    pro_add_part_one_day(v_table_name,v_full_sequence||'_');
    
    v_sequence_count := v_sequence_count + 1;
    v_full_sequence := v_par_sequence||v_sequence_count;
    v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''','''||v_full_sequence||''','''||v_sequence_count||'.为'||v_table_name||'表创建表空间和表分区 end'')';
    EXECUTE IMMEDIATE v_log_table_sql  ;
    COMMIT;
---------------------------------------------------------------
  END LOOP;
  CLOSE cur;
  EXCEPTION
      --异常处理机制，记录相关的ora错误号以及相关异常信息
      WHEN OTHERS THEN
         BEGIN
           ROLLBACK;
           v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''-1'',''error:'||SQLERRM||')';
           EXECUTE IMMEDIATE v_log_table_sql;
           COMMIT;
           --ROLLBACK;
         END;
END;
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
--      每次执行可以自动生成制定的表空间，自动添加分区（按天）
--当 前 版 本：1. 0
--作        者：hyx
--日        期：2013.10.31
-------------------------------------------------------------------------------------------------------------
---可配置
   c_log_table_name              CONSTANT VARCHAR2(100) :='PRO_EXEC_LOG'; --日志记录在此表内
   c_cur_pro_name                CONSTANT VARCHAR2(100) :='pro_driver_add_Partition'; --当前存储过程的名称
---
-------------------------------------------------------------------------------------------------------------
---
   v_log_table_sql               VARCHAR2(2000);----记录日志sql语句
   v_table_name                  VARCHAR2(2000); --表名--表名一定要大写
-------------------------------------------------------------------------------------------------------------

BEGIN
--为固定表创建表空间及分区
-----------------------------------------------------------
   v_table_name :='DETECTION_INFO';
   v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''1'',''1.为'||v_table_name||'表创建表空间和表分区 begin'')';
   EXECUTE IMMEDIATE v_log_table_sql;
   COMMIT;

   --为detection_info表创建表空间和表分区
   pro_add_part_one_day(v_table_name,'1_');

   v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''2'',''2.为'||v_table_name||'表创建表空间和表分区 end'')';
   EXECUTE IMMEDIATE v_log_table_sql;
   COMMIT;
-----------------------------------------------------------
   v_table_name :='DETECTION_INFO_WARNING';
   v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''3'',''3.为'||v_table_name||'表创建表空间和表分区 begin'')';
   EXECUTE IMMEDIATE v_log_table_sql;
   COMMIT;

   --为detection_info表创建表空间和表分区
   pro_add_part_one_day(v_table_name,'3_');

   v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''4'',''4.为'||v_table_name||'表创建表空间和表分区 end'')';
   EXECUTE IMMEDIATE v_log_table_sql;
   COMMIT;

-----------------------------------------------------------
   v_table_name :='DI_SYSTEMINFO_DISK';
   v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''5'',''5.为'||v_table_name||'表创建表空间和表分区 begin'')';
   EXECUTE IMMEDIATE v_log_table_sql;
   COMMIT;

   --为detection_info表创建表空间和表分区
   pro_add_part_one_day(v_table_name,'5_');

   v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''6'',''6.为'||v_table_name||'表创建表空间和表分区 end'')';
   EXECUTE IMMEDIATE v_log_table_sql;
   COMMIT;
-----------------------------------------------------------
   v_table_name :='DI_SYSTEMINFO_NET';
   v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''7'',''7.为'||v_table_name||'表创建表空间和表分区 begin'')';
   EXECUTE IMMEDIATE v_log_table_sql;
   COMMIT;

   --为detection_info表创建表空间和表分区
   pro_add_part_one_day(v_table_name,'7_');

   v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''8'',''8.为'||v_table_name||'表创建表空间和表分区 end'')';
   EXECUTE IMMEDIATE v_log_table_sql;
   COMMIT;
-----------------------------------------------------------
--为动态表创建表空间及分区
   v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''9'',''9.为动态表创建表空间及分区 begin'')';
   EXECUTE IMMEDIATE v_log_table_sql;
   COMMIT;

   --为动态表创建表空间及分区
   pro_extendtabspace('9_');

   v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''10'',''10.为动态表创建表空间及分区 end'')';
   EXECUTE IMMEDIATE v_log_table_sql;
   COMMIT;
EXCEPTION
    --异常处理机制，记录相关的ora错误号以及相关异常信息
    WHEN OTHERS THEN
    BEGIN
         ROLLBACK;
         v_log_table_sql :=  'INSERT INTO '||c_log_table_name||'(id,proname,sequence,log_cont) VALUES(SEQ_PRO_EXEC_LOG.nextval,'''||c_cur_pro_name||''',''-1'',''error:'||SQLERRM||''')';
         EXECUTE IMMEDIATE v_log_table_sql;
         COMMIT;
         --ROLLBACK;
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
--可配置
     c_log_table_name         CONSTANT VARCHAR2(100) :='PRO_EXEC_LOG'; --日志记录在此表内
--   c_user_name              CONSTANT VARCHAR2(100) :='NMS'; --用户名
     c_cur_pro_name           CONSTANT VARCHAR2(100) :='pro_driver_del_Partition'; --当前存储过程的名称
     c_day                    CONSTANT NUMBER :=2;----指定删除多少天前那天的分区和表空间
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


-- Create sequence 
create sequence SEQ_PRO_EXEC_LOG
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order; 
/
spool off
