-------------------------------------------
-- Export file for user NMS              --
-- Created by dell on 2015/5/5, 11:32:26 --
-------------------------------------------

spool createTrigger.log

prompt
prompt Creating trigger AFTER_DELETE_NODE_TABLE
prompt ========================================
prompt
CREATE OR REPLACE TRIGGER AFTER_DELETE_NODE_TABLE
  after delete on node_table
declare
  -- local variables here
  v_cnt number(10);
  v_seqId Node_Table.Seq_Id%Type;
begin
  -- 3、在语句级触发器里循环查询NODE_TABLE表中该SEQID是否有记录，没有则清空NODE_LATTICE_TABLE表中相关记录
  for v_loopIndex in 1..pack_nodelattice.v_numbers loop
      v_seqId:= pack_nodelattice.v_nodeSeqs(pack_nodelattice.v_numbers);
      select count(*) into v_cnt from node_table n where n.seq_id=v_seqId;
      if v_cnt=0 then
         update node_lattice_table t set t.node_seq=null where t.node_seq=v_seqId;
      end if;
  end loop;

end AFTER_DELETE_NODE_TABLE;
/

prompt
prompt Creating trigger BEFORE_DELETE_NODE_TABLE
prompt =========================================
prompt
CREATE OR REPLACE TRIGGER BEFORE_DELETE_NODE_TABLE
  before delete on node_table
  for each row
declare
  -- local variables here
begin
  -- 2、在行级触发器里保存删除节点的SEQID
  pack_nodelattice.v_numbers := pack_nodelattice.v_numbers+1;
  pack_nodelattice.v_nodeSeqs(pack_nodelattice.v_numbers) := :old.seq_id;
end BEFORE_DELETE_NODE_TABLE;
/

prompt
prompt Creating trigger BEFORE_DETECTION_SET_INFO
prompt ==========================================
prompt
Create Or Replace Trigger Before_detection_set_info
  before insert on detection_set_info
  for each row
declare
  -- local variables here
begin
if ( :new.id is null )   --insert
then
   select seq_detection_set_info.nextVal into :new.id from dual ;
end if;

end Before_detection_set_info;
/

prompt
prompt Creating trigger BEFORE_INSERT_DETECTION_INFO
prompt =============================================
prompt
create or replace trigger before_insert_detection_info
  before insert on DETECTION_INFO
  for each row
declare

  -- attributies
  detection_info_id_a      number        := :new.id; -- 监测记录id
  detection_set_info_id_a  NUMBER        := :new.detection_set_info_id;  -- 监测设置id，外键
  check_way_a              CHAR(1)       := :new.check_way;              -- 监测方式不能为空，可选[0/1]0主动、1被动（设置为主动可能本记录为被动）
  detection_state_info_a   VARCHAR2(4000) := :new.detection_state_info;   -- 状态信息
  performace_data_a        VARCHAR2(4000) := :new.performace_data;        -- 性能数据
  current_times_a          NUMBER        := :new.current_times;          -- 当前尝试次数
  start_time_a             DATE          := :new.start_time;             -- 开机时间（开运时间）
  wait_time_a              NUMBER        := :new.wait_time;              -- 检测等待时间单位秒
  delay_time_a             NUMBER        := :new.delay_time;             -- 检测时延单位秒
  next_check_time_a        DATE          := :new.next_check_time;        -- 下一次计划主动式检测时间
  off_line_a               DATE          := :new.off_line;               -- 计划宕机时间
  police_level_a           NUMBER        := :new.police_level;           -- 告警级别
  data_check_time_a        DATE          := :new.data_check_time;        -- 获取监测数据时间
  data_arrive_time_a       DATE          := :new.data_arrive_time;       -- 数据入库时间
  detectioned_state_a      VARCHAR2(2)   := :new.detectioned_state;      -- 被监控状态是否正常：0不正常；1正常
  seq_id_a                 NUMBER        := :new.seq_id;
  --notice_flag_a            CHAR(1)       := '0'  ;                        -- 是否已发通知:0未发；1已发
  node_ip_a                VARCHAR2(15)  := :new.node_ip;                 -- 节点IP
  data_check_time_digital_a  NUMBER        := :new.data_check_time_digital;                --获取监测数据时间 数字类型
  data_arrive_time_digital_a NUMBER        := :new.data_arrive_time_digital;                --数据入库时间 数字类型
  POLICE_EMERGENT_a          NUMBER      := :new.POLICE_EMERGENT;
  --params
  info_new_flag            NUMBER        := 0 ;                          -- 判断是否为最新监控数据 缺省0 数据不存在，需要insert，为1 需要update 为2 无需操作
  status_change_time_a     DATE;
  --info_warning_flag        NUMBER        := 0 ;                           -- 判断是否为警报信息  缺省为0 否则为1
  --check_gap_temp                  NUMBER;
 --CURSOR
  CURSOR info_new_cursor is
  select * from detection_info_new din
  where din.detection_set_info_id = detection_set_info_id_a
  --and din.node_ip = node_ip_a
  and din.seq_id = seq_id_a
  order by din.data_check_time desc;
  info_new_row  detection_info_new%ROWTYPE;               -- 游标名的声明 与 指定游标集合结构 定义。

