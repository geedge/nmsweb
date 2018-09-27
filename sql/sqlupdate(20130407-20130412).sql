-- 有关CPU监测和NET监测，METADATA表中记录修改
update metadata t set t.show_num=t.show_num+1 where t.table_name='DETECT_INFO_CPU';
update metadata t set t.show_num=1,t.sort_sign=0 where t.table_name='DETECT_INFO_CPU' and t.filed_name='CPU_NAME';

update metadata t set t.show_num=t.show_num+1 where t.table_name='DETECT_INFO_NETDATA' and t.show_num<14;
update metadata t set t.show_num=1 where t.table_name='DETECT_INFO_NETDATA' and t.filed_name='NAME'; 

update metadata t set t.sort_sign=0 where t.table_name='DETECT_INFO_DISK' and t.filed_name='DISK_RANGE';
commit;

-- 所有详细监测信息表增加字段  DETECTION_SET_INFO_ID（已整理到存储过程中）
--alter table delect_info_nmsc add DETECTION_SET_INFO_ID number;
--alter table DETECT_INFO_CPU add DETECTION_SET_INFO_ID number;
--alter table DETECT_INFO_DISK add DETECTION_SET_INFO_ID number;
--alter table DETECT_INFO_MEMORY add DETECTION_SET_INFO_ID number;
--alter table DETECT_INFO_NETDATA add DETECTION_SET_INFO_ID number;
--alter table DETECT_INFO_PING add DETECTION_SET_INFO_ID number;
--alter table DETECT_INFO_PROCESS add DETECTION_SET_INFO_ID number;
--alter table DETECT_INFO_SNMP_TRAP add DETECTION_SET_INFO_ID number;
--alter table DETECT_INFO_SYSTEM_DATE add DETECTION_SET_INFO_ID number;
--alter table DI_DPSYSTEMFANENTRY add DETECTION_SET_INFO_ID number;
--alter table DI_DPSYSTEMPOWERENTRY add DETECTION_SET_INFO_ID number;
--alter table DI_DPSYSTEMSTATUS add DETECTION_SET_INFO_ID number;
--alter table DI_IFXTABLE add DETECTION_SET_INFO_ID number;
--alter table DI_MENCPU add DETECTION_SET_INFO_ID number;
--alter table DI_SWITCHPORT add DETECTION_SET_INFO_ID number;
--alter table DI_SYSTEM add DETECTION_SET_INFO_ID number;
--alter table DI_SYSTEMINFO add DETECTION_SET_INFO_ID number;
alter table DI_SYSTEMINFO_DISK add DETECTION_SET_INFO_ID number;
alter table DI_SYSTEMINFO_NET add DETECTION_SET_INFO_ID number;
--commit;

--修改存储过程  pro_createTable
create or replace procedure pro_createTable(tabName IN VARCHAR2,filedAndType IN VARCHAR2,indexfileds in varchar2)
Authid Current_User----使存储过程可以使用role权限
is
 v_sql1            VARCHAR2(5000);
 v_sql2            VARCHAR2(500);
 C_DATE            VARCHAR2(64);
 tempstr           VARCHAR2(64);
 v_date            VARCHAR2(64);
