-----------------------------------------------------
-- Export file for user NMS                        --
-- Created by Administrator on 2015-1-27, 10:22:00 --
-----------------------------------------------------

spool 111.log

prompt
prompt Creating table PLUGIN_INFO
prompt ==========================
prompt
create table PLUGIN_INFO
(
  ID            NUMBER not null,
  NAME          VARCHAR2(100) not null,
  DES           VARCHAR2(1000),
  FILE_NAME     VARCHAR2(1000) not null,
  CREAT_USERID  NUMBER,
  CREAT_TIME    DATE,
  UPDATE_USERID NUMBER,
  UPDATE_TIME   DATE
)
;
comment on table PLUGIN_INFO
  is '存放工具管理信息';
comment on column PLUGIN_INFO.ID
  is 'id';
comment on column PLUGIN_INFO.NAME
  is '工具名称';
comment on column PLUGIN_INFO.DES
  is '工具说明';
comment on column PLUGIN_INFO.FILE_NAME
  is '文件名';
comment on column PLUGIN_INFO.CREAT_USERID
  is '创建人';
comment on column PLUGIN_INFO.CREAT_TIME
  is '创建时间';
comment on column PLUGIN_INFO.UPDATE_USERID
  is '最后更新人';
comment on column PLUGIN_INFO.UPDATE_TIME
  is '最后更新时间';
alter table PLUGIN_INFO
  add constraint PK_PLUGIN_INFO primary key (ID);

prompt
prompt Creating sequence SEQ_PLUGIN_INFO
prompt =================================
prompt
create sequence SEQ_PLUGIN_INFO
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;


spool off