begin
OPEN info_new_cursor;  -- 打开游标
  LOOP     -- 循环开始
      FETCH info_new_cursor INTO info_new_row;    -- 将游标集合存到游标中
      EXIT WHEN info_new_cursor%NOTFOUND;   -- 循环条件
      --是否更新detection_info_new表标识判断
      IF ( info_new_row.data_check_time < :new.data_check_time )
      THEN info_new_flag := 1;              -- 判断结构开始，当前记录是新更新detection_info_new表
      ELSE info_new_flag := 2;              -- 跳过detection_info_new保存，当前记录非最新纪录，无需更新
      END IF;         --判断结构结束

      IF(info_new_flag = 0 or info_new_flag = 1)
      THEN

        --状态变更字段判断
        --如果监测记录的状态变化，或者监测记录状态未变但是报警级别变化
        IF (info_new_row.detectioned_state <> detectioned_state_a or (info_new_row.detectioned_state = detectioned_state_a and info_new_row.police_level <> police_level_a))
        THEN
            :new.status_change_time := data_check_time_a;      -- 新入数据状态变更时间 更新
            status_change_time_a := data_check_time_a;
        ELSE     --状态无变更时 数据使用new表状态变更时间insert into TESTTRRGGER(ID,DID,TEXT) values(SEQ_testtrrgger.Nextval,:new.id,'开始触发器info_new_row.data_check_time < :new.start_time');
          --判断当前记录是不是正常入库数据，如果和detection_info_new表的记录间隔在两个周期之内为正常数据，大于两个周期则新监测时间为状态变更时间
            status_change_time_a := info_new_row.status_change_time;
            :new.status_change_time := info_new_row.status_change_time;
        END IF;

        --状态持续时间为空时，默认取监测时间
        if(status_change_time_a is null)
        then
             status_change_time_a := :new.data_check_time;
        end if;

        --新状态持续时间为NC监测启动时间
        IF( status_change_time_a < :new.start_time)
        THEN
             status_change_time_a := :new.start_time;
        END IF;
      end if;
  END LOOP;           --循环结束
  CLOSE info_new_cursor;   -- 关闭游标

  --节点设置在detection_info_new表没有对应记录，新增。新增记录中的状态变更时间为监测时间
  if ( info_new_flag = 0 )   --insert
  THEN
  status_change_time_a := :new.data_check_time;
            insert into detection_info_new
            (detection_set_info_id  ,check_way  ,detection_state_info  ,performace_data  ,current_times  ,start_time  ,wait_time  ,delay_time  ,next_check_time  ,off_line  ,police_level  ,node_ip  ,data_check_time  ,data_arrive_time  ,detectioned_state  ,status_change_time  ,seq_id  ,detection_info_id,data_check_time_digital,data_arrive_time_digital      ,POLICE_EMERGENT  ) values
            (detection_set_info_id_a,check_way_a,detection_state_info_a,performace_data_a,current_times_a,start_time_a,wait_time_a,delay_time_a,next_check_time_a,off_line_a,police_level_a,node_ip_a,data_check_time_a,data_arrive_time_a,detectioned_state_a,status_change_time_a,seq_id_a,detection_info_id_a,data_check_time_digital_a,data_arrive_time_digital_a,POLICE_EMERGENT_a);
  end if;

  --节点设置在detection_info_new表有相应记录并且是新记录，则更新detection_info_new记录
  if ( info_new_flag = 1 )   --update
  THEN

    update detection_info_new din set
            din.check_way =check_way_a
            , din.detection_state_info = detection_state_info_a
            , din.performace_data = performace_data_a
            , din.current_times = current_times_a
            , din.start_time = start_time_a
            , din.wait_time = wait_time_a
            , din.delay_time = delay_time_a
            , din.next_check_time = next_check_time_a
            , din.off_line = off_line_a
            , din.police_level = police_level_a
            , din.node_ip = node_ip_a
            , din.data_check_time = data_check_time_a
            , din.data_arrive_time = data_arrive_time_a
            , din.detectioned_state = detectioned_state_a
            , din.status_change_time = status_change_time_a
            , detection_info_id = detection_info_id_a
            ,data_check_time_digital = data_check_time_digital_a
            ,data_arrive_time_digital = data_arrive_time_digital_a
            ,POLICE_EMERGENT = POLICE_EMERGENT_a
            where din.detection_set_info_id = detection_set_info_id_a
            and din.seq_id = seq_id_a;

  end if;

