--字典表调整
drop table OPTION_TABLE;
drop table TYPE_TABLE;
-- Create table
-- Create table
create table OPTION_TABLE
(
  ID            NUMBER not null,
  TYPE_IDENTITY VARCHAR2(50) not null,
  TYPE_CODE     VARCHAR2(64),
  TYPE_VALUE    VARCHAR2(64),
  SHOW_NUM      NUMBER,
  TYPE_STATE    NUMBER default 0,
  DELAY_TIME    VARCHAR2(50)
)
;
comment on column OPTION_TABLE.TYPE_CODE
  is '字典项代码同一TYPE_ID下不重复';
comment on column OPTION_TABLE.TYPE_VALUE
  is '字典项名称';
comment on column OPTION_TABLE.SHOW_NUM
  is '字典项显示序号';
comment on column OPTION_TABLE.TYPE_STATE
  is '字典项状态0启用；1停用';
comment on column OPTION_TABLE.DELAY_TIME
  is '为0时，即时发，为-1时不发，其他数值为延时分钟数';
alter table OPTION_TABLE
  add constraint PRIMARYOPTION_TABLE1 primary key (ID);
  
  
-- Create table
create table TYPE_TABLE
(
  ID            NUMBER not null,
  SHOW_NUM      NUMBER default 0,
  TYPE_STATE    NUMBER default 0 not null,
  TYPE_DESC     VARCHAR2(200),
  TYPE_NAME     VARCHAR2(50) not null,
  TYPE_IDENTITY VARCHAR2(50) not null
)
;
comment on table TYPE_TABLE
  is '字典类型定义表：定义字典大类型';
comment on column TYPE_TABLE.SHOW_NUM
  is '显示序号';
comment on column TYPE_TABLE.TYPE_STATE
  is '状态0启用；1停用';
comment on column TYPE_TABLE.TYPE_DESC
  is '描述';
comment on column TYPE_TABLE.TYPE_NAME
  is '字典类型名称，不为空不重复';
comment on column TYPE_TABLE.TYPE_IDENTITY
  is '字典标识，不为空不重复';
alter table TYPE_TABLE
  add constraint PRIMARYTYPE_TABLE primary key (ID);

insert into type_table (ID, SHOW_NUM, TYPE_STATE, TYPE_DESC, TYPE_NAME, TYPE_IDENTITY)
values (seq_type_table.nextval, 3, 0, '', '网元节点分类', 'netelementtype');

insert into type_table (ID, SHOW_NUM, TYPE_STATE, TYPE_DESC, TYPE_NAME, TYPE_IDENTITY)
values (seq_type_table.nextval, 5, 0, '告警紧急程度', '紧急程度', 'emergent');

insert into type_table (ID, SHOW_NUM, TYPE_STATE, TYPE_DESC, TYPE_NAME, TYPE_IDENTITY)
values (seq_type_table.nextval, 1, 0, '', 'ceshi', 'test');

insert into type_table (ID, SHOW_NUM, TYPE_STATE, TYPE_DESC, TYPE_NAME, TYPE_IDENTITY)
values (seq_type_table.nextval, 1, 0, '', '迪普风扇电源状态', 'dpfan');

insert into type_table (ID, SHOW_NUM, TYPE_STATE, TYPE_DESC, TYPE_NAME, TYPE_IDENTITY)
values (seq_type_table.nextval, 2, 0, '', '硬盘是否可写', 'diskwritestate');
commit;

insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE)
values (seq_option_table.nextval, 'diskwritestate', '0', '可写', 1, 0);

insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE)
values (seq_option_table.nextval, 'diskwritestate', '1', '不可写', 2, 0);

insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE)
values (seq_option_table.nextval, 'emergent', '0', '紧急', 0, 0);

insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE)
values (seq_option_table.nextval, 'emergent', '1', '非紧急', 1, 0);

insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE)
values (seq_option_table.nextval, 'dpfan', 'normal', '正常', 1, 0);

insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE)
values (seq_option_table.nextval, 'dpfan', 'abnormal', '异常', 2, 0);

insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE)
values (seq_option_table.nextval, 'dpfan', 'offline', '下线', 3, 0);

insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE)
values (seq_option_table.nextval, 'netelementtype', '1', '专用设备', 1, 0);

insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE)
values (seq_option_table.nextval, 'netelementtype', '2', '盘阵', 2, 0);

insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE)
values (seq_option_table.nextval, 'netelementtype', '3', '封堵路由器', 3, 0);

insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE)
values (seq_option_table.nextval, 'netelementtype', '4', '其他网元', 4, 0);

commit;
alter table METADATA drop column TYPE_ID ;
alter table METADATA ADD (TYPE_ID  VARCHAR2(50)) ;
comment on column METADATA.TYPE_ID is '对应翻译字典，对部分标识字段的对应翻译字典';

update metadata t set t.type_id = 'diskwritestate' where t.table_name = 'DETECT_INFO_DISK' and t.filed_name = 'DISK_ISWRITE'


-- 邮件表新增字段
truncate table email_table;
alter table email_table add (SEND_LEVEL NUMBER);
comment on column email_table.SEND_LEVEL is '值同 data_police_relation  POLICE_EMERGENT 的值';

-- 新菜单 
-- 注意：nms@ict_10.0.6.100 XT_MK_JBXX表 各id 与 initData.sql XT_MK_JBXX各数据id 均不对应，导入须谨慎
-- 需要与董晓燕讨论

insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (267, 0, null, '配置管理', '配置管理', null, null, '0', to_date('10-05-2013 14:50:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 1, 9, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (279, 0, null, '权限管理', null, null, null, '0', to_date('10-05-2013 14:56:29', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 1, 10, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (284, 0, null, '数据展示', null, null, null, '0', to_date('10-05-2013 15:00:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 1, 8, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (268, 267, null, '监测配置向导', null, '/sysManage/guideManage!execute.do?action=monitor', null, '0', to_date('10-05-2013 14:51:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 2, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (269, 267, null, '监测配置', '配置监测设置信息', '/detection/detectionSet.do?action=query', null, '0', to_date('10-05-2013 14:53:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 3, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (270, 267, null, '类别配置', null, '/detection/checkTypeSet.do?action=query', null, '0', to_date('10-05-2013 14:54:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 4, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (271, 267, null, '任务配置', null, '/nmstaskManager/nmsTaskManager.do?action=query', null, '0', to_date('10-05-2013 14:54:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 5, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (272, 267, null, '特种设备配置', null, '/detection/switchDetection.do?action=toConfigSpecialDevice', null, '0', to_date('10-05-2013 14:54:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 6, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (273, 267, null, '机房配置', null, '/nodePosition/roomManage.do?action=query', null, '0', to_date('10-05-2013 14:54:51', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 7, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (274, 267, null, '节点配置', '节点组和节点维护', '/nodeGroupManage/nodeGroupManage!execute.do?action=queryNodeGroupInfo', null, '0', to_date('10-05-2013 14:55:08', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 8, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (275, 267, null, '业务系统配置', '业务系统管理', '/sysManage/systemManage.do?action=query', null, '0', to_date('10-05-2013 14:55:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 9, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (276, 267, null, 'DC范围配置', 'DC管理范围', '/serverManager/serverManager.do?action=query', null, '0', to_date('10-05-2013 14:55:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 10, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (277, 267, null, '参数配置', null, '/sysManage/dataDictionary.do?action=query', null, '0', to_date('10-05-2013 14:55:52', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 11, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (278, 267, null, '业务逻辑配置', null, '/nodePosition/nodePosition.do?action=showMap', null, '0', to_date('10-05-2013 14:56:05', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 13, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (288, 267, null, '用户组配置', '用户组管理界面', '/sysManage/userGroupPerssion.do?action=query', null, '0', to_date('10-05-2013 16:28:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 12, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (316, 267, null, '任务配置向导', null, '/sysManage/guideManage!execute.do?action=task', null, '0', to_date('10-05-2013 17:41:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 1, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (311, 269, null, '新增', null, null, null, '0', to_date('10-05-2013 17:26:15', 'dd-mm-yyyy hh24:mi:ss'), null, 'addDetecSet', 1, null, 1, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (312, 269, null, '修改', null, null, null, '0', to_date('10-05-2013 17:26:37', 'dd-mm-yyyy hh24:mi:ss'), null, 'updDetecSet', 1, null, 2, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (313, 269, null, '设置告警', null, null, null, '0', to_date('10-05-2013 17:27:03', 'dd-mm-yyyy hh24:mi:ss'), null, 'addPoliceSet', 1, null, 3, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (314, 269, null, '上线', null, null, null, '0', to_date('10-05-2013 17:27:43', 'dd-mm-yyyy hh24:mi:ss'), null, 'startDSet', 1, null, 4, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (315, 269, null, '下线', null, null, null, '0', to_date('10-05-2013 17:28:08', 'dd-mm-yyyy hh24:mi:ss'), null, 'stopDSet', 1, null, 5, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (308, 270, null, '新增', null, null, null, '0', to_date('10-05-2013 17:23:48', 'dd-mm-yyyy hh24:mi:ss'), null, 'addCheckTypeSet', 1, null, 1, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (309, 270, null, '修改', null, null, null, '0', to_date('10-05-2013 17:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, 'updCheckTypeSet', 1, null, 2, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (310, 270, null, '删除', null, null, null, '0', to_date('10-05-2013 17:24:36', 'dd-mm-yyyy hh24:mi:ss'), null, 'delCheckTypeSet', 1, null, 3, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (303, 271, null, '新增相似', null, null, null, '0', to_date('10-05-2013 17:20:53', 'dd-mm-yyyy hh24:mi:ss'), null, 'addSimilar', 1, null, 1, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (304, 271, null, '新增逆向', null, null, null, '0', to_date('10-05-2013 17:21:14', 'dd-mm-yyyy hh24:mi:ss'), null, 'addConverse', 1, null, 2, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (305, 271, null, '新增', null, null, null, '0', to_date('10-05-2013 17:21:39', 'dd-mm-yyyy hh24:mi:ss'), null, 'add', 1, null, 3, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (306, 271, null, '停用', null, null, null, '0', to_date('10-05-2013 17:22:31', 'dd-mm-yyyy hh24:mi:ss'), null, 'shutDn', 1, null, 4, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (307, 271, null, '启用', null, null, null, '0', to_date('10-05-2013 17:22:49', 'dd-mm-yyyy hh24:mi:ss'), null, 'startDn', 1, null, 5, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (300, 273, null, '新增', null, null, null, '0', to_date('10-05-2013 17:18:46', 'dd-mm-yyyy hh24:mi:ss'), null, 'addRecord', 1, null, 1, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (301, 273, null, '修改', null, null, null, '0', to_date('10-05-2013 17:19:09', 'dd-mm-yyyy hh24:mi:ss'), null, 'updRecord', 1, null, 2, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (302, 273, null, '删除', null, null, null, '0', to_date('10-05-2013 17:19:28', 'dd-mm-yyyy hh24:mi:ss'), null, 'delRecord', 1, null, 3, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (298, 274, null, '下线', null, null, null, '0', to_date('10-05-2013 16:59:19', 'dd-mm-yyyy hh24:mi:ss'), null, 'stopNodeGroup', 1, null, 2, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (299, 274, null, '上线', null, null, null, '0', to_date('10-05-2013 16:59:42', 'dd-mm-yyyy hh24:mi:ss'), null, 'startNodeGroup', 1, null, 1, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (294, 275, null, '新增', null, null, null, '0', to_date('10-05-2013 16:52:27', 'dd-mm-yyyy hh24:mi:ss'), null, 'addSystem', 1, null, 1, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (295, 275, null, '修改', null, null, null, '0', to_date('10-05-2013 16:54:27', 'dd-mm-yyyy hh24:mi:ss'), null, 'updateSystem', 1, null, 2, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (296, 275, null, '下线', null, null, null, '0', to_date('10-05-2013 16:54:47', 'dd-mm-yyyy hh24:mi:ss'), null, 'stopSystem', 1, null, 4, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (297, 275, null, '上线', null, null, null, '0', to_date('10-05-2013 16:56:04', 'dd-mm-yyyy hh24:mi:ss'), null, 'startSystem', 1, null, 3, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (290, 276, null, '新增', null, null, null, '0', to_date('10-05-2013 16:50:00', 'dd-mm-yyyy hh24:mi:ss'), null, 'openAdd', 1, null, 1, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (291, 276, null, '修改', null, null, null, '0', to_date('10-05-2013 16:50:23', 'dd-mm-yyyy hh24:mi:ss'), null, 'openUpdate', 1, null, 2, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (292, 276, null, '上线', null, null, null, '0', to_date('10-05-2013 16:51:40', 'dd-mm-yyyy hh24:mi:ss'), null, 'startServer', 1, null, 3, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (293, 276, null, '下线', null, null, null, '0', to_date('10-05-2013 16:52:03', 'dd-mm-yyyy hh24:mi:ss'), null, 'stopServer', 1, null, 4, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (341, 277, null, '新增', '新增操作', null, null, '0', to_date('24-05-2013 17:33:55', 'dd-mm-yyyy hh24:mi:ss'), null, 'addRecord', 1, null, 1, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (280, 279, null, '部门配置', null, '/deptManage/deptManage!execute.do?action=queryDeptInfo', null, '0', to_date('10-05-2013 14:56:40', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 1, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (281, 279, null, '角色配置', null, '/sysManage/sysPopedomManage!execute.do?action=queryJsInfo', null, '0', to_date('10-05-2013 14:56:53', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 2, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (282, 279, null, '用户管理', null, '/sysManage/sysPopedomManage!execute.do?action=queryUserInfo', null, '0', to_date('10-05-2013 14:57:07', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 3, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (283, 279, null, '修改个人信息', null, '/sysManage/sysPopedomManage!execute.do?action=updateSelfInfo', null, '0', to_date('10-05-2013 14:57:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 4, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (261, 284, null, '异常服务器', '原告警数据', '/detection/detectionWarning.do?action=query', null, '0', to_date('10-05-2013 14:41:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 5, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (262, 284, null, '服务器监测', '监测数据', '/detection/monitorData.do?action=query', null, '0', to_date('10-05-2013 14:42:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 6, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (263, 284, null, '异常网元', null, '/detection/monitorData.do?action=queryAbnormalSet', null, '0', to_date('10-05-2013 14:42:29', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 7, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (264, 284, null, '网元监测', null, '/detection/switchDetection.do?action=query', null, '0', to_date('10-05-2013 14:42:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 8, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (265, 284, null, '告警信息', '展示各节点告警异常信息', '/detection/detectionWarning.do?action=query', null, '0', to_date('10-05-2013 14:43:14', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 9, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (266, 284, null, '任务查看', '只是任务信息和执行状态和结果的查看。', '/nmstaskManager/nmsTaskManager!execute.do?action=query', null, '0', to_date('10-05-2013 14:43:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 10, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (285, 284, null, '业务逻辑拓扑', '拓扑图展示', '/nodePosition/topoShow.do?action=showTopo', null, '0', to_date('10-05-2013 16:20:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 1, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (286, 284, null, '3D机房展示', null, '/nodePosition/nodePosition.do?action=showTopology', null, '0', to_date('10-05-2013 16:21:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 2, 2, 0);
insert into XT_MK_JBXX (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (289, 288, null, '新增', '新增用户组', null, null, '0', to_date('10-05-2013 16:30:42', 'dd-mm-yyyy hh24:mi:ss'), null, 'addRecord', 1, null, 1, 0);

commit;


--界面操作
--权限管理->角色配置->新增 角色 可访问“配置管理”“权限管理”“数据展示”三个模块，注有两个“数据展示”，新增加的“数据展示”子项有“异常服务器”等8个。
--权限管理->用户管理->修改或新增用户信息，关联新角色。
--被修改或新用户再次登陆后可看到新菜单。