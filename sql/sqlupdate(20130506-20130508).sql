--网元图形化配置，设备品牌及型号的维护配置菜单：菜单配置，sql， 新增、修改、删除（品牌）---再使用系统分配权限
--------------------------------------------------------------------------------
insert into xt_mk_jbxx (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (221, 4, '', '品牌管理', '', '/sysManage/deviceBrandManage.do?action=queryDeviceBrandInfo', '', '0', to_date('03-05-2013 16:52:14', 'dd-mm-yyyy hh24:mi:ss'), '', '', 0, 2, 6, 0);

insert into xt_mk_jbxx (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (241, 4, '', '设备管理', '设备管理', '/sysManage/deviceBrandManage.do?action=queryDeviceTypeInfo', '', '0', to_date('06-05-2013 10:01:23', 'dd-mm-yyyy hh24:mi:ss'), '', '', 0, 2, 7, 0);

insert into xt_mk_jbxx (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (222, 221, '', '新增', '新增', '', '', '0', to_date('03-05-2013 17:10:40', 'dd-mm-yyyy hh24:mi:ss'), '', 'toAddDevBrand', 1, null, 1, 0);

insert into xt_mk_jbxx (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (223, 221, '', '修改', '修改', '', '', '0', to_date('03-05-2013 17:11:12', 'dd-mm-yyyy hh24:mi:ss'), '', 'toUpdateDevBrand', 1, null, 2, 0);

insert into xt_mk_jbxx (ID, PID, MKBH, MKMC, MKMS, MKURL, MKTB, ZXBZ, CTIME, ICONIMAGE, HANDLER, MKTYPE, SHOWLEVEL, SHOWORDER, SHOWAREA)
values (224, 221, '', '删除', '删除', '', '', '0', to_date('03-05-2013 17:11:39', 'dd-mm-yyyy hh24:mi:ss'), '', 'deleteDevBrand', 1, null, 3, 0);

commit;


/*
	使用管理员登陆，为相应角色分配权限

*/

/*
	邮件表 重新创建
*/
drop table email_table;

-- Create table
create table EMAIL_TABLE
(
  ID          NUMBER not null,
  TO_ADDRESS  VARCHAR2(100),
  ACTION_TYPE NUMBER,
  CONTENT     VARCHAR2(300),
  SEND_FLAG   NUMBER,
  ACTION_IP   VARCHAR2(100),
  ACTION_DATE DATE,
  ACTION_DESC VARCHAR2(100)
);
-- Add comments to the table 
comment on table EMAIL_TABLE
  is 'NMS产生的所有邮件信息';
-- Add comments to the columns 
comment on column EMAIL_TABLE.ID
  is '主键';
comment on column EMAIL_TABLE.TO_ADDRESS
  is '接收地址';
comment on column EMAIL_TABLE.ACTION_TYPE
  is '事件类型 值域10监测恢复，11监测信息异常，13:监测结果超时，20主动告警恢复，21主动告警异常，31结果失败，32任务状态变更，40系统运行异常恢复，41系统运行异常';
comment on column EMAIL_TABLE.CONTENT
  is '邮件内容';
comment on column EMAIL_TABLE.SEND_FLAG
  is '0未发送 1已发送 （2程序中使用状态为:立即发送,入库状态为1）';
comment on column EMAIL_TABLE.ACTION_IP
  is '地点';
comment on column EMAIL_TABLE.ACTION_DATE
  is '触发时间';
comment on column EMAIL_TABLE.ACTION_DESC
  is '事件标题';
-- Create/Recreate primary, unique and foreign key constraints 
alter table EMAIL_TABLE
  add constraint ASDFSADFSDFAS primary key (ID);
-- Create/Recreate indexes 
create index FGDHDFGVBCG on EMAIL_TABLE (ACTION_DATE);
create index FGHFGHFG on EMAIL_TABLE (TO_ADDRESS);
create index FGHFGHFGHFGGF on EMAIL_TABLE (SEND_FLAG);
create index FGHFGHFGHFGH on EMAIL_TABLE (ACTION_IP);
create index FGHFGHFGHFH on EMAIL_TABLE (ACTION_TYPE);
create index SFGSFDFGDFG on EMAIL_TABLE (ACTION_DESC);