end before_insert_detection_info;
/

prompt
prompt Creating trigger BEFORE_INSERT_EMAIL_TABLE
prompt ==========================================
prompt
Create Or Replace Trigger Before_insert_EMAIL_TABLE
  before insert on EMAIL_TABLE
  for each row
declare
  -- local variables here
begin
if ( :new.id is null )   --insert
then
    select SEQ_EMAIL_TABLE.nextVal into :new.id from dual ;
end if;

end Before_insert_EMAIL_TABLE;
/

prompt
prompt Creating trigger BEFORE_INSERT_EVENT_RECORD_L
prompt =============================================
prompt
Create Or Replace Trigger Before_insert_event_record_L
  before insert on event_record_library
  for each row
declare
  -- local variables here
begin
if ( :new.id is null )   --insert
then
    select seq_event_record_library.nextVal into :new.id from dual ;
end if;

end Before_insert_event_record_L;
/

prompt
prompt Creating trigger BEFORE_INSERT_IP_SEGMENT
prompt =========================================
prompt
Create Or Replace Trigger Before_insert_ip_segment
  before insert on server_ip_segment
  for each row
declare
  -- local variables here
begin
if ( :new.id is null )   --insert
then
    select seq_server_ip_segment.nextVal into :new.id from dual ;
end if;

end Before_insert_ip_segment;
/

prompt
prompt Creating trigger BEFORE_INSERT_LOOPMISSION_INFO
prompt ===============================================
prompt
Create Or Replace Trigger Before_insert_loopmission_info
  before insert on loopmission_state_table
  for each row
declare
  -- local variables here
begin
  if ( :new.CUR_MISSION_ID is null )   --insert
then
    select seq_mission_state_table.nextVal into :new.CUR_MISSION_ID from dual ;
end if;

end Before_insert_loopmission_info;
/

prompt
prompt Creating trigger BEFORE_INSERT_NODE_TABLE
prompt =========================================
prompt
create or replace trigger before_insert_node_table
 before insert on node_table
  for each row
declare
  NODE_IP_A          VARCHAR2(64)   := :new.node_ip;
  TEMP_NODE_ID NUMBER;
  info_new_flag NUMBER;
  info_is_auto number :=0;
   CURSOR info_new_cursor is
    select nt.node_id,nt.node_ip,nt.node_group_id from node_table nt
    where nt.node_ip = NODE_IP_A and nt.node_group_id in
    (select ngt.group_id from nodegroup_table ngt where ngt.group_name='默认节点组' )
    and nt.node_state = 0;
    info_new_row info_new_cursor%ROWTYPE;
  begin
  OPEN info_new_cursor;
  LOOP
     FETCH info_new_cursor INTO info_new_row;
     EXIT WHEN info_new_cursor%NOTFOUND;
