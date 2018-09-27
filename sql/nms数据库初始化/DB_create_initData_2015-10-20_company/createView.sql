-------------------------------------------
-- Export file for user NMS              --
-- Created by dell on 2015/5/5, 11:17:31 --
-------------------------------------------

spool createView.log

prompt
prompt Creating view V_DETECTION_INFO_NEW
prompt ==================================
prompt
create or replace view v_detection_info_new as
select "ID","DETECTION_SET_INFO_ID","CHECK_WAY","DETECTION_STATE_INFO","PERFORMACE_DATA","CURRENT_TIMES","START_TIME","WAIT_TIME","DELAY_TIME","NEXT_CHECK_TIME","OFF_LINE","POLICE_LEVEL","DATA_CHECK_TIME","DATA_ARRIVE_TIME","DETECTIONED_STATE","STATUS_CHANGE_TIME","DATA_CHECK_TIME_DIGITAL","DATA_ARRIVE_TIME_DIGITAL","SEQ_ID","NODE_IP" from (
  select din.id,din.detection_set_info_id,(case dsi.check_way when '0' then'主动' else '被动' end) check_way
  ,din.detection_state_info,din.performace_data,din.current_times,din.start_time,din.wait_time
  ,din.delay_time,din.next_check_time,din.off_line,din.police_level,din.data_check_time
  ,din.data_arrive_time,din.detectioned_state,din.status_change_time,din.data_check_time_digital
  ,din.data_arrive_time_digital,din.seq_id,nt.node_ip
    from DETECTION_INFO_NEW din
    left join DETECTION_SET_INFO dsi
    on din.detection_set_info_id = dsi.id
    left join (select distinct node_ip,seq_id from  NODE_TABLE) nt
    on din.seq_id = nt.seq_id
   )
/

prompt
prompt Creating view V_DETECTION_SET_INFO
prompt ==================================
prompt
create or replace view v_detection_set_info as
select dsi."ID",dsi."NODE_IP",dsi."CHECK_TYPE_ID",dsi."CHECK_GAP",dsi."CHECK_WAY",dsi."CHECK_OUT_TIME",dsi."CHECK_MAX_TIMES",dsi."PROCESS_IDEN",dsi."DETECTION_SET_STATE",dsi."PROCESS_FILE",dsi."PROCESS_PATH",dsi."OID",dsi."IS_CONTROL_START",dsi."IS_ISSUE_FILE",dsi."IS_ISSUED",dsi."CONTROL_START_TIME",dsi."UPLOAD_GAP",dsi."IS_ISSUE",dsi."PLAN_CHECK_TIME",dsi."GROUP_ID",dsi."VIEW_LEVEL",dsi."CONTACT_USER_IDS",dsi."CREATE_USER_ID",dsi."CREATE_USERGROUP_ID",dsi."SYSTEM_ID",dsi."NODE_GROUPS_ID",dsi."NODE_IPS_ID",dsi.process_search_keycode,ngt.group_id node_group_id,ngt.is_valid,nt.node_id,nt.node_state,nt.seq_id from detection_set_info dsi
left join nodegroup_table ngt  on ('0,'||dsi.node_groups_id||',0' like '%,' || ngt.group_id || ',%')
left join node_table nt  on ('0,'||dsi.node_ips_id||',0' like '%,' || nt.node_id || ',%')
  and nt.node_group_id = ngt.group_id
/

prompt
prompt Creating view V_MISSION_NODE_GROUP_1
prompt ====================================
prompt
create or replace view v_mission_node_group_1 as
select mpt1.mission_id,ngt.group_id node_group_id,ngt.is_valid
from mission_parameter_table1 mpt1
left join nodegroup_table ngt  on ('0,'||nvl(mpt1.node_groups_id,'0')||',0' like '%,' || ngt.group_id || ',%')
/

prompt
prompt Creating view V_MISSION_NODE_GROUP_4
prompt ====================================
prompt
create or replace view v_mission_node_group_4 as
select mpt4.mission_id,ngt.group_id node_group_id,ngt.is_valid
from mission_parameter_table4 mpt4
left join nodegroup_table ngt  on ('0,'||nvl(mpt4.node_groups_id,'0')||',0' like '%,' || ngt.group_id || ',%')
/

prompt
prompt Creating view V_MISSION_NODE_GROUP_6
prompt ====================================
prompt
create or replace view v_mission_node_group_6 as
select mpt6.mission_id,ngt.group_id node_group_id,ngt.is_valid
from mission_parameter_table6 mpt6
left join nodegroup_table ngt  on ('0,'||nvl(mpt6.node_groups_id,'0')||',0' like '%,' || ngt.group_id || ',%')
/


spool off