begin
--获取系统当前年
select to_char(sysdate, 'yyyy') into C_DATE from dual;
--获取系统当前时间是本年第周
select to_char(sysdate, 'iw')  into tempstr from dual;
--获取当前日期字符串
--select to_char(sysdate, 'yyyy-MM-dd HH24:MI:SS')  into v_date from dual;
--获取当前日期的下周第一天
select to_char(trunc(sysdate+7,'d'),'yyyy-MM-dd HH24:MI:SS') into v_date from dual;
--v_sql1 := 'create table dxytest(detection_info_id number not null primary key,DETECTIONED_STATE,SEQ_ID,data_check_time DATE,data_arrive_time DATE,data_check_time_digital number,data_arrive_time_digital number,foreign KEY(detection_info_id) REFERENCES detection_info(id))partition by range(DATA_CHECK_TIME)(partition di_2012w35 values less than(to_date(''2012-08-29 09:35:34'',''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) tablespace di_2012w35 storage(initial 10M next 10M maxextents unlimited ))';
v_sql1 :='create table '||tabName ||'(detection_info_id number not null primary key,'||filedAndType||',DETECTIONED_STATE varchar(2),SEQ_ID number,DETECTION_SET_INFO_ID number,data_check_time DATE,data_arrive_time DATE,data_check_time_digital number,data_arrive_time_digital number,foreign KEY(detection_info_id) REFERENCES detection_info(id))'||
'partition by range(DATA_CHECK_TIME)'||'(partition DI_W'||C_DATE||''||tempstr||' values less than(to_date('''||v_date||''',''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) tablespace DI_W'||C_DATE||''||tempstr||' storage(initial 10M next 10M maxextents unlimited ))';
dbms_output.put_line(v_sql1);
EXECUTE IMMEDIATE v_sql1;
--创建seq 使用detection_info_id为主键故不再创建Seq
  pro_createSeq(tabName);
--创建触发器 使用detection_info_id为主键故不再创建主键触发器
  pro_createTrigger(tabName);
--创建索引
--indexfileds := indexfileds ||'SEQ_ID:';
--indexfileds := concat(indexfileds,'SEQ_ID');
pro_createindex(tabName,indexfileds);
EXCEPTION
WHEN OTHERS THEN
v_sql2 :='insert into PROCEDURE_LOG(ID,PRO_NAME,PRO_SQL,ER_INFO) values(null,''pro_createTable'','||v_sql1||','||sqlerrm||')';
   EXECUTE IMMEDIATE v_sql2;
   dbms_output.put_line(sqlerrm);
ROLLBACK;
end pro_createTable;



--更新存储过程pro_createTrigger
create or replace procedure pro_createTrigger(tabName IN VARCHAR2) is
 v_sql1 VARCHAR2(5000);
begin
v_sql1 :='Create Or Replace Trigger B_I_'||tabName ||' before insert on '||tabName||' for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_'||tabName ||'.nextVal into :new.id from dual;
end if;
     end B_I_'||tabName||';';
 dbms_output.put_line(v_sql1);
EXECUTE IMMEDIATE v_sql1;

EXCEPTION
WHEN OTHERS THEN
   dbms_output.put_line(sqlerrm);
ROLLBACK;
end pro_createTrigger;


--新增存储过程pro_updatedetectiontable （仅用一次）
create or replace procedure pro_updatedetectiontable
Authid Current_User----使存储过程可以使用role权限
is
  tablename VARCHAR2(100);
  hasPk     NUMBER        :=0;
  hasId     NUMBER        :=0;
  dsiId     NUMBER        :=0;
  --CURSOR
  CURSOR tableName_cursor is
  select TABLE_NAME from check_type_info cti WHERE 1=1 AND cti.crete_state=0 ;

  tableName_row  tableName_cursor%ROWTYPE;               -- 游标名的声明 与 指定游标集合结构 定义。
  
BEGIN
  --EXECUTE IMMEDIATE 'grant create sequence to '|| username;
  --EXECUTE IMMEDIATE 'grant create trigger to '|| username;
  OPEN tableName_cursor;  -- 打开游标
  LOOP     -- 循环开始
      BEGIN
      FETCH tableName_cursor INTO tableName_row;    -- 将游标集合存到游标中
      EXIT WHEN tableName_cursor%NOTFOUND;   -- 循环条件
      
      tablename := tableName_row.TABLE_NAME;
      
      EXECUTE IMMEDIATE 'truncate table '|| tablename;

      select nvl(count(*),0) INTO hasPk from user_cons_columns utc,user_constraints uc where utc.constraint_name = uc.constraint_name and  utc.TABLE_NAME=tablename and uc.constraint_type='P';
      select nvl(count(*),0) INTO hasId from user_tab_columns utc where utc.TABLE_NAME = tablename AND utc.column_name='ID';
      select nvl(count(*),0) INTO dsiId from user_tab_columns utc where utc.TABLE_NAME = tablename AND utc.column_name='DETECTION_SET_INFO_ID';

          
      IF(dsiId =0)
      THEN
          EXECUTE IMMEDIATE 'alter table '|| tablename || ' add (DETECTION_SET_INFO_ID number)';
      END IF;
        
      IF(hasPk =1)
      THEN
          EXECUTE IMMEDIATE 'alter table '|| tablename || ' drop Primary key';
      END IF;

      
      IF(hasId =0)
      THEN
          EXECUTE IMMEDIATE 'alter table '|| tablename || ' add (ID number  Primary key)';
      ELSE
          EXECUTE IMMEDIATE 'alter table '|| tablename || ' add Primary key(ID)';
      END IF;

      pro_createseq(tablename);

      pro_createtrigger(tablename);
      EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line(tableName_row.TABLE_NAME||' 表修改失败');
      END;
  END LOOP;           --循环结束
  CLOSE tableName_cursor;   -- 关闭游标
  
  EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line(tableName_row.TABLE_NAME||'表修改失败');
  ROLLBACK;
end pro_updatedetectiontable;


-- 为当前用户新增 创建索引权限
grant create sequence to #username#;
-- 为当前用户新增 创建触发器权限
grant create trigger to #username#;
-- 更新所有的监测数据详细表表字段，会清除各详细信息表数据
call pro_updatedetectiontable();


--更新触发器Before_nms_error_info
Create Or Replace Trigger Before_nms_error_info
  before insert on nms_error_info
  for each row
declare
  -- local variables here
begin
if ( :new.id is null )   --insert
then
    select seq_nms_error_info.nextVal into :new.id from dual ;
end if;

IF(:NEW.state_update_time IS NULL)
THEN
    :NEW.state_update_time := :NEW.error_time;
END IF;

IF(:NEW.error_state = 2)
THEN
    UPDATE nms_error_info nei SET nei.error_state=0,nei.state_update_time=:NEW.state_update_time WHERE nei.error_state=1 
    AND nei.state_update_time<:NEW.state_update_time
    AND nei.ERROR_CODE=:NEW.ERROR_CODE 
    AND nei.error_des = :NEW.error_des 
    AND nei.errort_getip = :NEW.errort_getip 
    AND nei.errort_ip = :NEW.errort_ip;
END IF;
end Before_insert_nms_error_info;

-- 新增METADATA 数据
insert into METADATA (ID, CHECK_TYPE_ID, TABLE_NAME, TABLE_COMMENTS, FILED_NAME, FILED_COMMENTS, FILED_TYPE, CREATE_DATE, CREATE_PERSON, STATE, UPDATE_DATE, UPDATE_PERSON, CHART_STATE, SHOW_NUM, ISNULL, OID, TYPE_ID, SORT_SIGN)
values (seq_metadata.nextval/*306*/, 10, 'DI_SWITCHPORT', null, 'ifHighSpeed', '端口速率单位（Mbps）', 'NUMBER', null, 1, '0', null, null, '1', 37, null, '1.3.6.1.2.1.31.1.1.1.15.1.1000000', null, 1);
insert into METADATA (ID, CHECK_TYPE_ID, TABLE_NAME, TABLE_COMMENTS, FILED_NAME, FILED_COMMENTS, FILED_TYPE, CREATE_DATE, CREATE_PERSON, STATE, UPDATE_DATE, UPDATE_PERSON, CHART_STATE, SHOW_NUM, ISNULL, OID, TYPE_ID, SORT_SIGN)
values (seq_metadata.nextval/*300*/, 10, 'DI_SWITCHPORT', null, 'ifInOctets_t1', '接收的字节', 'NUMBER', null, 1, '0', null, null, '0', 31, null, '1.3.6.1.2.1.2.2.1.10', null, 1);
insert into METADATA (ID, CHECK_TYPE_ID, TABLE_NAME, TABLE_COMMENTS, FILED_NAME, FILED_COMMENTS, FILED_TYPE, CREATE_DATE, CREATE_PERSON, STATE, UPDATE_DATE, UPDATE_PERSON, CHART_STATE, SHOW_NUM, ISNULL, OID, TYPE_ID, SORT_SIGN)
values (seq_metadata.nextval/*301*/, 10, 'DI_SWITCHPORT', null, 'ifInUcastPkts_t1', '被承认的单向传输数据包', 'NUMBER', null, 1, '0', null, null, '1', 32, null, '1.3.6.1.2.1.2.2.1.11', null, 1);
insert into METADATA (ID, CHECK_TYPE_ID, TABLE_NAME, TABLE_COMMENTS, FILED_NAME, FILED_COMMENTS, FILED_TYPE, CREATE_DATE, CREATE_PERSON, STATE, UPDATE_DATE, UPDATE_PERSON, CHART_STATE, SHOW_NUM, ISNULL, OID, TYPE_ID, SORT_SIGN)
values (seq_metadata.nextval/*302*/, 10, 'DI_SWITCHPORT', null, 'ifInNUcastPkts_t1', '被承认的非单向传输数据包', 'NUMBER', null, 1, '0', null, null, '1', 33, null, '1.3.6.1.2.1.2.2.1.12', null, 1);
insert into METADATA (ID, CHECK_TYPE_ID, TABLE_NAME, TABLE_COMMENTS, FILED_NAME, FILED_COMMENTS, FILED_TYPE, CREATE_DATE, CREATE_PERSON, STATE, UPDATE_DATE, UPDATE_PERSON, CHART_STATE, SHOW_NUM, ISNULL, OID, TYPE_ID, SORT_SIGN)
values (seq_metadata.nextval/*303*/, 10, 'DI_SWITCHPORT', null, 'ifOutOctets_t1', '输出字节数', 'NUMBER', null, 1, '0', null, null, '0', 34, null, '1.3.6.1.2.1.2.2.1.16', null, 1);
insert into METADATA (ID, CHECK_TYPE_ID, TABLE_NAME, TABLE_COMMENTS, FILED_NAME, FILED_COMMENTS, FILED_TYPE, CREATE_DATE, CREATE_PERSON, STATE, UPDATE_DATE, UPDATE_PERSON, CHART_STATE, SHOW_NUM, ISNULL, OID, TYPE_ID, SORT_SIGN)
values (seq_metadata.nextval/*304*/, 10, 'DI_SWITCHPORT', null, 'ifOutUcastPkts_t1', '单向传输数据包', 'NUMBER', null, 1, '0', null, null, '1', 35, null, '1.3.6.1.2.1.2.2.1.17', null, 1);
insert into METADATA (ID, CHECK_TYPE_ID, TABLE_NAME, TABLE_COMMENTS, FILED_NAME, FILED_COMMENTS, FILED_TYPE, CREATE_DATE, CREATE_PERSON, STATE, UPDATE_DATE, UPDATE_PERSON, CHART_STATE, SHOW_NUM, ISNULL, OID, TYPE_ID, SORT_SIGN)
values (seq_metadata.nextval/*305*/, 10, 'DI_SWITCHPORT', null, 'ifOutNUcastPkts_t1', '非单向传输数据包', 'NUMBER', null, 1, '0', null, null, '1', 36, null, '1.3.6.1.2.1.2.2.1.18', null, 1);
insert into METADATA (ID, CHECK_TYPE_ID, TABLE_NAME, TABLE_COMMENTS, FILED_NAME, FILED_COMMENTS, FILED_TYPE, CREATE_DATE, CREATE_PERSON, STATE, UPDATE_DATE, UPDATE_PERSON, CHART_STATE, SHOW_NUM, ISNULL, OID, TYPE_ID, SORT_SIGN)
values (seq_metadata.nextval/*307*/, 10, 'DI_SWITCHPORT', null, 'Data_64_FLag', '64位数据标识', 'NUMBER', null, 1, '0', null, null, '1', 38, null, '.0', null, 1);
commit;


-- di_switch表新增字段
alter table di_switchport add (IFINOCTETS_T1 NUMBER);
comment on column di_switchport.IFINOCTETS_T1 is '接口收到的总字节数';

alter table di_switchport add (IFINUCASTPKTS_T1 NUMBER);
comment on column di_switchport.IFINUCASTPKTS_T1 is '单点发送到一种高层协议上的包的总数目';

alter table di_switchport add (IFINNUCASTPKTS_T1 NUMBER);
comment on column di_switchport.IFINNUCASTPKTS_T1 is '发往高层协议的非单播包数（广播和多播）';

alter table di_switchport add (IFOUTOCTETS_T1 NUMBER);
comment on column di_switchport.IFOUTOCTETS_T1 is '接口发送的总字节数';

alter table di_switchport add (IFOUTUCASTPKTS_T1 NUMBER);
comment on column di_switchport.IFOUTUCASTPKTS_T1 is '高层协议请求传输的单播包数';

alter table di_switchport add (IFOUTNUCASTPKTS_T1 NUMBER);
comment on column di_switchport.IFOUTNUCASTPKTS_T1 is '高层协议请求的非单播（广播和多播）包数';

alter table di_switchport add (IFHIGHSPEED NUMBER);
comment on column di_switchport.IFHIGHSPEED is '端口带宽（Mbps）';

alter table di_switchport add (DATA_64_FLAG NUMBER);
comment on column di_switchport.DATA_64_FLAG is '64位数据标识 0否 1是';