insert into TESTTRRGGER(ID,TRRIGERNAME,DID,TEXT) values(SEQ_testtrrgger.Nextval,'before_insert_node_table',info_new_row.node_id,'before_insert_node_table触发器');
       select ngt.group_id into info_is_auto from nodegroup_table ngt where ngt.group_name='默认节点组' and ngt.group_id=info_new_row.NODE_GROUP_ID;
      IF ( info_is_auto != 0)
      then info_new_flag := 1;
      insert into TESTTRRGGER(ID,TRRIGERNAME,DID,TEXT) values(SEQ_testtrrgger.Nextval,'before_insert_node_table',info_new_row.node_id,'info_new_flag := 1人工操作节点信息');

      END IF;
      TEMP_NODE_ID := info_new_row.node_id;
       insert into TESTTRRGGER(ID,TRRIGERNAME,DID,TEXT) values(SEQ_testtrrgger.Nextval,'before_insert_node_table',info_new_row.node_id,'人工操作节点信息给删除id赋值'||TEMP_NODE_ID||'info_new_flag'||info_new_flag);

  END LOOP;
CLOSE info_new_cursor;

if ( info_new_flag = 1 )
then
insert into TESTTRRGGER(ID,TRRIGERNAME,DID,TEXT) values(SEQ_testtrrgger.Nextval,'before_insert_node_table',info_new_row.node_id,'info_new_flag := 1人工操作时删除自动节点信息'||TEMP_NODE_ID);

  update  node_table nt set nt.node_state = 1
          where nt.node_id = TEMP_NODE_ID;
end if;
end before_insert_node_table;
/

prompt
prompt Creating trigger BEFORE_INSERT_SEQ_INFO
prompt =======================================
prompt
Create Or Replace Trigger Before_insert_seq_info
  before insert on detection_info
  for each row
declare
  -- local variables here
begin
if ( :new.id is null )   --insert
then
    select seq_detection_info.nextVal into :new.id from dual ;
end if;

end Before_insert_seq_info;
/

prompt
prompt Creating trigger BEFORE_INSERT_SEQ_INFO_NEW
prompt ===========================================
prompt
Create Or Replace Trigger Before_insert_seq_info_new
  before insert on DETECTION_INFO_NEW
  for each row
declare
  -- local variables here
begin
if ( :new.id is null )   --insert
then
    select seq_detection_info_new.nextVal into :new.id from dual ;
end if;

end Before_insert_seq_info_new;
/

prompt
prompt Creating trigger BEFORE_INSERT_SEQ_INFO_WARNING
prompt ===============================================
prompt
Create Or Replace Trigger Before_insert_seq_info_warning
  before insert on detection_info_warning
  for each row
declare
  -- local variables here
begin

if ( :new.id is null )   --insert
then
    select seq_detection_info.nextVal into :new.id from dual ;
end if;
end Befor_insert_seq_dinfo_warning;
/

prompt
prompt Creating trigger BEFORE_INSERT_SEQ_NODEGROUP
prompt ============================================
prompt
Create Or Replace Trigger Before_insert_seq_nodegroup
  before insert on nodegroup_table
  for each row
declare
  -- local variables here
begin
if ( :new.group_id is null )   --insert
then
   select seq_nodegroup_table.nextVal into :new.group_id from dual ;
end if;

end Before_insert_seq_nodegroup;
/

prompt
prompt Creating trigger BEFORE_INSERT_SEQ_NODE_TABLE
prompt =============================================
prompt
Create Or Replace Trigger Before_insert_seq_node_table
  before insert on node_table
  for each row
declare
  -- local variables here
begin
if ( :new.node_id is null )   --insert
then
   select seq_node_table.nextVal into :new.node_id from dual ;
end if;

end Before_insert_seq_node_table;
/

prompt
prompt Creating trigger BEFORE_NMS_ERROR_INFO
prompt ======================================
prompt
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

