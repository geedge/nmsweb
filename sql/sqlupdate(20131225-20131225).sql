--为 业务逻辑拓扑、告警信息、异常服务器、异常网元、系统预警信息菜单 设置过滤条件(告警级别、是否紧急)
1.新增模块：监测过滤配置  /sysManage/dataDictionary.do?action=queryDetectConditionSet
2.为对应角色添加此模块
3.建表
create table SET_DET_DATA_CON
(
  ID              NUMBER not null,
  MENU_NAME       VARCHAR2(200),
  POLICE_LEVEL    VARCHAR2(200),
  POLICE_EMERGENT VARCHAR2(20),
  MENU_CODE       VARCHAR2(100)
);
-- Add comments to the table 
comment on table SET_DET_DATA_CON
  is '监测数据列表过滤条件的设置信息表';
-- Add comments to the columns 
comment on column SET_DET_DATA_CON.MENU_NAME
  is '菜单名称，对应菜单名称修改时，可以修改，用于显示给用户';
comment on column SET_DET_DATA_CON.POLICE_LEVEL
  is '告警级别：目前支持1-5级';
comment on column SET_DET_DATA_CON.POLICE_EMERGENT
  is '告警是否紧急 0：紧急  1：非紧急';
comment on column SET_DET_DATA_CON.MENU_CODE
  is '菜单编号，不会改变';

4.建sequence
-- Create sequence 
create sequence SEQ_SET_DET_DATA_CON
minvalue 1
maxvalue 99999999999999999
start with 6
increment by 1
cache 20
cycle
order;

insert into set_det_data_con (ID, MENU_NAME, POLICE_LEVEL, POLICE_EMERGENT, MENU_CODE)
values (1, '业务逻辑拓扑', '', ',0,', 'logicTopo');

insert into set_det_data_con (ID, MENU_NAME, POLICE_LEVEL, POLICE_EMERGENT, MENU_CODE)
values (2, '告警信息', '', ',0,', 'allWarningInfo');

insert into set_det_data_con (ID, MENU_NAME, POLICE_LEVEL, POLICE_EMERGENT, MENU_CODE)
values (3, '异常服务器', '', '', 'serverWarningInfo');

insert into set_det_data_con (ID, MENU_NAME, POLICE_LEVEL, POLICE_EMERGENT, MENU_CODE)
values (4, '异常网元', '', '', 'netEleWarningInfo');

insert into set_det_data_con (ID, MENU_NAME, POLICE_LEVEL, POLICE_EMERGENT, MENU_CODE)
values (5, '报警信息  ', '', ',0,', 'emergentwarningInfo');

commit;
