--xt_yh_jbxx  表添加邮件接收开关字段及设置值

alter table xt_yh_jbxx add(is_receiveemail VARCHAR2(2));

comment on column XT_YH_JBXX.IS_RECEIVEEMAIL 
  is '为0时，接收邮件，为1时不接收';
  
update xt_yh_jbxx set is_receiveemail='0';
commit;



--NODE_FIGURE_INFO添加端口人为设置状态

alter table NODE_FIGURE_INFO add(PORT_SET_STATE NUMBER);

comment on column NODE_FIGURE_INFO.PORT_SET_STATE 
  is '端口设置状态：1up；2down。';
  
-- Create table 
create table NODEGROUP_POSITION
(
  ID                  NUMBER not null,
  SYSTEM_ID           NUMBER not null,
  GROUP_ID            NUMBER not null,
  PGROUP_ID           NUMBER not null,
  SHOW_LEVEL          NUMBER not null,
  SHOW_INDEX          NUMBER,
  FIGURE_TYPE         VARCHAR2(64) not null,
  FIGURE_X            NUMBER,
  FIGURE_Y            NUMBER,
  FIGURE_WIDTH        NUMBER,
  FIGURE_HEIGHT       NUMBER,
  FIGURE_STROKE       VARCHAR2(20),
  FIGURE_STROKE_WIDTH NUMBER,
  FIGURE_FILL         VARCHAR2(100),
  SHOW_STATUS         NUMBER not null,
  ADD_TIME            DATE,
  ADD_USERID          NUMBER,
  LAST_UPDATE_TIME    DATE,
  LAST_UPDATE_USERID  NUMBER
)
;
comment on table NODEGROUP_POSITION
  is '节点组位置信息表';
comment on column NODEGROUP_POSITION.ID
  is '记录唯一标识';
comment on column NODEGROUP_POSITION.SYSTEM_ID
  is '系统id';
comment on column NODEGROUP_POSITION.GROUP_ID
  is '节点组ID';
comment on column NODEGROUP_POSITION.PGROUP_ID
  is '父级组ID';
comment on column NODEGROUP_POSITION.SHOW_LEVEL
  is '显示层级';
comment on column NODEGROUP_POSITION.SHOW_INDEX
  is '显示序号';
comment on column NODEGROUP_POSITION.FIGURE_TYPE
  is 'rect、circle、image等svg图形类型';
comment on column NODEGROUP_POSITION.FIGURE_X
  is 'X坐标	';
comment on column NODEGROUP_POSITION.FIGURE_Y
  is 'Y坐标';
comment on column NODEGROUP_POSITION.FIGURE_WIDTH
  is '宽';
comment on column NODEGROUP_POSITION.FIGURE_HEIGHT
  is '高';
comment on column NODEGROUP_POSITION.FIGURE_STROKE
  is '边颜色';
comment on column NODEGROUP_POSITION.FIGURE_STROKE_WIDTH
  is '边宽';
comment on column NODEGROUP_POSITION.FIGURE_FILL
  is '填充色:图形为填充色；image为xlink:href内容';
comment on column NODEGROUP_POSITION.SHOW_STATUS
  is '0：正常 1：异常，匹配不到的不显示状态。';
comment on column NODEGROUP_POSITION.ADD_TIME
  is '添加时间';
comment on column NODEGROUP_POSITION.ADD_USERID
  is '添加人';
comment on column NODEGROUP_POSITION.LAST_UPDATE_TIME
  is '最后更改时间';
comment on column NODEGROUP_POSITION.LAST_UPDATE_USERID
  is '最后更改人';
  
  
  
  -- Create sequence 
create sequence SEQ_NODEGROUP_POSITION
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

-- 更新systemdate 监测设置为主动监测
update detection_set_info dsi set dsi.check_way=0 where dsi.check_type_id in (select t.id from check_type_info t where t.check_type_name = 'systemdate');

-- 停用 触发器before_insert_di_switchport
alter trigger before_insert_di_switchport disable;