/*IF(:NEW.error_state = 2)
THEN
    UPDATE nms_error_info nei SET nei.error_state=0,nei.state_update_time=:NEW.state_update_time WHERE nei.error_state=1 AND nei.error_code=:NEW.ERROR_CODE AND nei.error_des = :NEW.error_des AND nei.error_time<:NEW.error_time;
END IF;*/
end Before_insert_nms_error_info;
/

prompt
prompt Creating trigger BEFORE_UPDATE_MISSION_RESULT_1
prompt ===============================================
prompt
CREATE OR REPLACE TRIGGER BEFORE_UPDATE_MISSION_RESULT_1
  BEFORE UPDATE ON "MISSION_RESULT_TABLE1"
  REFERENCING OLD AS o NEW AS n FOR EACH ROW
DECLARE
  --中间参数
  --length_rda         number                := lengthb(nvl(:o.result_desc,'')||nvl(:n.result_desc,''));
BEGIN
  --任务结果更新过滤
  if updating('result') then
     if (:n.result <> -1 and ((:o.result = 0) or (:o.result = 1) or (:n.result is null))) then
     :n.result := :o.result;
     end if;

  end if;
  --任务结果描述更新
  if updating('result_desc') then
   :n.result_desc := nvl(:o.result_desc,'')||nvl(:n.result_desc,'');
  end if;
  --if(length_rda <= 1024)
  --then
  --:n.result_desc := nvl(:o.result_desc,'')||nvl(:n.result_desc,'');
  --else
  --:n.result_desc := substr(nvl(:o.result_desc,'')||nvl(:n.result_desc,''),length_rda + 1 - 1024, 1024);
  --end if;
END;
/

prompt
prompt Creating trigger BEFORE_UPDATE_MISSION_RESULT_4
prompt ===============================================
prompt
CREATE OR REPLACE TRIGGER BEFORE_UPDATE_MISSION_RESULT_4
  BEFORE UPDATE ON "MISSION_RESULT_TABLE4"
  REFERENCING OLD AS o NEW AS n FOR EACH ROW
DECLARE
  --中间参数
  --length_rda         number                := lengthb(nvl(:o.result_desc,'')||nvl(:n.result_desc,''));
BEGIN
  -- 思路整理：
  -- result_4 存在两种业务
  --    1、有效任务执行流程
  --        程序中将任务结果状态初始化为3 中间结果为40、50、60、70、80、81
  --        最终结果为0（成功）或1（失败）  结果不再变更
  --    2、撤销任务执行流程
  --        程序将任意结果变更为5  中间结果为6（已下发）
  --        最终结果为7（撤销完成） 结果不再变更
  -- 整理 根据旧信息状态区别两种业务 对5、6、7 结果指定处理；其他结果为另一业务
  --      5可覆盖除了7以外的任意结果

  -- 结果变更实现
  if updating('result') THEN
     -- 业务撤销任务执行流程 7为最终结果
     if (:n.result in (5,6,7)) then
        if (:o.result = 7) then
           :n.result := :o.result;
        end if;
     else
     -- 业务有效任务执行流程 撤销任务的状态不可更改
        if (:o.result in (5,6,7)) then
           :n.result := :o.result;
        else
           --任务结果更新过滤 0或1 或结果为空时保持旧的结果
           if (:n.result <> -1 and ((:o.result = 0) or (:o.result = 1) or (:n.result is null)))  then
              :n.result := :o.result;
           end if;
        end if;
     end if;
  end if;

  --任务结果描述更新
  if updating('result_desc') then
     if :o.result_desc is not null and :n.result_desc is not null and instr(:o.result_desc,:n.result_desc)>0 then  --如果结果描述里已包括新描述，则不组合描述，不然会造成相同描述出现多次
        :n.result_desc := nvl(:o.result_desc,'');
     else --否则将新旧描述组合
        :n.result_desc := nvl(:o.result_desc,'')||nvl(:n.result_desc,'');
     end if;
  end if;

  --回传文件信息处理，非空时，和原有数据拼接再保存
  if updating('file_info') THEN
     if (:o.file_info is not NULL) then
         if(:n.file_info is not null) then
             :n.file_info := nvl(:o.file_info,'')||'@@@'||nvl(:n.file_info,'');
         else
             :n.file_info := nvl(:o.file_info,'');
         end if;

     end if;
  end if;
END;
/

prompt
prompt Creating trigger BEFORE_UPDATE_MISSION_RESULT_6
prompt ===============================================
prompt
CREATE OR REPLACE TRIGGER BEFORE_UPDATE_MISSION_RESULT_6
  BEFORE UPDATE ON "MISSION_RESULT_TABLE6"
  REFERENCING OLD AS o NEW AS n FOR EACH ROW
DECLARE
  --中间参数
  --length_rda         number                := lengthb(nvl(:o.result_desc,'')||nvl(:n.result_desc,''));
BEGIN
  --任务结果更新过滤
  if updating('result') then
     if (:n.result <> -1 and ((:o.result = 0) or (:o.result = 1) or (:n.result is null))) then
        :n.result := :o.result;
     end if;
  end if;
  --任务结果描述更新
  if updating('result_desc') then
   :n.result_desc := nvl(:o.result_desc,'')||nvl(:n.result_desc,'');
  end if;

  --if(length_rda <= 1024)
  --then
  --:n.result_desc := nvl(:o.result_desc,'')||nvl(:n.result_desc,'');
  --else
  --:n.result_desc := substr(nvl(:o.result_desc,'')||nvl(:n.result_desc,''),length_rda + 1 - 1024, 1024);
  --end if;
END;
/

prompt
prompt Creating trigger BEFORE_UPDATE_MISSION_STATE_T
prompt ==============================================
prompt
CREATE OR REPLACE TRIGGER BEFORE_UPDATE_MISSION_STATE_T
  BEFORE UPDATE ON "MISSION_STATE_TABLE"
  FOR EACH ROW
DECLARE
      --mid     number                   := 0 ;
      --AUTO_DESC_a            varchar2(3000)            :=:new.AUTO_DESC;
BEGIN


     if updating('AUTO_DESC') then
        :new.AUTO_DESC := nvl(:old.AUTO_DESC,'')||chr(10)||nvl(:new.AUTO_DESC,'');
     end if;


    --if(:new.AUTO_DESC is not null) then

     --   select seq_event_record_library.nextval into mid from dual ;
     --   insert into event_record_library (ID,RECORD_COMMAND) values (mid,AUTO_DESC_a);

        --:new.AUTO_DESC := nvl(:old.AUTO_DESC,'')||chr(10)||nvl(:new.AUTO_DESC,'');
    --end if;
END;


--lengthb(nvl(:o.result_desc,'')||nvl(:n.result_desc,''));
/

prompt
prompt Creating trigger B_I_DELECT_INFO_NMSC
prompt =====================================
prompt
create or replace trigger B_I_delect_info_nmsc before insert on delect_info_nmsc for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_delect_info_nmsc.nextVal into :new.id from dual;
end if;
     end B_I_delect_info_nmsc;
/

prompt
prompt Creating trigger B_I_DETECT_INFO_CPU
prompt ====================================
prompt
create or replace trigger B_I_detect_info_cpu before insert on detect_info_cpu for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_detect_info_cpu.nextVal into :new.id from dual;
end if;
     end B_I_detect_info_cpu;
/

prompt
prompt Creating trigger B_I_DETECT_INFO_DISK
prompt =====================================
prompt
create or replace trigger B_I_detect_info_disk before insert on detect_info_disk for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_detect_info_disk.nextVal into :new.id from dual;
end if;
     end B_I_detect_info_disk;
/

prompt
prompt Creating trigger B_I_DETECT_INFO_MEMORY
prompt =======================================
prompt
create or replace trigger B_I_detect_info_memory before insert on detect_info_memory for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_detect_info_memory.nextVal into :new.id from dual;
end if;
     end B_I_detect_info_memory;
/

prompt
prompt Creating trigger B_I_DETECT_INFO_NETDATA
prompt ========================================
prompt
create or replace trigger B_I_detect_info_netdata before insert on detect_info_netdata for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_detect_info_netdata.nextVal into :new.id from dual;
end if;
     end B_I_detect_info_netdata;
/

prompt
prompt Creating trigger B_I_DETECT_INFO_PING
prompt =====================================
prompt
create or replace trigger B_I_detect_info_ping before insert on detect_info_ping for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_detect_info_ping.nextVal into :new.id from dual;
end if;
     end B_I_detect_info_ping;
/

prompt
prompt Creating trigger B_I_DETECT_INFO_PROCESS
prompt ========================================
prompt
create or replace trigger B_I_detect_info_process before insert on detect_info_process for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_detect_info_process.nextVal into :new.id from dual;
end if;
     end B_I_detect_info_process;
/

prompt
prompt Creating trigger B_I_DETECT_INFO_SNMP_TRAP
prompt ==========================================
prompt
create or replace trigger B_I_detect_info_snmp_trap before insert on detect_info_snmp_trap for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_detect_info_snmp_trap.nextVal into :new.id from dual;
end if;
     end B_I_detect_info_snmp_trap;
/

prompt
prompt Creating trigger B_I_DETECT_INFO_SYSTEM_DATE
prompt ============================================
prompt
create or replace trigger B_I_detect_info_system_date before insert on detect_info_system_date for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_detect_info_system_date.nextVal into :new.id from dual;
end if;
     end B_I_detect_info_system_date;
/

prompt
prompt Creating trigger B_I_DI_DPSLOTENTRY
prompt ===================================
prompt
create or replace trigger B_I_DI_DPSLOTENTRY before insert on DI_DPSLOTENTRY for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_DI_DPSLOTENTRY.nextVal into :new.id from dual;
end if;
     end B_I_DI_DPSLOTENTRY;
/

prompt
prompt Creating trigger B_I_DI_DPSYSTEMFANENTRY
prompt ========================================
prompt
create or replace trigger B_I_di_dpsystemfanentry before insert on di_dpsystemfanentry for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_di_dpsystemfanentry.nextVal into :new.id from dual;
end if;
     end B_I_di_dpsystemfanentry;
/

prompt
prompt Creating trigger B_I_DI_DPSYSTEMPOWERENTRY
prompt ==========================================
prompt
create or replace trigger B_I_di_dpsystempowerentry before insert on di_dpsystempowerentry for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_di_dpsystempowerentry.nextVal into :new.id from dual;
end if;
     end B_I_di_dpsystempowerentry;
/

prompt
prompt Creating trigger B_I_DI_DPSYSTEMSTATUS
prompt ======================================
prompt
create or replace trigger B_I_di_dpsystemstatus before insert on di_dpsystemstatus for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_di_dpsystemstatus.nextVal into :new.id from dual;
end if;
     end B_I_di_dpsystemstatus;
/

prompt
prompt Creating trigger B_I_DI_IFXTABLE
prompt ================================
prompt
create or replace trigger B_I_di_ifxtable before insert on di_ifxtable for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_di_ifxtable.nextVal into :new.id from dual;
end if;
     end B_I_di_ifxtable;
/

prompt
prompt Creating trigger B_I_DI_SWITCHPORT
prompt ==================================
prompt
create or replace trigger B_I_di_switchport before insert on di_switchport for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_di_switchport.nextVal into :new.id from dual;
end if;
     end B_I_di_switchport;
/

prompt
prompt Creating trigger B_I_DI_SYSTEM
prompt ==============================
prompt
create or replace trigger B_I_di_system before insert on di_system for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_di_system.nextVal into :new.id from dual;
end if;
     end B_I_di_system;
/

prompt
prompt Creating trigger B_I_DI_SYSTEMINFO
prompt ==================================
prompt
create or replace trigger B_I_di_systeminfo before insert on di_systeminfo for each row
declare

begin
if ( :new.id is null )   --insert
then
     select seq_di_systeminfo.nextVal into :new.id from dual;
end if;
     end B_I_di_systeminfo;
/


spool off
