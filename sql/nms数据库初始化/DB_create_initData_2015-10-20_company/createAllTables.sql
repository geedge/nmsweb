-------------------------------------------
-- Export file for user NMS              --
-- Created by dell on 2015/5/5, 10:29:09 --
-------------------------------------------

spool createAllTables.log

prompt
prompt Creating table CHECK_TYPE_INFO
prompt ==============================
prompt
create table CHECK_TYPE_INFO
(
  ID                NUMBER not null,
  CHECK_TYPE_NAME   VARCHAR2(64),
  CHECK_PARAM_VALUE VARCHAR2(64),
  CHECK_REMARK      VARCHAR2(200),
  TABLE_NAME        VARCHAR2(50),
  CRETE_STATE       CHAR(1),
  TABLE_DESC        VARCHAR2(500),
  IS_SCHEDULE       CHAR(1),
  CREATE_TIME       DATE,
  VIEW_LEVEL        NUMBER,
  GROUP_ID          NUMBER,
  USER_ID           NUMBER,
  SYSTEM_ID         NUMBER,
  IS_SNMP           NUMBER,
  OID               VARCHAR2(200),
  CHECK_TYPE_NAME1  VARCHAR2(64)
)
;
comment on table CHECK_TYPE_INFO
  is '监测类别';
comment on column CHECK_TYPE_INFO.CHECK_TYPE_NAME
  is '检测类别（只能使用26个字母和数字，不区分大小写，在监控信息交互方面与设置名称用于Server向Client端发送映射关系如：cpu：detect_info_cpu）';
comment on column CHECK_TYPE_INFO.CHECK_PARAM_VALUE
  is '监测描述';
comment on column CHECK_TYPE_INFO.CHECK_REMARK
  is '备注';
comment on column CHECK_TYPE_INFO.TABLE_NAME
  is 'CHECK_TYPE_NAME对应的的表名';
comment on column CHECK_TYPE_INFO.CRETE_STATE
  is '表是否生成标识0已生成或已创建；1未生成；2停用 默认1';
comment on column CHECK_TYPE_INFO.TABLE_DESC
  is 'CHECK_TYPE_NAME对应的的表描述';
comment on column CHECK_TYPE_INFO.IS_SCHEDULE
  is '监测类型： 0预置监测类型，1三方监测类型，2页面不显示（如snmp_trap）';
comment on column CHECK_TYPE_INFO.CREATE_TIME
  is '创建时间';
comment on column CHECK_TYPE_INFO.VIEW_LEVEL
  is '查看范围取值范围[1、4]
1-发布人查看
2-发布人所在组查看
3-系统内全部人员可看
4-无限制';
comment on column CHECK_TYPE_INFO.GROUP_ID
  is '用户组id';
comment on column CHECK_TYPE_INFO.USER_ID
  is '用户id';
comment on column CHECK_TYPE_INFO.SYSTEM_ID
  is '业务系统id';
comment on column CHECK_TYPE_INFO.IS_SNMP
  is '是否是SNMP 监控，标识从属于字段IS_SCHEDULE的1三方监测类型：0，是ObjectSNMP监控 1，是SNMP4J监控，2 或null否  默认null';
comment on column CHECK_TYPE_INFO.OID
  is '对应监测oid';
comment on column CHECK_TYPE_INFO.CHECK_TYPE_NAME1
  is '监测类别名称（不区分大小写）';
alter table CHECK_TYPE_INFO
  add constraint PK_CHECK_TYPE_INFO primary key (ID);

prompt
prompt Creating table NODEGROUP_TABLE
prompt ==============================
prompt
create table NODEGROUP_TABLE
(
  GROUP_ID            NUMBER not null,
  GROUP_NAME          VARCHAR2(64),
  VIEW_LEVEL          NUMBER,
  CREATE_USER_ID      NUMBER,
  CREATE_USERGROUP_ID NUMBER,
  GROUP_TYPE          NUMBER,
  GROUP_DESC          VARCHAR2(256),
  SYSTEM_ID           NUMBER,
  IS_VALID            NUMBER,
  GROUP_CREATETIME    DATE,
  PARENT_GROUP_ID     NUMBER,
  LEAF_GROUP          NUMBER,
  GROUP_LEVEL         NUMBER,
  SHOW_INDEX          NUMBER
)
;
comment on table NODEGROUP_TABLE
  is '节点组信息表';
comment on column NODEGROUP_TABLE.GROUP_ID
  is '唯一标识';
comment on column NODEGROUP_TABLE.GROUP_NAME
  is '节点组名称';
comment on column NODEGROUP_TABLE.VIEW_LEVEL
  is '查看权限范围';
comment on column NODEGROUP_TABLE.CREATE_USER_ID
  is '创建人';
comment on column NODEGROUP_TABLE.CREATE_USERGROUP_ID
  is '创建人使用组id';
comment on column NODEGROUP_TABLE.GROUP_TYPE
  is '组类型：1临时，0常态';
comment on column NODEGROUP_TABLE.GROUP_DESC
  is '组描述';
comment on column NODEGROUP_TABLE.SYSTEM_ID
  is '系统id';
comment on column NODEGROUP_TABLE.IS_VALID
  is '是否有效1有效，0无效';
comment on column NODEGROUP_TABLE.GROUP_CREATETIME
  is '创建时间';
comment on column NODEGROUP_TABLE.PARENT_GROUP_ID
  is '父级组id';
comment on column NODEGROUP_TABLE.LEAF_GROUP
  is '是否叶子节点组：1是，0否';
comment on column NODEGROUP_TABLE.GROUP_LEVEL
  is '组级别';
comment on column NODEGROUP_TABLE.SHOW_INDEX
  is '显示序号';
alter table NODEGROUP_TABLE
  add constraint PRIMARYNODEGROUP_TABLE1 primary key (GROUP_ID);
create index IDX_NODEGROUP_SYSTEMFKIDNODEGR on NODEGROUP_TABLE (SYSTEM_ID);

prompt
prompt Creating table DETECTION_SET_INFO
prompt =================================
prompt
create table DETECTION_SET_INFO
(
  ID                     NUMBER not null,
  NODE_IP                VARCHAR2(500),
  CHECK_TYPE_ID          NUMBER,
  CHECK_GAP              NUMBER default 15,
  CHECK_WAY              CHAR(1) default 1,
  CHECK_OUT_TIME         NUMBER,
  CHECK_MAX_TIMES        NUMBER,
  PROCESS_IDEN           VARCHAR2(50),
  DETECTION_SET_STATE    CHAR(1),
  PROCESS_FILE           VARCHAR2(64),
  PROCESS_PATH           VARCHAR2(64),
  OID                    VARCHAR2(100),
  IS_CONTROL_START       CHAR(1),
  IS_ISSUE_FILE          CHAR(1),
  IS_ISSUED              CHAR(1),
  CONTROL_START_TIME     DATE,
  UPLOAD_GAP             NUMBER default 15,
  IS_ISSUE               CHAR(1),
  PLAN_CHECK_TIME        DATE,
  GROUP_ID               NUMBER,
  VIEW_LEVEL             NUMBER,
  CONTACT_USER_IDS       VARCHAR2(512),
  CREATE_USER_ID         NUMBER,
  CREATE_USERGROUP_ID    NUMBER,
  SYSTEM_ID              NUMBER,
  NODE_GROUPS_ID         VARCHAR2(500),
  NODE_IPS_ID            VARCHAR2(500),
  PROCESS_IDEN_NAME      VARCHAR2(64),
  PROCESS_SEARCH_KEYCODE VARCHAR2(100)
)
;
comment on table DETECTION_SET_INFO
  is '监测设置表';
comment on column DETECTION_SET_INFO.NODE_IP
  is '主机ip，标识主机位置';
comment on column DETECTION_SET_INFO.CHECK_TYPE_ID
  is '外键对应check_type_info表的id；监测类别id:监测类别：ping；cpu;硬盘；内存；软件进程等等对应的id';
comment on column DETECTION_SET_INFO.CHECK_GAP
  is '监测时间间隔单位分钟：不能为空，默认15分钟。监测在设置后获取一次数据，然后按间隔获取；如果只监测一次，把时间设置足够长。';
comment on column DETECTION_SET_INFO.CHECK_WAY
  is '监测方式：0，1；不能为空，默认1被动';
comment on column DETECTION_SET_INFO.CHECK_OUT_TIME
  is '超时时间(单位秒)：0为无限制，默认值为0';
comment on column DETECTION_SET_INFO.CHECK_MAX_TIMES
  is '最大测试次数：如果第一次不成功，重新执行最大次数。';
comment on column DETECTION_SET_INFO.PROCESS_IDEN
  is '设置标识（只能使用26个字母和数字，不区分大小写，在监控信息交互方面与检测类别用于Server向Client端发送映射关系如：cpu：detect_info_cpu）';
comment on column DETECTION_SET_INFO.DETECTION_SET_STATE
  is '监测设置的状态0无效；1有效;是否有效，如果有效按设置执行监测，否则不再执行该监测。';
comment on column DETECTION_SET_INFO.PROCESS_FILE
  is '进程名称';
comment on column DETECTION_SET_INFO.PROCESS_PATH
  is '进程执行文件路径';
comment on column DETECTION_SET_INFO.OID
  is 'OID：SNMP对应的OID';
comment on column DETECTION_SET_INFO.IS_CONTROL_START
  is '是否系统启动（NMSAgent启动/第三方自己启动）；默认0手工启动；1NCt启动';
comment on column DETECTION_SET_INFO.IS_ISSUE_FILE
  is '是否需下发文件：0需要；1不需要 默认1';
comment on column DETECTION_SET_INFO.IS_ISSUED
  is '文件下发是否成功;0成功；1不成功 默认1';
comment on column DETECTION_SET_INFO.CONTROL_START_TIME
  is '控制启动时间';
comment on column DETECTION_SET_INFO.UPLOAD_GAP
  is '上传数据时间间隔单位分钟：不能为空，默认15分钟。监测数据上传到NMSServer周期。';
comment on column DETECTION_SET_INFO.IS_ISSUE
  is '是否下发设置：0下发；1未下发 默认值为1如新添加或者修改一项设置之后设置为未下发，需要完成其他配置信息后才执行一次下发';
comment on column DETECTION_SET_INFO.PLAN_CHECK_TIME
  is '计划检测时间:针对当前配置信息首次执行时间';
comment on column DETECTION_SET_INFO.GROUP_ID
  is '节点组ID';
comment on column DETECTION_SET_INFO.VIEW_LEVEL
  is '查看级别1个人2组内3系统内4无限制';
comment on column DETECTION_SET_INFO.CONTACT_USER_IDS
  is '联系人ID,逗号间隔';
comment on column DETECTION_SET_INFO.CREATE_USER_ID
  is '创建者ID';
comment on column DETECTION_SET_INFO.CREATE_USERGROUP_ID
  is '创建者所在用户组ID';
comment on column DETECTION_SET_INFO.SYSTEM_ID
  is '系统ID';
comment on column DETECTION_SET_INFO.NODE_GROUPS_ID
  is '设置的有效节点组范围';
comment on column DETECTION_SET_INFO.NODE_IPS_ID
  is '设置的有效节点范围。如果有NODES_IP有值则不管节点组的有效范围；如果NODES_IP无值则使用节点组的范围；如果NODES_IP和NODE_GROUPS_ID均为空则有效范围是SYSTEM_ID系统内全部有效节点；如果三者均为空则有效范围为NMS系统内全部有效节点。';
comment on column DETECTION_SET_INFO.PROCESS_IDEN_NAME
  is '设置名称：如果是进程则是进程标识.进程标识，根据标识获取相应的进程信息。';
comment on column DETECTION_SET_INFO.PROCESS_SEARCH_KEYCODE
  is '进程搜索关键字  用于NC进程监测';
alter table DETECTION_SET_INFO
  add constraint PK_DETECTION_SET_INFO primary key (ID);
alter table DETECTION_SET_INFO
  add constraint FK_NODEGROUP_TABLE foreign key (GROUP_ID)
  references NODEGROUP_TABLE (GROUP_ID);

prompt
prompt Creating table METADATA
prompt =======================
prompt
create table METADATA
(
  ID             NUMBER not null,
  CHECK_TYPE_ID  NUMBER,
  TABLE_NAME     VARCHAR2(64),
  TABLE_COMMENTS VARCHAR2(100),
  FILED_NAME     VARCHAR2(64),
  FILED_COMMENTS VARCHAR2(100),
  FILED_TYPE     VARCHAR2(20),
  CREATE_DATE    DATE,
  CREATE_PERSON  NUMBER,
  STATE          CHAR(1),
  UPDATE_DATE    DATE,
  UPDATE_PERSON  NUMBER,
  CHART_STATE    CHAR(1),
  SHOW_NUM       NUMBER,
  ISNULL         NUMBER,
  OID            VARCHAR2(400),
  SORT_SIGN      NUMBER default 1,
  TYPE_ID        VARCHAR2(50)
)
;
comment on table METADATA
  is '元数据定义，每个监测类别具体监测数据的定义';
comment on column METADATA.CHECK_TYPE_ID
  is '外键检测类别ID';
comment on column METADATA.TABLE_NAME
  is '表名';
comment on column METADATA.TABLE_COMMENTS
  is '表描述';
comment on column METADATA.FILED_NAME
  is '字段名';
comment on column METADATA.FILED_COMMENTS
  is '字段描述';
comment on column METADATA.FILED_TYPE
  is '字段类型';
comment on column METADATA.CREATE_DATE
  is '创建日期';
comment on column METADATA.CREATE_PERSON
  is '创建人';
comment on column METADATA.STATE
  is '是否启用标识0启用1停用';
comment on column METADATA.UPDATE_DATE
  is '停用时间';
comment on column METADATA.UPDATE_PERSON
  is '停用人';
comment on column METADATA.CHART_STATE
  is '是否用于统计0启用1停用';
comment on column METADATA.SHOW_NUM
  is '在传输过程中的序号';
comment on column METADATA.ISNULL
  is '是否为空';
comment on column METADATA.OID
  is 'OID';
comment on column METADATA.SORT_SIGN
  is '是否分类标识:0是；1否，公用统计图中的多线分类标识字段';
comment on column METADATA.TYPE_ID
  is '对应翻译字典，对部分标识字段的对应翻译字典';
alter table METADATA
  add constraint PK_METADATA primary key (ID);

prompt
prompt Creating table SERVER_TABLE
prompt ===========================
prompt
create table SERVER_TABLE
(
  ID           NUMBER not null,
  SERVER_NAME  VARCHAR2(100),
  SERVER_STATE NUMBER,
  SERVER_IP    VARCHAR2(100),
  SERVER_IPN   NUMBER,
  CREATE_TIME  DATE,
  SERVER_DESC  VARCHAR2(500)
)
;
comment on table SERVER_TABLE
  is 'NMSDataController 服务器信息表';
comment on column SERVER_TABLE.ID
  is '主键ID';
comment on column SERVER_TABLE.SERVER_NAME
  is 'NMSDataController名称';
comment on column SERVER_TABLE.SERVER_STATE
  is 'server状态 0有效 1无效';
comment on column SERVER_TABLE.SERVER_IP
  is 'server_ip';
comment on column SERVER_TABLE.SERVER_IPN
  is 'server_ipN';
comment on column SERVER_TABLE.CREATE_TIME
  is '创建时间';
comment on column SERVER_TABLE.SERVER_DESC
  is '描述';
alter table SERVER_TABLE
  add constraint SDFSDFSDFSDFSDFSD primary key (ID);
  
  
prompt
prompt Creating table DATA_POLICE_RELATION
prompt ===================================
prompt
create table DATA_POLICE_RELATION
(
  ID                    NUMBER not null,
  DETECTION_SET_INFO_ID NUMBER,
  METADATA_ID           NUMBER,
  POLICE_STATE          CHAR(1),
  POLICE_VALUE          VARCHAR2(1024),
  POLICE_UNIT           VARCHAR2(10),
  POLICE_SYMBOLS        VARCHAR2(10),
  POLICE_LEVEL          NUMBER default 99,
  POLICE_SHOW_INFO      VARCHAR2(200),
  POLICE_EMERGENT       NUMBER default 1,
  MARKER                VARCHAR2(1024),
  MARKER_FILED_ID       NUMBER
)
;
comment on table DATA_POLICE_RELATION
  is '监测数据报警关系表';
comment on column DATA_POLICE_RELATION.DETECTION_SET_INFO_ID
  is '监测设置id外键';
comment on column DATA_POLICE_RELATION.METADATA_ID
  is '字段id';
comment on column DATA_POLICE_RELATION.POLICE_STATE
  is '是否用于报警：是否用于报警	0启用，1停用';
comment on column DATA_POLICE_RELATION.POLICE_VALUE
  is '报警值';
comment on column DATA_POLICE_RELATION.POLICE_UNIT
  is '报警值单位：如%等';
comment on column DATA_POLICE_RELATION.POLICE_SYMBOLS
  is '报警比较符：针对number型数据>、<、>=、<=、=针对字符串类型数据equal、 include、exclude';
comment on column DATA_POLICE_RELATION.POLICE_LEVEL
  is '报警级别';
comment on column DATA_POLICE_RELATION.POLICE_SHOW_INFO
  is '报警提示信息';
comment on column DATA_POLICE_RELATION.POLICE_EMERGENT
  is '告警是否紧急 0：紧急  1：非紧急';
comment on column DATA_POLICE_RELATION.MARKER
  is '设置告警时，指定多个标识符（如多个盘符、多个CPU、多个网卡），如硬盘使用率，空：所有盘存在一个盘使用率超过告警值，则告警；all：所有盘总的使用率超过告警值，则告警；指定多个盘符：指定盘存在一个盘使用率超过告警值，则告警';
comment on column DATA_POLICE_RELATION.MARKER_FILED_ID
  is '设置告警时，过滤标识marker对应的字段在metadata表中的id。';
alter table DATA_POLICE_RELATION
  add constraint PK_DATA_POLICE_RELATION2 primary key (ID);

prompt
prompt Creating table DETECTION_INFO_NEW
prompt =================================
prompt
create table DETECTION_INFO_NEW
(
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER,
  CHECK_WAY                CHAR(1),
  DETECTION_STATE_INFO     VARCHAR2(4000),
  PERFORMACE_DATA          VARCHAR2(4000),
  CURRENT_TIMES            NUMBER,
  START_TIME               DATE,
  WAIT_TIME                NUMBER,
  DELAY_TIME               NUMBER,
  NEXT_CHECK_TIME          DATE,
  OFF_LINE                 DATE,
  POLICE_LEVEL             NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DETECTIONED_STATE        VARCHAR2(2),
  NODE_IP                  VARCHAR2(64),
  STATUS_CHANGE_TIME       DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  SEQ_ID                   NUMBER,
  DETECTION_INFO_ID        NUMBER,
  VALID                    NUMBER default 1,
  POLICE_EMERGENT          NUMBER default 1
)
;
comment on table DETECTION_INFO_NEW
  is '监控数据表(最新数据:最后一次监测数据信息表)';
comment on column DETECTION_INFO_NEW.DETECTION_SET_INFO_ID
  is '监测设置id，外键';
comment on column DETECTION_INFO_NEW.CHECK_WAY
  is '监测方式不能为空，可选[0/1]0主动、1被动（设置为主动可能本记录为被动）';
comment on column DETECTION_INFO_NEW.DETECTION_STATE_INFO
  is '状态信息';
comment on column DETECTION_INFO_NEW.PERFORMACE_DATA
  is '性能数据';
comment on column DETECTION_INFO_NEW.CURRENT_TIMES
  is '当前尝试次数';
comment on column DETECTION_INFO_NEW.START_TIME
  is '开运时间';
comment on column DETECTION_INFO_NEW.WAIT_TIME
  is '检测等待时间单位秒';
comment on column DETECTION_INFO_NEW.DELAY_TIME
  is '检测时延单位秒';
comment on column DETECTION_INFO_NEW.NEXT_CHECK_TIME
  is '下一次计划主动式检测时间';
comment on column DETECTION_INFO_NEW.OFF_LINE
  is '计划宕机时间';
comment on column DETECTION_INFO_NEW.POLICE_LEVEL
  is '预警级别';
comment on column DETECTION_INFO_NEW.DATA_CHECK_TIME
  is '获取监测数据时间';
comment on column DETECTION_INFO_NEW.DATA_ARRIVE_TIME
  is '数据入库时间';
comment on column DETECTION_INFO_NEW.DETECTIONED_STATE
  is '被监控状态是否正常：0不正常；1正常';
comment on column DETECTION_INFO_NEW.NODE_IP
  is '主机ip，标识主机位置';
comment on column DETECTION_INFO_NEW.STATUS_CHANGE_TIME
  is '监控状态最后一次变化时间';
comment on column DETECTION_INFO_NEW.DATA_CHECK_TIME_DIGITAL
  is '获取监测数据时间 数字类型';
comment on column DETECTION_INFO_NEW.DATA_ARRIVE_TIME_DIGITAL
  is '数据入库时间 数字类型';
comment on column DETECTION_INFO_NEW.DETECTION_INFO_ID
  is 'detection_info表主键';
comment on column DETECTION_INFO_NEW.VALID
  is '监测数据是否有效，1有效，0无效，默认有效';
comment on column DETECTION_INFO_NEW.POLICE_EMERGENT
  is '告警是否紧急 0：紧急  1：非紧急';
alter table DETECTION_INFO_NEW
  add constraint PK_DETECTION_INFO_NEW primary key (ID);
alter table DETECTION_INFO_NEW
  add constraint FK_DETECTION_SET_INFO_NEW foreign key (DETECTION_SET_INFO_ID)
  references DETECTION_SET_INFO (ID);
create index DETECTION_INFO_NEW_CT on DETECTION_INFO_NEW (DATA_CHECK_TIME);

prompt
prompt Creating table DEVICE_BOARDSOLT_BOARD
prompt =====================================
prompt
create table DEVICE_BOARDSOLT_BOARD
(
  ID                     NUMBER not null,
  DEVICE_BRAND_CODE      VARCHAR2(64),
  DEVICE_BOARD_SOLT_CODE VARCHAR2(64),
  DEVICE_BOARD_CODE      VARCHAR2(64),
  DEVICE_TYPE_CODE       VARCHAR2(64)
)
;
comment on table DEVICE_BOARDSOLT_BOARD
  is '设备板槽板子对应关系表，每个板槽都可用放什么板子';
comment on column DEVICE_BOARDSOLT_BOARD.DEVICE_BRAND_CODE
  is '品牌code';
comment on column DEVICE_BOARDSOLT_BOARD.DEVICE_BOARD_SOLT_CODE
  is '槽位code';
comment on column DEVICE_BOARDSOLT_BOARD.DEVICE_BOARD_CODE
  is '板卡code';
comment on column DEVICE_BOARDSOLT_BOARD.DEVICE_TYPE_CODE
  is '设备型号';
alter table DEVICE_BOARDSOLT_BOARD
  add constraint PK_DEVICE_BOARDSOLT_BOARD primary key (ID);

prompt
prompt Creating table DEVICE_BRAND_INFO
prompt ================================
prompt
create table DEVICE_BRAND_INFO
(
  ID                 NUMBER not null,
  DEVICE_RAND_CODE   VARCHAR2(64) not null,
  DEVICE_RAND_NAME   VARCHAR2(100) not null,
  DEVICE_BRAND_DESC  VARCHAR2(500),
  ADD_TIME           DATE,
  ADD_USERID         NUMBER,
  LAST_UPDATE_TIME   DATE,
  LAST_UPDATE_USERID NUMBER
)
;
comment on table DEVICE_BRAND_INFO
  is '设备品牌表';
comment on column DEVICE_BRAND_INFO.ID
  is '主键';
comment on column DEVICE_BRAND_INFO.DEVICE_RAND_CODE
  is '设备品牌代码，不重复';
comment on column DEVICE_BRAND_INFO.DEVICE_RAND_NAME
  is '设备品牌';
comment on column DEVICE_BRAND_INFO.DEVICE_BRAND_DESC
  is '描述信息';
comment on column DEVICE_BRAND_INFO.ADD_TIME
  is '添加时间';
comment on column DEVICE_BRAND_INFO.ADD_USERID
  is '添加人';
comment on column DEVICE_BRAND_INFO.LAST_UPDATE_TIME
  is '最后更改时间';
comment on column DEVICE_BRAND_INFO.LAST_UPDATE_USERID
  is '最后更改人';
alter table DEVICE_BRAND_INFO
  add constraint PK_DEVICE_BRAND_INFO primary key (ID);

prompt
prompt Creating table DEVICE_BRAND_TYPE
prompt ================================
prompt
create table DEVICE_BRAND_TYPE
(
  ID                   NUMBER not null,
  DEVICE_BRAND_CODE    VARCHAR2(64),
  PAR_DEVICE_TYPE_CODE VARCHAR2(64),
  SUB_DEVICE_TYPE_CODE VARCHAR2(64)
)
;
comment on table DEVICE_BRAND_TYPE
  is '设备品牌板子类型对应表多对多';
comment on column DEVICE_BRAND_TYPE.DEVICE_BRAND_CODE
  is '设备品牌代码';
comment on column DEVICE_BRAND_TYPE.PAR_DEVICE_TYPE_CODE
  is '设备代码';
comment on column DEVICE_BRAND_TYPE.SUB_DEVICE_TYPE_CODE
  is '设备板子代码';
alter table DEVICE_BRAND_TYPE
  add constraint PK_DEVICE_BRAND_TYPE primary key (ID);

prompt
prompt Creating table DEVICE_TYPE_INFO
prompt ===============================
prompt
create table DEVICE_TYPE_INFO
(
  ID                  NUMBER not null,
  DEVICE_TYPE_CODE    VARCHAR2(100) not null,
  DEVICE_RAND_CODE    VARCHAR2(64) not null,
  DEVICE_DESC         VARCHAR2(500),
  SHOW_INDEX          NUMBER,
  PID                 VARCHAR2(100),
  FIGURE_TYPE         VARCHAR2(64) not null,
  FIGURE_X            NUMBER,
  FIGURE_Y            NUMBER,
  FIGURE_WIDTH        NUMBER,
  FIGURE_HEIGHT       NUMBER,
  FIGURE_STROKE       VARCHAR2(20),
  FIGURE_STROKE_WIDTH NUMBER,
  FIGURE_FILL         VARCHAR2(100),
  NAME_FORMAT         VARCHAR2(64),
  ADD_TIME            DATE,
  ADD_USERID          NUMBER,
  LAST_UPDATE_TIME    DATE,
  LAST_UPDATE_USERID  NUMBER,
  DI_TABLE_NAME       VARCHAR2(50),
  INDEX_FILED         VARCHAR2(64),
  STATUS_FILED        VARCHAR2(64),
  STATUS_SYMBOLS      VARCHAR2(10),
  STATUS_VALUE        VARCHAR2(64),
  SHOW_LEVEL          NUMBER,
  IS_LINK             NUMBER,
  IS_LEAF             NUMBER,
  MAX_DEVICE_NUM      NUMBER default 1,
  IS_POSITIONDEV      NUMBER default 0,
  HAS_INSTANCE        NUMBER default 1
)
;
comment on table DEVICE_TYPE_INFO
  is '设备型号表';
comment on column DEVICE_TYPE_INFO.ID
  is '主键';
comment on column DEVICE_TYPE_INFO.DEVICE_TYPE_CODE
  is '设备型号，不重复';
comment on column DEVICE_TYPE_INFO.DEVICE_RAND_CODE
  is '设备品牌代码';
comment on column DEVICE_TYPE_INFO.DEVICE_DESC
  is '描述信息';
comment on column DEVICE_TYPE_INFO.SHOW_INDEX
  is '级别下位置序号，注意从0还是从1开始';
comment on column DEVICE_TYPE_INFO.PID
  is '父级标识（Device_type_code）';
comment on column DEVICE_TYPE_INFO.FIGURE_TYPE
  is '图片类型，rect、circle、image等svg图形类型；';
comment on column DEVICE_TYPE_INFO.FIGURE_X
  is 'X坐标';
comment on column DEVICE_TYPE_INFO.FIGURE_Y
  is 'Y坐标';
comment on column DEVICE_TYPE_INFO.FIGURE_WIDTH
  is '宽';
comment on column DEVICE_TYPE_INFO.FIGURE_HEIGHT
  is '高';
comment on column DEVICE_TYPE_INFO.FIGURE_STROKE
  is '边颜色';
comment on column DEVICE_TYPE_INFO.FIGURE_STROKE_WIDTH
  is '边宽';
comment on column DEVICE_TYPE_INFO.FIGURE_FILL
  is '填充色：图形为填充色；image为xlink:href内容';
comment on column DEVICE_TYPE_INFO.NAME_FORMAT
  is '命名格式：Name[x]/[y]其中的x(板卡位置)y（端口位置）是要替换的内容';
comment on column DEVICE_TYPE_INFO.ADD_TIME
  is '添加时间';
comment on column DEVICE_TYPE_INFO.ADD_USERID
  is '添加人';
comment on column DEVICE_TYPE_INFO.LAST_UPDATE_TIME
  is '最后更改时间';
comment on column DEVICE_TYPE_INFO.LAST_UPDATE_USERID
  is '最后更改人';
comment on column DEVICE_TYPE_INFO.SHOW_LEVEL
  is '图形级别，最多支持5级';
comment on column DEVICE_TYPE_INFO.IS_LINK
  is '是否有链接，1是，0否，对应node_figure_info表的IS_LEAF字段';
comment on column DEVICE_TYPE_INFO.IS_LEAF
  is '是否叶子设备（叶子设备不会再有设备接到它上面），1是，0否，';
comment on column DEVICE_TYPE_INFO.MAX_DEVICE_NUM
  is '设备最大叠加数';
comment on column DEVICE_TYPE_INFO.IS_POSITIONDEV
  is '是否为槽位设备，1是，0否';
comment on column DEVICE_TYPE_INFO.HAS_INSTANCE
  is '是否配置实例，1是，0否';
alter table DEVICE_TYPE_INFO
  add constraint PK_DEVICE_TYPE_INFO primary key (ID);



prompt
prompt Creating table EMAIL_TABLE
prompt ==========================
prompt
create table EMAIL_TABLE
(
  ID          NUMBER not null,
  TO_ADDRESS  VARCHAR2(100),
  ACTION_TYPE NUMBER,
  CONTENT     VARCHAR2(300),
  SEND_FLAG   NUMBER,
  ACTION_IP   VARCHAR2(100),
  ACTION_DATE DATE,
  ACTION_DESC VARCHAR2(100),
  SEND_LEVEL  NUMBER,
  CREATE_TIME DATE
)
;
comment on table EMAIL_TABLE
  is 'NMS产生的所有邮件信息';
comment on column EMAIL_TABLE.ID
  is '主键';
comment on column EMAIL_TABLE.TO_ADDRESS
  is '接收地址';
comment on column EMAIL_TABLE.ACTION_TYPE
  is '事件类型 值域10监测恢复，11监测信息异常，13:监测结果超时，21主动告警恢复，20主动告警异常，31结果失败，32任务状态变更，40系统运行异常恢复，41系统运行异常';
comment on column EMAIL_TABLE.CONTENT
  is '邮件内容';
comment on column EMAIL_TABLE.SEND_FLAG
  is '0未发送 1已发送';
comment on column EMAIL_TABLE.ACTION_IP
  is '地点';
comment on column EMAIL_TABLE.ACTION_DATE
  is '触发时间，监测数据时间';
comment on column EMAIL_TABLE.ACTION_DESC
  is '事件标题（具体的监测、任务等名称标题）';
comment on column EMAIL_TABLE.SEND_LEVEL
  is '值同 data_police_relation  POLICE_EMERGENT 的值';
comment on column EMAIL_TABLE.CREATE_TIME
  is '插入记录时间';
alter table EMAIL_TABLE
  add constraint ASDFSADFSDFAS primary key (ID);
create index FGDHDFGVBCG on EMAIL_TABLE (ACTION_DATE);
create index FGHFGHFG on EMAIL_TABLE (TO_ADDRESS);
create index FGHFGHFGHFGGF on EMAIL_TABLE (SEND_FLAG);
create index FGHFGHFGHFGH on EMAIL_TABLE (ACTION_IP);
create index FGHFGHFGHFH on EMAIL_TABLE (ACTION_TYPE);
create index SFGSFDFGDFG on EMAIL_TABLE (ACTION_DESC);

prompt
prompt Creating table EVENT_RECORD_LIBRARY
prompt ===================================
prompt
create table EVENT_RECORD_LIBRARY
(
  ID             NUMBER not null,
  RECORD_TYPE    VARCHAR2(25),
  RECORD_CONTENT CLOB,
  SEQ_IDS        NUMBER,
  STATE          NUMBER,
  RECORD_COMMAND VARCHAR2(125),
  PID            NUMBER,
  CREATE_TIME    DATE,
  TABLE_NAME     VARCHAR2(100),
  TABLE_ID       NUMBER,
  NMSSERVER_ID   NUMBER
)
;
comment on table EVENT_RECORD_LIBRARY
  is 'datacontroller端发送失败信息暂存';
comment on column EVENT_RECORD_LIBRARY.ID
  is 'ID';
comment on column EVENT_RECORD_LIBRARY.RECORD_TYPE
  is '记录类型''mission'' ''detection'' ';
comment on column EVENT_RECORD_LIBRARY.RECORD_CONTENT
  is '发送内容 jsonStr';
comment on column EVENT_RECORD_LIBRARY.SEQ_IDS
  is '目标节点ID';
comment on column EVENT_RECORD_LIBRARY.STATE
  is '状态'' ''1''变更   ''0''变更结束';
comment on column EVENT_RECORD_LIBRARY.RECORD_COMMAND
  is '记录命令';
comment on column EVENT_RECORD_LIBRARY.PID
  is '父ID';
comment on column EVENT_RECORD_LIBRARY.CREATE_TIME
  is '创建时间';
comment on column EVENT_RECORD_LIBRARY.TABLE_NAME
  is '操作表';
comment on column EVENT_RECORD_LIBRARY.TABLE_ID
  is '表主键';
comment on column EVENT_RECORD_LIBRARY.NMSSERVER_ID
  is 'Server_table id';
alter table EVENT_RECORD_LIBRARY
  add constraint SDFSDFSDF primary key (ID);

prompt
prompt Creating table GORUP_SYSTEM_TABLE
prompt =================================
prompt
create table GORUP_SYSTEM_TABLE
(
  ID            NUMBER not null,
  USER_GROUP_ID NUMBER,
  SYSTEM_ID     NUMBER
)
;
comment on table GORUP_SYSTEM_TABLE
  is '用户组系统关系表';
comment on column GORUP_SYSTEM_TABLE.USER_GROUP_ID
  is '用户组id';
comment on column GORUP_SYSTEM_TABLE.SYSTEM_ID
  is '业务系统id';
alter table GORUP_SYSTEM_TABLE
  add constraint PRIMARYGORUP_SYSTEM_TABLE1 primary key (ID);
create index IDX_GROUPSYSTEMSYSTEMFKIDGORUP on GORUP_SYSTEM_TABLE (SYSTEM_ID);

prompt
prompt Creating table LOOPMISSION_STATE_TABLE
prompt ======================================
prompt
create table LOOPMISSION_STATE_TABLE
(
  CUR_MISSION_ID NUMBER not null,
  MISSION_ID     NUMBER not null,
  MISSION_STATE  NUMBER,
  START_TIME     DATE,
  END_TIME       DATE,
  FAIL_DESC      VARCHAR2(256)
)
;
comment on column LOOPMISSION_STATE_TABLE.CUR_MISSION_ID
  is '当前周期id';
comment on column LOOPMISSION_STATE_TABLE.MISSION_ID
  is '任务id';
comment on column LOOPMISSION_STATE_TABLE.MISSION_STATE
  is '任务状态：不能为空，状态可选：1-任务已创建；2-任务已开始执行；3-任务已完成（包含部分节点失败情况）；4-任务未能执行。';
comment on column LOOPMISSION_STATE_TABLE.START_TIME
  is '周期开始时间';
comment on column LOOPMISSION_STATE_TABLE.END_TIME
  is '周期结束时间';
comment on column LOOPMISSION_STATE_TABLE.FAIL_DESC
  is '失败描述';
alter table LOOPMISSION_STATE_TABLE
  add constraint DFGDG primary key (MISSION_ID, CUR_MISSION_ID);

prompt
prompt Creating table MISSION_FILE_INFORMATION
prompt =======================================
prompt
create table MISSION_FILE_INFORMATION
(
  ID          NUMBER not null,
  MISSION_ID  NUMBER,
  FILE_NAME   VARCHAR2(1024),
  DEST_PATH   VARCHAR2(1024),
  MD5_VALUE   VARCHAR2(128),
  OWNER       VARCHAR2(25),
  PERMISSION  VARCHAR2(25),
  IS_COVER    VARCHAR2(1),
  CREATE_TIME DATE
)
;
comment on table MISSION_FILE_INFORMATION
  is '任务推送文件信息表';
comment on column MISSION_FILE_INFORMATION.FILE_NAME
  is '文件源路径';
comment on column MISSION_FILE_INFORMATION.MD5_VALUE
  is '文件校验值';
comment on column MISSION_FILE_INFORMATION.OWNER
  is '推送文件的所有者（只针对Linux有效）';
comment on column MISSION_FILE_INFORMATION.PERMISSION
  is '推送文件拥有的权限（只针对Linux有效）';
comment on column MISSION_FILE_INFORMATION.IS_COVER
  is '覆盖标识（Y创建，N不创建 ，默认为N，忽略大小写）';
alter table MISSION_FILE_INFORMATION
  add constraint DGDFGDFG primary key (ID);

prompt
prompt Creating table MISSION_PARAMETER_DEFAULTS
prompt =========================================
prompt
create table MISSION_PARAMETER_DEFAULTS
(
  ID                NUMBER not null,
  MISSION_TYPE_NAME VARCHAR2(64),
  MISSION_TYPE      NUMBER,
  VIEW_LEVEL        NUMBER,
  GROUP_ID          NUMBER,
  NODE_LIST_ID      NUMBER,
  SYSTEM_ID         NUMBER,
  TARGET_PATH       VARCHAR2(1024),
  CHECK_VALUE       VARCHAR2(128),
  START_TIME        DATE,
  END_TIME          DATE,
  MAX_RETURN        NUMBER,
  START_FLAG        VARCHAR2(1024),
  END_FLAG          VARCHAR2(1024),
  LOOP_FLAG         NUMBER,
  LOOP_START_DATE   DATE,
  LOOP_END_DATE     DATE,
  LOOP_DELAY        NUMBER,
  FILTER_KEYWORD    VARCHAR2(1024)
)
;
comment on column MISSION_PARAMETER_DEFAULTS.VIEW_LEVEL
  is '查看等级  组内查看  系统查看等';
alter table MISSION_PARAMETER_DEFAULTS
  add constraint PRIMARYMISSION_PARAMETER_DEFAU primary key (ID);

prompt
prompt Creating table MISSION_PARAMETER_TABLE1
prompt =======================================
prompt
create table MISSION_PARAMETER_TABLE1
(
  MISSION_ID      NUMBER not null,
  MISSION_DESC    VARCHAR2(256),
  SOURCE_PATH     VARCHAR2(1024),
  TARGET_PATH     VARCHAR2(1024),
  CHECK_VALUE     VARCHAR2(128),
  NODE_LIST_ID    NUMBER,
  OS_LIMITS       NUMBER,
  START_TIME      DATE,
  VERSION         NUMBER,
  IS_CREATE_COVER VARCHAR2(1),
  COMMAND_PARA    CLOB,
  NODE_GROUPS_ID  VARCHAR2(500),
  NODE_IPS_ID     VARCHAR2(500)
)
;
comment on table MISSION_PARAMETER_TABLE1
  is '任务参数表1对应任务类型是文件推送的任务';
comment on column MISSION_PARAMETER_TABLE1.MISSION_ID
  is 'mission_id	Number(8)	任务id	主键';
comment on column MISSION_PARAMETER_TABLE1.MISSION_DESC
  is 'mission_desc	Varchar(256)	任务描述	可以为空';
comment on column MISSION_PARAMETER_TABLE1.SOURCE_PATH
  is 'Source_path	Varchar(1024)	文件源路径	不能为空，长度不能为0';
comment on column MISSION_PARAMETER_TABLE1.TARGET_PATH
  is 'Target_path	Varchar(1024)	文件目的路径	不能为空，长度不能为0';
comment on column MISSION_PARAMETER_TABLE1.CHECK_VALUE
  is 'Check_value	Varchar(128)	文件校验值	不能为空，初步可以设定文件长度';
comment on column MISSION_PARAMETER_TABLE1.NODE_LIST_ID
  is 'Node_list_id	Number(8)	节点组id	不能为空，外键';
comment on column MISSION_PARAMETER_TABLE1.OS_LIMITS
  is '-1系统类型无关（用于非系统升级标识）  0全系统 ， 1Windows系统， 2 Linux系统';
comment on column MISSION_PARAMETER_TABLE1.START_TIME
  is '启动时间，或文件推送后任务重启时间';
comment on column MISSION_PARAMETER_TABLE1.VERSION
  is '版本号';
comment on column MISSION_PARAMETER_TABLE1.IS_CREATE_COVER
  is '创建覆盖标识（Y创建，N不创建 ，默认为N，忽略大小写）';
comment on column MISSION_PARAMETER_TABLE1.COMMAND_PARA
  is '文件推送参数';
comment on column MISSION_PARAMETER_TABLE1.NODE_GROUPS_ID
  is '任务的有效节点组范围';
comment on column MISSION_PARAMETER_TABLE1.NODE_IPS_ID
  is '设置的有效节点范围（存储节点id，用逗号连接）。如果有NODES_IP有值则不管节点组的有效范围；如果NODES_IP无值则使用节点组的范围；如果NODES_IP和NODE_GROUPS_ID均为空则有效范围是SYSTEM_ID系统内全部有效节点；如果三者均为空则有效范围为NMS系统内全部有效节点。';
alter table MISSION_PARAMETER_TABLE1
  add constraint REDFSDF primary key (MISSION_ID);

prompt
prompt Creating table MISSION_PARAMETER_TABLE2
prompt =======================================
prompt
create table MISSION_PARAMETER_TABLE2
(
  MISSION_ID      NUMBER,
  MISSION_DESC    VARCHAR2(256),
  FILE_PATH       VARCHAR2(1024),
  START_FLAG      VARCHAR2(1024),
  END_FLAG        VARCHAR2(1024),
  FILTER_KEYWORD  VARCHAR2(1024),
  MAX_RETURN      NUMBER,
  NODE_LIST_ID    NUMBER,
  LOOP_FLAG       NUMBER,
  LOOP_START_DATE DATE,
  LOOP_END_DATE   DATE,
  LOOP_DELAY      NUMBER
)
;
comment on table MISSION_PARAMETER_TABLE2
  is '任务参数信息表';
comment on column MISSION_PARAMETER_TABLE2.MISSION_ID
  is 'mission_id	Number(8)	任务id	主键';
comment on column MISSION_PARAMETER_TABLE2.MISSION_DESC
  is 'mission_desc	Varchar(256)	任务描述	可以为空';
comment on column MISSION_PARAMETER_TABLE2.FILE_PATH
  is 'file_path	Varchar(1024)	检测文件路径	不能为空，长度不能为0';
comment on column MISSION_PARAMETER_TABLE2.START_FLAG
  is 'Start_flag	Varchar(1024)	起始标志	为空表示从文件头开始，支持换行符';
comment on column MISSION_PARAMETER_TABLE2.END_FLAG
  is 'End_flag	Varchar(1024)	结束标志	为空表示到文件末尾，支持换行符';
comment on column MISSION_PARAMETER_TABLE2.FILTER_KEYWORD
  is 'Filter_keyword	Varchar(1024)	过滤关键词	支持与或表达式';
comment on column MISSION_PARAMETER_TABLE2.MAX_RETURN
  is 'Max_return	Number(5)	返回结果最大长度	不能为空，缺省1024，返回结果的最大长度';
comment on column MISSION_PARAMETER_TABLE2.NODE_LIST_ID
  is 'Node_list_id	Number(8)	节点组id	不能为空，外键';
comment on column MISSION_PARAMETER_TABLE2.LOOP_FLAG
  is 'Loop_fiag	Number(1)	是否定时任务	1是0不是';
comment on column MISSION_PARAMETER_TABLE2.LOOP_START_DATE
  is 'Loop_start_date	Date	任务起始时间	Loop_flag为1时不能为空';
comment on column MISSION_PARAMETER_TABLE2.LOOP_END_DATE
  is 'Loop_end_date	Date	任务结束时间	Loop_flag为1时不能为空';
comment on column MISSION_PARAMETER_TABLE2.LOOP_DELAY
  is 'Loop_delay	Number(4)	任务循环周期，单位为分钟	Loop_flag为1时不能为空';
create index IDX_MISSIONPARAMETER2_NODELIST on MISSION_PARAMETER_TABLE2 (NODE_LIST_ID);

prompt
prompt Creating table MISSION_PARAMETER_TABLE3
prompt =======================================
prompt
create table MISSION_PARAMETER_TABLE3
(
  MISSION_ID     NUMBER,
  MISSION_DESC   VARCHAR2(256),
  FILE_PATH      VARCHAR2(1024),
  TIME_FORMAT    NUMBER,
  START_TIME     NUMBER,
  END_TIME       NUMBER,
  FILTER_TYPE    NUMBER,
  FILTER_KEYWORD VARCHAR2(1024),
  MAX_RETURN     NUMBER,
  NODE_LIST_ID   NUMBER
)
;
comment on table MISSION_PARAMETER_TABLE3
  is '任务参数信息表';

prompt
prompt Creating table MISSION_PARAMETER_TABLE4
prompt =======================================
prompt
create table MISSION_PARAMETER_TABLE4
(
  MISSION_ID     NUMBER not null,
  MISSION_DESC   VARCHAR2(256),
  COMMAND_TYPE   NUMBER,
  COMMAND_ID     NUMBER,
  COMMAND_PARA   CLOB,
  FILTER_TYPE    NUMBER,
  FILTER_KEYWORD VARCHAR2(1024),
  MAX_RETURN     NUMBER,
  NODE_LIST_ID   NUMBER,
  VERSION        NUMBER,
  NODE_GROUPS_ID VARCHAR2(500),
  NODE_IPS_ID    VARCHAR2(500),
  COMMAND_ENAME  VARCHAR2(50)
)
;
comment on table MISSION_PARAMETER_TABLE4
  is '任务参数表';
comment on column MISSION_PARAMETER_TABLE4.VERSION
  is '版本号';
comment on column MISSION_PARAMETER_TABLE4.NODE_GROUPS_ID
  is '任务的有效节点组范围';
comment on column MISSION_PARAMETER_TABLE4.NODE_IPS_ID
  is '设置的有效节点范围（存储节点id，用逗号连接）。如果有NODES_IP有值则不管节点组的有效范围；如果NODES_IP无值则使用节点组的范围；如果NODES_IP和NODE_GROUPS_ID均为空则有效范围是SYSTEM_ID系统内全部有效节点；如果三者均为空则有效范围为NMS系统内全部有效节点。';
comment on column MISSION_PARAMETER_TABLE4.COMMAND_ENAME
  is '命令名称，根据要求废弃command_id,使用命令名称作为命令唯一标识关联命令信息';
alter table MISSION_PARAMETER_TABLE4
  add constraint SDFSDF primary key (MISSION_ID);

prompt
prompt Creating table MISSION_PARAMETER_TABLE5
prompt =======================================
prompt
create table MISSION_PARAMETER_TABLE5
(
  MISSION_ID    NUMBER,
  MISSION_DESC  VARCHAR2(256),
  NODE_LIST_ID  NUMBER,
  COMMAND_ID    NUMBER,
  COMMAND_ENAME VARCHAR2(50)
)
;
comment on table MISSION_PARAMETER_TABLE5
  is '任务参数表';
comment on column MISSION_PARAMETER_TABLE5.COMMAND_ENAME
  is '命令名称，根据要求废弃command_id,使用命令名称作为命令唯一标识关联命令信息';

prompt
prompt Creating table MISSION_PARAMETER_TABLE6
prompt =======================================
prompt
create table MISSION_PARAMETER_TABLE6
(
  MISSION_ID     NUMBER not null,
  MISSION_DESC   VARCHAR2(256),
  COMMAND_TYPE   NUMBER,
  COMMAND_ID     NUMBER,
  COMMAND_PARA   CLOB,
  FILTER_TYPE    NUMBER,
  FILTER_KEYWORD VARCHAR2(1024),
  MAX_RETURN     NUMBER,
  NODE_LIST_ID   NUMBER,
  SOURCE_PATH    VARCHAR2(1024),
  TARGET_PATH    VARCHAR2(1024),
  CHECK_VALUE    VARCHAR2(128),
  START_TIME     DATE,
  VERSION        NUMBER,
  NODE_GROUPS_ID VARCHAR2(500),
  NODE_IPS_ID    VARCHAR2(4000),
  OLD_TASK_ID    NUMBER,
  COMMAND_ENAME  VARCHAR2(50)
)
;
comment on table MISSION_PARAMETER_TABLE6
  is '任务参数表6升级任务参数信息表';
comment on column MISSION_PARAMETER_TABLE6.SOURCE_PATH
  is 'Source_path	Varchar(1024)	文件源路径	不能为空，长度不能为0';
comment on column MISSION_PARAMETER_TABLE6.TARGET_PATH
  is 'Target_path	Varchar(1024)	文件目的路径	不能为空，长度不能为0';
comment on column MISSION_PARAMETER_TABLE6.CHECK_VALUE
  is 'Check_value	Varchar(128)	文件校验值	不能为空，初步可以设定文件长度';
comment on column MISSION_PARAMETER_TABLE6.START_TIME
  is '启动时间，或文件推送后任务重启时间';
comment on column MISSION_PARAMETER_TABLE6.VERSION
  is '版本号';
comment on column MISSION_PARAMETER_TABLE6.NODE_GROUPS_ID
  is '任务的有效节点组范围';
comment on column MISSION_PARAMETER_TABLE6.NODE_IPS_ID
  is '设置的有效节点范围（存储节点id，用逗号连接）。如果有NODES_IP有值则不管节点组的有效范围；如果NODES_IP无值则使用节点组的范围；如果NODES_IP和NODE_GROUPS_ID均为空则有效范围是SYSTEM_ID系统内全部有效节点；如果三者均为空则有效范围为NMS系统内全部有效节点。';
comment on column MISSION_PARAMETER_TABLE6.OLD_TASK_ID
  is '再次执行任务ID';
comment on column MISSION_PARAMETER_TABLE6.COMMAND_ENAME
  is '命令名称，根据要求废弃command_id,使用命令名称作为命令唯一标识关联命令信息';
alter table MISSION_PARAMETER_TABLE6
  add constraint DFDF primary key (MISSION_ID);

prompt
prompt Creating table MISSION_RESULT_TABLE1
prompt ====================================
prompt
create table MISSION_RESULT_TABLE1
(
  MISSION_ID  NUMBER not null,
  NODE_ID     NUMBER,
  RESULT      NUMBER,
  RESULT_DESC CLOB,
  SEQ_ID      NUMBER not null
)
;
comment on column MISSION_RESULT_TABLE1.MISSION_ID
  is 'mission_id	Number(2)	任务id	和下一项联合主键';
comment on column MISSION_RESULT_TABLE1.NODE_ID
  is 'Node_id	Number(8)	节点id	节点id';
comment on column MISSION_RESULT_TABLE1.RESULT
  is 'Result	Number(1)执行失败，最终结果1;最终执行成功状态为0。';
comment on column MISSION_RESULT_TABLE1.RESULT_DESC
  is 'Fail_desc	Varchar(1024)	失败原因	可以为空';
alter table MISSION_RESULT_TABLE1
  add constraint WQWSQ primary key (MISSION_ID, SEQ_ID);

prompt
prompt Creating table MISSION_RESULT_TABLE2
prompt ====================================
prompt
create table MISSION_RESULT_TABLE2
(
  MISSION_ID  NUMBER not null,
  NODE_ID     NUMBER,
  RESULT      NUMBER,
  RESULT_DESC VARCHAR2(1024),
  RETURN_CON  CLOB,
  SEQ_ID      NUMBER not null
)
;

prompt
prompt Creating table MISSION_RESULT_TABLE3
prompt ====================================
prompt
create table MISSION_RESULT_TABLE3
(
  MISSION_ID  NUMBER not null,
  NODE_ID     NUMBER,
  RESULT      NUMBER,
  RESULT_DESC VARCHAR2(1024),
  SEQ_ID      NUMBER not null
)
;
alter table MISSION_RESULT_TABLE3
  add constraint RETRTETRE primary key (MISSION_ID, SEQ_ID);

prompt
prompt Creating table MISSION_RESULT_TABLE4
prompt ====================================
prompt
create table MISSION_RESULT_TABLE4
(
  MISSION_ID    NUMBER not null,
  NODE_ID       NUMBER,
  RESULT        NUMBER,
  RESULT_DESC   CLOB,
  SEQ_ID        NUMBER not null,
  FILE_INFO     VARCHAR2(2048),
  RESULT_DETAIL NUMBER
)
;
comment on column MISSION_RESULT_TABLE4.RESULT
  is '3任务信息下发中；40任务信息下发成功（信息有NMSAgent端提供），41任务信息下发失败（信息有NMSServer端提供）；以下结果由NMSAgent端提供：50停用进程成功，51停用进程失败；60备份失败，61备份成功；70覆盖目标目录成功，71覆盖目标目录失败；80启动成功，81启动失败；每个失败都表示本节点执行失败，最终结果1;最终执行成功状态为0。';
comment on column MISSION_RESULT_TABLE4.FILE_INFO
  is '上传文件存储字段（格式： 显示名称$@$实际名称;显示名称$@$实际名称;）';
comment on column MISSION_RESULT_TABLE4.RESULT_DETAIL
  is '任务结果失败的具体原因，目前只用于下发失败的情况(41)，主要用于下发失败后，再次初始化周期任务的结果时，默认结果为1（失败），具体结果为41（下发失败）';
alter table MISSION_RESULT_TABLE4
  add constraint SFSDFSDF primary key (MISSION_ID, SEQ_ID);

prompt
prompt Creating table MISSION_RESULT_TABLE5
prompt ====================================
prompt
create table MISSION_RESULT_TABLE5
(
  MISSION_ID  NUMBER not null,
  NODE_ID     NUMBER,
  RESULT      NUMBER,
  RESULT_DESC VARCHAR2(6),
  SEQ_ID      NUMBER not null
)
;
alter table MISSION_RESULT_TABLE5
  add constraint GRTETRETER primary key (MISSION_ID, SEQ_ID);

prompt
prompt Creating table MISSION_RESULT_TABLE6
prompt ====================================
prompt
create table MISSION_RESULT_TABLE6
(
  MISSION_ID  NUMBER not null,
  NODE_ID     NUMBER,
  RESULT      NUMBER,
  RESULT_DESC CLOB,
  SEQ_ID      NUMBER not null,
  FILE_INFO   VARCHAR2(2048)
)
;
comment on column MISSION_RESULT_TABLE6.RESULT
  is '3任务信息下发中；40任务信息下发成功（信息有NMSAgent端提供），41任务信息下发失败（信息有NMSServer端提供）；以下结果由NMSAgent端提供：50停用进程成功，51停用进程失败；60备份失败，61备份成功；70覆盖目标目录成功，71覆盖目标目录失败；80启动成功，81启动失败；每个失败都表示本节点执行失败，最终结果1;最终执行成功状态为0。';
comment on column MISSION_RESULT_TABLE6.FILE_INFO
  is '上传文件存储字段（格式： 显示名称$@$实际名称;显示名称$@$实际名称;）';
alter table MISSION_RESULT_TABLE6
  add constraint AQADQWDQ primary key (MISSION_ID, SEQ_ID);

prompt
prompt Creating table MISSION_STATE_TABLE
prompt ==================================
prompt
create table MISSION_STATE_TABLE
(
  MISSION_ID         NUMBER not null,
  MISSION_NAME       VARCHAR2(64),
  MISSION_TYPE       NUMBER,
  MISSION_STATE      NUMBER,
  VIEW_LEVEL         NUMBER,
  USER_ID            NUMBER,
  GROUP_ID           NUMBER,
  CREATE_TIME        DATE,
  START_TIME         DATE,
  END_TIME           DATE,
  FAIL_DESC          VARCHAR2(255),
  SYSTEM_ID          NUMBER,
  IS_LOOP            NUMBER,
  LOOP_DELAY         NUMBER,
  CONTACT_USER_IDS   VARCHAR2(512),
  FAILED_COUNT       NUMBER default 0,
  AUTO_DESC          VARCHAR2(3200),
  MISSION_STATE_DESC VARCHAR2(100),
  IS_LOOK            CHAR(1),
  LOOK_USER_ID       VARCHAR2(100)
)
;
comment on table MISSION_STATE_TABLE
  is '任务状态表';
comment on column MISSION_STATE_TABLE.MISSION_ID
  is 'mission_id	Number(8)	任务id	主键';
comment on column MISSION_STATE_TABLE.MISSION_NAME
  is 'mission_name	Varchar(64)	任务名称	不能为空';
comment on column MISSION_STATE_TABLE.MISSION_TYPE
  is 'Mission_type	Number(1)	任务类型	不能为空，类型可选[1、2、3、4、5]1-文件推送
2-非流文本数据获取
3-流文本数据获取
4-命令执行
5-shell注册
';
comment on column MISSION_STATE_TABLE.MISSION_STATE
  is 'Mission_State  Number(1)  任务状态  不能为空，状态可选[0、1、2、3、4、5]0-任务信息保存 1-任务已创建
2-任务已开始执行
3-周期任务已完成（包含部分节点失败情况），30、31、32非周期任务已完成（30-全部成功，31-全部失败，32-部分成功）
4-任务未能执行
5-定时任务已经被撤销

';
comment on column MISSION_STATE_TABLE.VIEW_LEVEL
  is '查看范围取值范围[1、3]
1-发布人查看
2-发布人所在组查看
3-系统内全部人员可看
';
comment on column MISSION_STATE_TABLE.USER_ID
  is '用户id';
comment on column MISSION_STATE_TABLE.GROUP_ID
  is '用户组id';
comment on column MISSION_STATE_TABLE.CREATE_TIME
  is 'Create_time	Date	创建时间	可以为空';
comment on column MISSION_STATE_TABLE.START_TIME
  is 'Start_time	Date	开始执行时间	可以为空';
comment on column MISSION_STATE_TABLE.END_TIME
  is 'End_time	Date	中止时间	可以为空';
comment on column MISSION_STATE_TABLE.FAIL_DESC
  is 'Fail_desc	Varchar(256)	失败原因	可以为空';
comment on column MISSION_STATE_TABLE.SYSTEM_ID
  is '业务系统id';
comment on column MISSION_STATE_TABLE.IS_LOOP
  is '是否定时任务	不能为空：1是；0不是。默认值0';
comment on column MISSION_STATE_TABLE.LOOP_DELAY
  is 'Loop_delay	Number(4)	任务循环周期，单位为分钟	Loop_flag为1时不能为空';
comment on column MISSION_STATE_TABLE.CONTACT_USER_IDS
  is '联系人ID,逗号间隔';
comment on column MISSION_STATE_TABLE.FAILED_COUNT
  is '失败数';
comment on column MISSION_STATE_TABLE.MISSION_STATE_DESC
  is '任务结果状态的描述信息';
comment on column MISSION_STATE_TABLE.IS_LOOK
  is '是否查看结果：0已查看  1未查看';
comment on column MISSION_STATE_TABLE.LOOK_USER_ID
  is '查看人ID';
alter table MISSION_STATE_TABLE
  add constraint PRIMARYMISSION_STATE_TABLE1 primary key (MISSION_ID);

prompt
prompt Creating table NMS_ERROR_CODE
prompt =============================
prompt
create table NMS_ERROR_CODE
(
  ID          NUMBER not null,
  ERROR_CODE  VARCHAR2(50) not null,
  ERROR_NAME  VARCHAR2(100) not null,
  ERROR_DES   VARCHAR2(200),
  ERROR_LEVEL NUMBER default 0 not null
)
;
comment on table NMS_ERROR_CODE
  is 'NMS异常代码表';
comment on column NMS_ERROR_CODE.ERROR_CODE
  is '异常code;非空不重复';
comment on column NMS_ERROR_CODE.ERROR_NAME
  is '异常名称:非空不重复';
comment on column NMS_ERROR_CODE.ERROR_DES
  is '异常描述';
comment on column NMS_ERROR_CODE.ERROR_LEVEL
  is '错误（告警）级别';
alter table NMS_ERROR_CODE
  add constraint SFSSDF primary key (ID);

prompt
prompt Creating table NMS_ERROR_INFO
prompt =============================
prompt
create table NMS_ERROR_INFO
(
  ID                  NUMBER not null,
  ERROR_CODE          VARCHAR2(50),
  ERROR_TIME          DATE,
  ERRORT_GETIP        VARCHAR2(20),
  ERRORT_IP           VARCHAR2(20),
  ERROR_STATE         NUMBER,
  STATE_UPDATE_TIME   DATE,
  STATE_UPDATE_USERID NUMBER,
  ERROR_DES           VARCHAR2(200)
)
;
comment on table NMS_ERROR_INFO
  is '异常信息表';
comment on column NMS_ERROR_INFO.ERROR_CODE
  is '异常code：非空';
comment on column NMS_ERROR_INFO.ERROR_TIME
  is '异常产生时间：非空';
comment on column NMS_ERROR_INFO.ERRORT_GETIP
  is '异常信息提供IP：非空';
comment on column NMS_ERROR_INFO.ERRORT_IP
  is '异常信息产生IP：非空';
comment on column NMS_ERROR_INFO.ERROR_STATE
  is '非空异常状态非空：0已解决；1未解决';
comment on column NMS_ERROR_INFO.STATE_UPDATE_TIME
  is '解决时间';
comment on column NMS_ERROR_INFO.STATE_UPDATE_USERID
  is '解决人';
comment on column NMS_ERROR_INFO.ERROR_DES
  is '异常描述信息';
alter table NMS_ERROR_INFO
  add constraint IDSFD primary key (ID);

prompt
prompt Creating table NODEGROUP_ARROW_POSITION
prompt =======================================
prompt
create table NODEGROUP_ARROW_POSITION
(
  ID                 NUMBER not null,
  SYSTEM_ID          NUMBER not null,
  SRC_GROUP_ID       NUMBER,
  DESC_GROUP_ID      NUMBER,
  FIGURE_X           NUMBER not null,
  FIGURE_Y           NUMBER not null,
  FIGURE_WIDTH       NUMBER not null,
  FIGURE_HEIGHT      NUMBER not null,
  FIGURE_FILL        VARCHAR2(100) not null,
  CREATE_TIME        DATE,
  CREATE_USERID      NUMBER,
  LAST_UPDATE_TIME   DATE,
  LAST_UPDATE_USERID NUMBER
)
;
comment on table NODEGROUP_ARROW_POSITION
  is '拓扑图动态箭头位置预置数据表';
comment on column NODEGROUP_ARROW_POSITION.ID
  is '主键ID';
comment on column NODEGROUP_ARROW_POSITION.SYSTEM_ID
  is '业务系统ID';
comment on column NODEGROUP_ARROW_POSITION.SRC_GROUP_ID
  is '箭头源节点组ID';
comment on column NODEGROUP_ARROW_POSITION.DESC_GROUP_ID
  is '箭头目标节点组ID';
comment on column NODEGROUP_ARROW_POSITION.FIGURE_X
  is '图片X坐标';
comment on column NODEGROUP_ARROW_POSITION.FIGURE_Y
  is '图片Y坐标';
comment on column NODEGROUP_ARROW_POSITION.FIGURE_WIDTH
  is '图片宽度';
comment on column NODEGROUP_ARROW_POSITION.FIGURE_HEIGHT
  is '图片高度';
comment on column NODEGROUP_ARROW_POSITION.FIGURE_FILL
  is '图片名称';
comment on column NODEGROUP_ARROW_POSITION.CREATE_TIME
  is '创建时间';
comment on column NODEGROUP_ARROW_POSITION.CREATE_USERID
  is '创建人';
comment on column NODEGROUP_ARROW_POSITION.LAST_UPDATE_TIME
  is '最后更改时间';
comment on column NODEGROUP_ARROW_POSITION.LAST_UPDATE_USERID
  is '最后更改人';

prompt
prompt Creating table NODEGROUP_BGIMG_POSITION
prompt =======================================
prompt
create table NODEGROUP_BGIMG_POSITION
(
  ID                 NUMBER not null,
  SYSTEM_ID          NUMBER not null,
  GROUP_ID           NUMBER not null,
  FIGURE_X           NUMBER not null,
  FIGURE_Y           NUMBER not null,
  FIGURE_WIDTH       NUMBER not null,
  FIGURE_HEIGHT      NUMBER not null,
  FIGURE_FILL        VARCHAR2(100) not null,
  CREATE_TIME        DATE,
  CREATE_USERID      NUMBER,
  LAST_UPDATE_TIME   DATE,
  LAST_UPDATE_USERID NUMBER
)
;
comment on table NODEGROUP_BGIMG_POSITION
  is '逻辑拓扑图节点组背景图片位置表';
comment on column NODEGROUP_BGIMG_POSITION.ID
  is '主键ID';
comment on column NODEGROUP_BGIMG_POSITION.SYSTEM_ID
  is '业务系统ID';
comment on column NODEGROUP_BGIMG_POSITION.GROUP_ID
  is '节点组ID';
comment on column NODEGROUP_BGIMG_POSITION.FIGURE_X
  is '图片X坐标';
comment on column NODEGROUP_BGIMG_POSITION.FIGURE_Y
  is '图片Y坐标';
comment on column NODEGROUP_BGIMG_POSITION.FIGURE_WIDTH
  is '图片宽度';
comment on column NODEGROUP_BGIMG_POSITION.FIGURE_HEIGHT
  is '图片高度';
comment on column NODEGROUP_BGIMG_POSITION.FIGURE_FILL
  is '图片名称';
comment on column NODEGROUP_BGIMG_POSITION.CREATE_TIME
  is '创建时间';
comment on column NODEGROUP_BGIMG_POSITION.CREATE_USERID
  is '创建人';
comment on column NODEGROUP_BGIMG_POSITION.LAST_UPDATE_TIME
  is '最后更改时间';
comment on column NODEGROUP_BGIMG_POSITION.LAST_UPDATE_USERID
  is '最后更改人';
alter table NODEGROUP_BGIMG_POSITION
  add constraint NODEGROUP_BGIMG_POSITION_ID primary key (ID);

prompt
prompt Creating table NODEGROUP_POSITION
prompt =================================
prompt
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
  is 'X坐标  ';
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

prompt
prompt Creating table NODE_BOX_TABLE
prompt =============================
prompt
create table NODE_BOX_TABLE
(
  BOX_ID            NUMBER not null,
  DESCINFO          VARCHAR2(200),
  ISPN              VARCHAR2(100),
  BOX_U_TYPE        NUMBER,
  ROOM_ISPN         VARCHAR2(200),
  ROOM_ROW_POSITION NUMBER,
  ROOM_COL_POSITION NUMBER
)
;
comment on table NODE_BOX_TABLE
  is '机柜信息表';
comment on column NODE_BOX_TABLE.BOX_ID
  is 'id主键';
comment on column NODE_BOX_TABLE.DESCINFO
  is '机柜描述';
comment on column NODE_BOX_TABLE.ISPN
  is '机柜编号';
comment on column NODE_BOX_TABLE.BOX_U_TYPE
  is '机柜U位';
comment on column NODE_BOX_TABLE.ROOM_ISPN
  is '机房编号';
comment on column NODE_BOX_TABLE.ROOM_ROW_POSITION
  is '机房行号';
comment on column NODE_BOX_TABLE.ROOM_COL_POSITION
  is '机房列号';
alter table NODE_BOX_TABLE
  add constraint PK_NODE_BOX_TABLE primary key (BOX_ID);

prompt
prompt Creating table NODE_FIGURE_INFO
prompt ===============================
prompt
create table NODE_FIGURE_INFO
(
  ID                      NUMBER not null,
  PID                     NUMBER not null,
  DEVICE_TYPE_CODE        VARCHAR2(100) not null,
  SEQID                   NUMBER not null,
  SHOW_LEVEL              NUMBER not null,
  SHOW_INDEX              NUMBER,
  NAME_FLAG               VARCHAR2(64) not null,
  PORT_OPER_STATUS        NUMBER not null,
  PORT_STATUS             NUMBER not null,
  FIGURE_TYPE             VARCHAR2(64) not null,
  FIGURE_X                NUMBER,
  FIGURE_Y                NUMBER,
  FIGURE_WIDTH            NUMBER,
  FIGURE_HEIGHT           NUMBER,
  FIGURE_STROKE           VARCHAR2(20),
  FIGURE_STROKE_WIDTH     NUMBER,
  FIGURE_FILL             VARCHAR2(100),
  DATA_CHECK_TIME_DIGITAL NUMBER,
  ADD_TIME                DATE,
  ADD_USERID              NUMBER,
  LAST_UPDATE_TIME        DATE,
  LAST_UPDATE_USERID      NUMBER,
  FIGURE_FILL_MODEL       VARCHAR2(100),
  IS_LEAF                 NUMBER,
  PORT_SET_STATE          NUMBER
)
;
comment on table NODE_FIGURE_INFO
  is '节点图形定义（根据设置生成）';
comment on column NODE_FIGURE_INFO.ID
  is '主键';
comment on column NODE_FIGURE_INFO.PID
  is '父级id';
comment on column NODE_FIGURE_INFO.DEVICE_TYPE_CODE
  is '设备型号:作为设置数据检查参照';
comment on column NODE_FIGURE_INFO.SEQID
  is '节点物理标识';
comment on column NODE_FIGURE_INFO.SHOW_LEVEL
  is '图形级别:最多支持5级';
comment on column NODE_FIGURE_INFO.SHOW_INDEX
  is '级别下位置序号:注意从0还是从1开始';
comment on column NODE_FIGURE_INFO.NAME_FLAG
  is ':名称标识:例如：pos1_0,xgei_2/3,
Ten-GigabitEthernet14/0/1等
';
comment on column NODE_FIGURE_INFO.PORT_OPER_STATUS
  is '状态：1up；2down。';
comment on column NODE_FIGURE_INFO.PORT_STATUS
  is 'Up端口的状态:0不正常；1正常';
comment on column NODE_FIGURE_INFO.FIGURE_TYPE
  is 'rect、circle、image等svg图形类型';
comment on column NODE_FIGURE_INFO.FIGURE_X
  is 'X坐标';
comment on column NODE_FIGURE_INFO.FIGURE_Y
  is 'Y坐标';
comment on column NODE_FIGURE_INFO.FIGURE_WIDTH
  is '宽';
comment on column NODE_FIGURE_INFO.FIGURE_HEIGHT
  is '高';
comment on column NODE_FIGURE_INFO.FIGURE_STROKE
  is '边颜色';
comment on column NODE_FIGURE_INFO.FIGURE_STROKE_WIDTH
  is '边宽';
comment on column NODE_FIGURE_INFO.FIGURE_FILL
  is '填充色:图形为填充色；image为xlink:href内容';
comment on column NODE_FIGURE_INFO.DATA_CHECK_TIME_DIGITAL
  is '监测时间id（new）作为svg文件名称';
comment on column NODE_FIGURE_INFO.ADD_TIME
  is '添加时间';
comment on column NODE_FIGURE_INFO.ADD_USERID
  is '添加人';
comment on column NODE_FIGURE_INFO.LAST_UPDATE_TIME
  is '最后更改时间';
comment on column NODE_FIGURE_INFO.LAST_UPDATE_USERID
  is '最后更改人';
comment on column NODE_FIGURE_INFO.FIGURE_FILL_MODEL
  is '做为FIGURE_FILL字段的模板';
comment on column NODE_FIGURE_INFO.IS_LEAF
  is '是否有链接，1：是，0：否（有的叶子节点没有链接，如电源、风扇）';
comment on column NODE_FIGURE_INFO.PORT_SET_STATE
  is '端口设置状态：1up；2down。';
alter table NODE_FIGURE_INFO
  add constraint PK_NODE_FIGURE_INFO primary key (ID);

prompt
prompt Creating table NODE_IP_TABLE
prompt ============================
prompt
create table NODE_IP_TABLE
(
  NODE_IP   VARCHAR2(64),
  NODE_ID   NUMBER,
  NODE_TYPE NUMBER
)
;

prompt
prompt Creating table NODE_LATTICE_TABLE
prompt =================================
prompt
create table NODE_LATTICE_TABLE
(
  ID                    NUMBER not null,
  LATTICE_POSITION      NUMBER not null,
  NODE_BOX_ID           NUMBER not null,
  NODE_SEQ              NUMBER,
  LOTTICE_POSITION_TEMP NUMBER
)
;
comment on table NODE_LATTICE_TABLE
  is '机柜中个节点的格子';
comment on column NODE_LATTICE_TABLE.ID
  is '主键id';
comment on column NODE_LATTICE_TABLE.LATTICE_POSITION
  is '机柜中的U位位置从下到上';
comment on column NODE_LATTICE_TABLE.NODE_BOX_ID
  is '机柜id';
comment on column NODE_LATTICE_TABLE.NODE_SEQ
  is '物理节点seqid';
comment on column NODE_LATTICE_TABLE.LOTTICE_POSITION_TEMP
  is '机柜中的U位位置从下到上bak';
alter table NODE_LATTICE_TABLE
  add constraint PK_NODE_LATTICE_TABLE primary key (ID);

prompt
prompt Creating table NODE_POSITION
prompt ============================
prompt
create table NODE_POSITION
(
  ID             NUMBER not null,
  TABLE_NAME     VARCHAR2(255),
  NODE_TYPE      VARCHAR2(255),
  NODE_ID        VARCHAR2(255),
  POSITION_X     NUMBER,
  POSITION_Y     NUMBER,
  IMAGE_URL      VARCHAR2(255),
  VIEW_TIME_MARK DATE,
  VIEW_TYPE      NUMBER,
  PARENT_ID      NUMBER
)
;
comment on table NODE_POSITION
  is '拓扑位置关系表';
comment on column NODE_POSITION.TABLE_NAME
  is '表名';
comment on column NODE_POSITION.NODE_TYPE
  is '节点类型';
comment on column NODE_POSITION.NODE_ID
  is '节点ID';
comment on column NODE_POSITION.POSITION_X
  is '图面 横坐标';
comment on column NODE_POSITION.POSITION_Y
  is '图面 纵坐标';
comment on column NODE_POSITION.IMAGE_URL
  is '节点展示图片Url地址';
comment on column NODE_POSITION.VIEW_TIME_MARK
  is '创建展示的时间  通过时间间隔 ，借助CSS样式，用于区别新旧节点';
comment on column NODE_POSITION.VIEW_TYPE
  is '展示类别（0:默认值，普通节点  1:图标集合，可双击展示子图  2:方块集合，其子节点均为方块展示）';
comment on column NODE_POSITION.PARENT_ID
  is '父级关联节点ID';
alter table NODE_POSITION
  add constraint NODEPOSITION_PK primary key (ID);

prompt
prompt Creating table NODE_ROOM_LATTICE_TABLE
prompt ======================================
prompt
create table NODE_ROOM_LATTICE_TABLE
(
  ID                   NUMBER not null,
  LATTICE_ROW_POSITION NUMBER not null,
  LATTICE_COL_POSITION NUMBER not null,
  ROOM_ID              NUMBER not null,
  NODE_BOX_ID          NUMBER
)
;
comment on table NODE_ROOM_LATTICE_TABLE
  is '机房位置表';
comment on column NODE_ROOM_LATTICE_TABLE.ID
  is '主键id';
comment on column NODE_ROOM_LATTICE_TABLE.LATTICE_ROW_POSITION
  is '机房中的行位置';
comment on column NODE_ROOM_LATTICE_TABLE.LATTICE_COL_POSITION
  is '机房中的列位置';
comment on column NODE_ROOM_LATTICE_TABLE.ROOM_ID
  is '机房id';
comment on column NODE_ROOM_LATTICE_TABLE.NODE_BOX_ID
  is '机柜id';
alter table NODE_ROOM_LATTICE_TABLE
  add constraint ROOM_LATTICE_TABLE_PK primary key (ID);

prompt
prompt Creating table NODE_ROOM_TABLE
prompt ==============================
prompt
create table NODE_ROOM_TABLE
(
  ROOM_ID         NUMBER not null,
  ROOM_ISPN       VARCHAR2(100) not null,
  ROOM_DESC       VARCHAR2(200),
  ROOM_ROWS       NUMBER,
  ROOM_COLS       NUMBER,
  CREATE_USER_ID  NUMBER,
  CREATE_DATETIME DATE,
  UPDATE_USER_ID  NUMBER,
  UPDATE_DATETIME DATE
)
;
comment on table NODE_ROOM_TABLE
  is '机房';
comment on column NODE_ROOM_TABLE.ROOM_ID
  is 'ID主键';
comment on column NODE_ROOM_TABLE.ROOM_ISPN
  is '机房编号';
comment on column NODE_ROOM_TABLE.ROOM_DESC
  is '机房描述';
comment on column NODE_ROOM_TABLE.ROOM_ROWS
  is '机房行数';
comment on column NODE_ROOM_TABLE.ROOM_COLS
  is '机房列数';
comment on column NODE_ROOM_TABLE.CREATE_USER_ID
  is '创建用户ID';
comment on column NODE_ROOM_TABLE.CREATE_DATETIME
  is '创建时间';
comment on column NODE_ROOM_TABLE.UPDATE_USER_ID
  is '最后更新用户ID';
comment on column NODE_ROOM_TABLE.UPDATE_DATETIME
  is '最后更新时间';
alter table NODE_ROOM_TABLE
  add constraint NODE_ROOM_TABLE_PK primary key (ROOM_ID);

prompt
prompt Creating table NODE_TABLE
prompt =========================
prompt
create table NODE_TABLE
(
  NODE_ID              NUMBER not null,
  NODE_IP              VARCHAR2(64),
  NODE_TYPE            NUMBER,
  NODE_NAME            VARCHAR2(64),
  NODE_DESC            VARCHAR2(256),
  NODE_STATE           NUMBER,
  SYSTEM_ID            NUMBER,
  NODE_CREATETIME      DATE,
  CREATE_USER_ID       NUMBER,
  NODE_STOPTIME        DATE,
  STOP_USER_ID         NUMBER,
  IS_TEMP              NUMBER default 0,
  IPN                  NUMBER,
  NODE_LATTICE_ID      NUMBER,
  SEQ_ID               NUMBER,
  NODE_GROUP_ID        NUMBER,
  NODE_U_TYPE          NUMBER,
  BRAND_ID             NUMBER,
  SNMP_VERSION         VARCHAR2(256),
  NODE_SYSTEM_TYPE     NUMBER,
  NODE_MAC             VARCHAR2(100),
  NODE_IP_INFO         VARCHAR2(256),
  NODE_BEGIN_UTYPE     NUMBER,
  NODE_BOX_ISPN        VARCHAR2(100),
  NODE_USERNAME        VARCHAR2(20),
  NODE_PASSWORD        VARCHAR2(50),
  NETWORK_ELEMENT_TYPE NUMBER
)
;
comment on column NODE_TABLE.NODE_IP
  is 'ip';
comment on column NODE_TABLE.NODE_TYPE
  is '节点类型：服务器等';
comment on column NODE_TABLE.NODE_NAME
  is '节点名称';
comment on column NODE_TABLE.NODE_DESC
  is '描述';
comment on column NODE_TABLE.NODE_STATE
  is '节点状态：0，有效；1，无效';
comment on column NODE_TABLE.SYSTEM_ID
  is '系统id';
comment on column NODE_TABLE.NODE_CREATETIME
  is '创建时间';
comment on column NODE_TABLE.CREATE_USER_ID
  is '创建人id';
comment on column NODE_TABLE.NODE_STOPTIME
  is '停用时间';
comment on column NODE_TABLE.STOP_USER_ID
  is '停用人';
comment on column NODE_TABLE.IS_TEMP
  is '临时节点标识默认0 临时节点，1为确认节点';
comment on column NODE_TABLE.IPN
  is '整型IP值';
comment on column NODE_TABLE.NODE_LATTICE_ID
  is '格子id';
comment on column NODE_TABLE.SEQ_ID
  is '物理主机的唯一标识';
comment on column NODE_TABLE.NODE_GROUP_ID
  is '节点组id';
comment on column NODE_TABLE.NODE_U_TYPE
  is '节点物理厚度（U位）';
comment on column NODE_TABLE.BRAND_ID
  is '品牌id';
comment on column NODE_TABLE.SNMP_VERSION
  is '节点支持的SNMP 的版本标准  version2c=1  version3=3';
comment on column NODE_TABLE.NODE_SYSTEM_TYPE
  is '节点的操作系统类型：1 Linux，2   Windows， 3 Other';
comment on column NODE_TABLE.NODE_MAC
  is '节点MAC地址';
comment on column NODE_TABLE.NODE_IP_INFO
  is '节点IP信息';
comment on column NODE_TABLE.NODE_BEGIN_UTYPE
  is '节点起始U位';
comment on column NODE_TABLE.NODE_BOX_ISPN
  is '机柜编号';
comment on column NODE_TABLE.NODE_USERNAME
  is '节点机用户名';
comment on column NODE_TABLE.NODE_PASSWORD
  is '节点机密码';
comment on column NODE_TABLE.NETWORK_ELEMENT_TYPE
  is '网元类型';
alter table NODE_TABLE
  add constraint PRIMARYNODE_TABLE1 primary key (NODE_ID);
create index IDX_NODESYSTEMFKIDNODE_TABLE on NODE_TABLE (SYSTEM_ID);


prompt
prompt Creating table OPTION_TABLE
prompt ===========================
prompt
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

prompt
prompt Creating table ORDER_TABLE
prompt ==========================
prompt
create table ORDER_TABLE
(
  COMMAND_ID       NUMBER not null,
  COMMAND_NAME     VARCHAR2(64),
  COMMAND_DESC     VARCHAR2(512),
  COMMAND_TYPE     NUMBER,
  COMMAND_FLAG     VARCHAR2(256),
  SHELL_PATH       VARCHAR2(256),
  SHELL_CHECK      VARCHAR2(128),
  IS_VALID         NUMBER,
  COMMAND_MODEL    VARCHAR2(2048),
  COMMAND_ALIAS    VARCHAR2(32),
  COMMAND_MODELNEW VARCHAR2(100)
)
;
comment on table ORDER_TABLE
  is '命令信息表';
comment on column ORDER_TABLE.COMMAND_MODEL
  is '命令模板';
comment on column ORDER_TABLE.COMMAND_ALIAS
  is '别名';
comment on column ORDER_TABLE.COMMAND_MODELNEW
  is '模板名称';
alter table ORDER_TABLE
  add constraint PRIMARYORDER_TABLE1 primary key (COMMAND_ID);

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
prompt Creating table PROEXECINFO
prompt ==========================
prompt
create table PROEXECINFO
(
  ID      NUMBER not null,
  PRONAME VARCHAR2(100),
  PARAM   NUMBER,
  PRODESC VARCHAR2(300)
)
;
comment on table PROEXECINFO
  is '存储过程执行信息表';
comment on column PROEXECINFO.PRONAME
  is '存储过程名称';
comment on column PROEXECINFO.PARAM
  is '执行参数值，在存储过程执行到每一行都更参数值';
comment on column PROEXECINFO.PRODESC
  is '执行存储过程到每一行需要存储的关键字数据';
alter table PROEXECINFO
  add constraint PROEXECINFO_KEY primary key (ID);

prompt
prompt Creating table PRO_EXEC_LOG
prompt ===========================
prompt
create table PRO_EXEC_LOG
(
  ID       NUMBER not null,
  LOG_TIME DATE default sysdate not null,
  PRONAME  VARCHAR2(100),
  SEQUENCE VARCHAR2(100),
  LOG_CONT VARCHAR2(1024)
)
;
comment on column PRO_EXEC_LOG.LOG_TIME
  is '日志记录时间，默认取数据库时间';
comment on column PRO_EXEC_LOG.PRONAME
  is '存储过程名称';
comment on column PRO_EXEC_LOG.SEQUENCE
  is '步骤编号';
comment on column PRO_EXEC_LOG.LOG_CONT
  is '日志详细内容';
alter table PRO_EXEC_LOG
  add primary key (ID);

prompt
prompt Creating table SERVER_IP_SEGMENT
prompt ================================
prompt
create table SERVER_IP_SEGMENT
(
  ID            NUMBER not null,
  SERVER_ID     NUMBER not null,
  START_IP      VARCHAR2(100),
  START_IPN     NUMBER,
  END_IP        VARCHAR2(100),
  END_IPN       NUMBER,
  SEGMENT_STATE NUMBER default 0,
  NODE_TYPE     NUMBER,
  NODE_COUNT    NUMBER
)
;
comment on table SERVER_IP_SEGMENT
  is 'NMSDataController服务器IP段信息表';
comment on column SERVER_IP_SEGMENT.ID
  is '主键ID';
comment on column SERVER_IP_SEGMENT.SERVER_ID
  is 'Server_table Id';
comment on column SERVER_IP_SEGMENT.START_IP
  is '起始IP';
comment on column SERVER_IP_SEGMENT.START_IPN
  is '起始IPN';
comment on column SERVER_IP_SEGMENT.END_IP
  is '结束IP';
comment on column SERVER_IP_SEGMENT.END_IPN
  is '结束IPN';
comment on column SERVER_IP_SEGMENT.SEGMENT_STATE
  is '范围状态标示（0:固定和默认值 1:临时 2:自定义  -1:无效）（预留值-1，用于优化业务）';
comment on column SERVER_IP_SEGMENT.NODE_TYPE
  is '节点类型（由节点表 服务器交换机等节点类型的对应值）';
comment on column SERVER_IP_SEGMENT.NODE_COUNT
  is '管理节点数（计算后更新，只作为展示使用）';
alter table SERVER_IP_SEGMENT
  add constraint GHFGFG primary key (ID);

prompt
prompt Creating table SET_DET_DATA_CON
prompt ===============================
prompt
create table SET_DET_DATA_CON
(
  ID              NUMBER not null,
  MENU_NAME       VARCHAR2(200),
  POLICE_LEVEL    VARCHAR2(200),
  POLICE_EMERGENT VARCHAR2(20),
  MENU_CODE       VARCHAR2(100)
)
;
comment on table SET_DET_DATA_CON
  is '监测数据列表过滤条件的设置信息表';
comment on column SET_DET_DATA_CON.MENU_NAME
  is '菜单名称，对应菜单名称修改时，可以修改，用于显示给用户';
comment on column SET_DET_DATA_CON.POLICE_LEVEL
  is '告警级别：目前支持1-5级';
comment on column SET_DET_DATA_CON.POLICE_EMERGENT
  is '告警是否紧急 0：紧急  1：非紧急';
comment on column SET_DET_DATA_CON.MENU_CODE
  is '菜单编号，不会改变';

prompt
prompt Creating table SORT_INFO
prompt ========================
prompt
create table SORT_INFO
(
  ID        NUMBER not null,
  SORT_NAME VARCHAR2(100),
  SORT_DESC VARCHAR2(600)
)
;
comment on table SORT_INFO
  is '监测名称定义表：如cpu用户使用率(%)、cpu系统使用率(%) 、硬盘使用率等';
comment on column SORT_INFO.SORT_NAME
  is '类别名称';
comment on column SORT_INFO.SORT_DESC
  is '类别描述';
alter table SORT_INFO
  add constraint PK_SORT_INFO primary key (ID)
  disable;

prompt
prompt Creating table SYSTEM_TABLE
prompt ===========================
prompt
create table SYSTEM_TABLE
(
  SYSTEM_ID          NUMBER not null,
  SYSTEM_NAME        VARCHAR2(64),
  SYSTEM_DESC        VARCHAR2(256),
  SYSTEM_STATE       VARCHAR2(1),
  SYSTEM_CREATETIME  DATE,
  CREATE_USER_ID     NUMBER,
  SYSTEM_STOPTIME    DATE,
  STOP_USER_ID       NUMBER,
  SYSTEM_IP          VARCHAR2(100),
  SYSTEM_IPN         NUMBER,
  SYSTEM_PORT        NUMBER,
  SYSTEM_START_STATE NUMBER,
  IS_MASTER          NUMBER
)
;
comment on table SYSTEM_TABLE
  is '系统信息表（NMSWeb信息表）';
comment on column SYSTEM_TABLE.SYSTEM_STATE
  is '系统信息状态 （0有效，1无效）';
comment on column SYSTEM_TABLE.SYSTEM_IP
  is '系统webIP';
comment on column SYSTEM_TABLE.SYSTEM_IPN
  is '系统webIPN';
comment on column SYSTEM_TABLE.SYSTEM_PORT
  is '系统web端口';
comment on column SYSTEM_TABLE.SYSTEM_START_STATE
  is '系统web启动状态（0启动，1未启动）';
comment on column SYSTEM_TABLE.IS_MASTER
  is '主控系统标识 （1主控系统  2子系统）';
alter table SYSTEM_TABLE
  add constraint PRIMARYSYSTEM_TABLE1 primary key (SYSTEM_ID);

prompt
prompt Creating table TABLEDBOPERATIONRPT
prompt ==================================
prompt
create table TABLEDBOPERATIONRPT
(
  LOGID        NUMBER not null,
  USERNAME     VARCHAR2(50),
  TIME         DATE,
  OBJTABLE     VARCHAR2(50),
  OBJID        NUMBER,
  ACTION       VARCHAR2(50),
  SQLCONDITION CLOB
)
;
alter table TABLEDBOPERATIONRPT
  add constraint PRIMARYTABLEDBOPERATIONRPT1 primary key (LOGID);

prompt
prompt Creating table TABLEDEPARTMENT
prompt ==============================
prompt
create table TABLEDEPARTMENT
(
  DEPTID     NUMBER not null,
  DEPTNAME   VARCHAR2(50),
  UPPERLAYER NUMBER,
  DEPTSTATE  CHAR(1)
)
;
comment on column TABLEDEPARTMENT.DEPTSTATE
  is '0:有效  1：无效';
alter table TABLEDEPARTMENT
  add constraint PRIMARYTABLEDEPARTMENT1 primary key (DEPTID);

prompt
prompt Creating table TABLELOGINRPT
prompt ============================
prompt
create table TABLELOGINRPT
(
  USERNAME VARCHAR2(50),
  LOGID    NUMBER not null,
  IP       VARCHAR2(16),
  TIME     DATE,
  ACTION   VARCHAR2(10),
  STATUS   VARCHAR2(20)
)
;
alter table TABLELOGINRPT
  add constraint PRIMARYTABLELOGINRPT1 primary key (LOGID);

prompt
prompt Creating table TABLEUSERDEPARTMENT
prompt ==================================
prompt
create table TABLEUSERDEPARTMENT
(
  DEPTID NUMBER,
  USERID NUMBER,
  ID     NUMBER not null
)
;
alter table TABLEUSERDEPARTMENT
  add constraint PRIMARYTABLEUSERDEPARTMENT1 primary key (ID);

prompt
prompt Creating table TESTTRRGGER
prompt ==========================
prompt
create table TESTTRRGGER
(
  ID          NUMBER not null,
  DID         NUMBER,
  TEXT        VARCHAR2(500),
  TRRIGERNAME VARCHAR2(100)
)
;
comment on table TESTTRRGGER
  is '触发器测试信息';
comment on column TESTTRRGGER.DID
  is '标记记录';
comment on column TESTTRRGGER.TEXT
  is '描述信息';
comment on column TESTTRRGGER.TRRIGERNAME
  is '出发器名称';

prompt
prompt Creating table TROUBLE_STATE
prompt ============================
prompt
create table TROUBLE_STATE
(
  ID               NUMBER not null,
  TROUBLE_CODE     NUMBER not null,
  TROUBLE_INFO     VARCHAR2(200) not null,
  TROUBLE_DESCR    VARCHAR2(1000),
  SYSTEM_ID        NUMBER,
  CREATE_ID        NUMBER,
  CREATE_DATE      DATE,
  LAST_UPDATE_ID   NUMBER,
  LAST_UPDATE_DATE DATE,
  STATE            CHAR(1)
)
;
comment on table TROUBLE_STATE
  is '故障库,故障代码在同一个业务系统内不重复';
comment on column TROUBLE_STATE.TROUBLE_CODE
  is '故障代码';
comment on column TROUBLE_STATE.TROUBLE_INFO
  is '故障名称';
comment on column TROUBLE_STATE.TROUBLE_DESCR
  is '故障描述说明信息';
comment on column TROUBLE_STATE.SYSTEM_ID
  is '系统id';
comment on column TROUBLE_STATE.CREATE_ID
  is '创建者';
comment on column TROUBLE_STATE.CREATE_DATE
  is '创建时间';
comment on column TROUBLE_STATE.LAST_UPDATE_ID
  is '修改者';
comment on column TROUBLE_STATE.LAST_UPDATE_DATE
  is '修改时间';
comment on column TROUBLE_STATE.STATE
  is '状态 0: 有效 1:无效';
alter table TROUBLE_STATE
  add constraint PK_TROUBLE_STATE primary key (ID);

prompt
prompt Creating table TYPE_TABLE
prompt =========================
prompt
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

prompt
prompt Creating table XT_JS_JBXX
prompt =========================
prompt
create table XT_JS_JBXX
(
  JSMC  VARCHAR2(50),
  JSBH  NUMBER not null,
  ZXBZ  VARCHAR2(1),
  JSMS  VARCHAR2(200),
  CTIME DATE,
  TYPE  NUMBER
)
;
alter table XT_JS_JBXX
  add constraint PRIMARYXT_JS_JBXX1 primary key (JSBH);



prompt
prompt Creating table XT_JS_MK_INDEX
prompt =============================
prompt
create table XT_JS_MK_INDEX
(
  ID    NUMBER not null,
  MKBH  NUMBER,
  JSBH  VARCHAR2(50),
  CTIME DATE
)
;
alter table XT_JS_MK_INDEX
  add constraint PRIMARYXT_JS_MK_INDEX1 primary key (ID);


prompt
prompt Creating table XT_MK_JBXX
prompt =========================
prompt
create table XT_MK_JBXX
(
  ID        NUMBER not null,
  PID       NUMBER,
  MKBH      VARCHAR2(50),
  MKMC      VARCHAR2(50),
  MKMS      VARCHAR2(200),
  MKURL     VARCHAR2(200),
  MKTB      VARCHAR2(200),
  ZXBZ      VARCHAR2(1),
  CTIME     DATE,
  ICONIMAGE VARCHAR2(200),
  HANDLER   VARCHAR2(200),
  MKTYPE    NUMBER,
  SHOWLEVEL NUMBER,
  SHOWORDER NUMBER,
  SHOWAREA  NUMBER
)
;
comment on column XT_MK_JBXX.SHOWLEVEL
  is '菜单级别';
comment on column XT_MK_JBXX.SHOWORDER
  is '显示序号';
comment on column XT_MK_JBXX.SHOWAREA
  is '0:主控和子控系统全显示；1:主控系统显示；2：子控系统显示';
alter table XT_MK_JBXX
  add constraint PRIMARYXT_MK_JBXX1 primary key (ID);

prompt
prompt Creating table XT_YH_JBXX
prompt =========================
prompt
create table XT_YH_JBXX
(
  YHBH            VARCHAR2(50),
  YHMM            VARCHAR2(50),
  YHMC            VARCHAR2(50),
  GCDBH           VARCHAR2(50),
  YHBBH           VARCHAR2(50),
  DH              VARCHAR2(50),
  FJHM            VARCHAR2(50),
  ISBZ            VARCHAR2(1),
  ZXBZ            VARCHAR2(1),
  CTIME           DATE,
  YHID            NUMBER not null,
  RIGTHMENUITEMS  VARCHAR2(200),
  BGCOLOR         VARCHAR2(50),
  EMAIL           VARCHAR2(256),
  PWDSTATE        CHAR(1) default '0',
  IS_RECEIVEEMAIL VARCHAR2(2)
)
;
comment on column XT_YH_JBXX.PWDSTATE
  is '密码状态:0密码初始状态不可用;1密码已修改可用';
comment on column XT_YH_JBXX.IS_RECEIVEEMAIL
  is '为0时，接收邮件，为1时不接收';
alter table XT_YH_JBXX
  add constraint PRIMARYXT_YH_JBXX1 primary key (YHID);

prompt
prompt Creating table XT_YH_JS_INDEX
prompt =============================
prompt
create table XT_YH_JS_INDEX
(
  ID    NUMBER not null,
  YHBH  VARCHAR2(50),
  JSBH  VARCHAR2(50),
  CTIME DATE,
  TYPE  NUMBER,
  YHID  NUMBER
)
;
alter table XT_YH_JS_INDEX
  add constraint PRIMARYXT_YH_JS_INDEX1 primary key (ID);

prompt
prompt Creating table DICTIONARY_TABLE
prompt ===============================
prompt
create table DICTIONARY_TABLE
(
  ID         NUMBER not null,
  TYPE_NMAE  VARCHAR2(64),
  TYPE_DESC  VARCHAR2(256),
  TYPE_STATE NUMBER,
  TYPE_VALUE NUMBER,
  TYPE_MARK  VARCHAR2(16)
)
;
comment on table DICTIONARY_TABLE
  is '基本数据字典表，定义字典类别';
comment on column DICTIONARY_TABLE.TYPE_VALUE
  is '值';
comment on column DICTIONARY_TABLE.TYPE_MARK
  is '类别标识（预留）';
alter table DICTIONARY_TABLE
  add constraint PRIMARYDICTIONARY_TABLE1 primary key (ID);
  
prompt
prompt Creating table IMG_URL
prompt ======================
prompt
create table IMG_URL
(
  ID  NUMBER not null,
  URL VARCHAR2(255)
)
;
comment on column IMG_URL.URL
  is '图片url';
alter table IMG_URL
  add constraint PK_IMG_URL primary key (ID);

prompt
prompt Creating table OID_DICTIONARY
prompt =============================
prompt
create table OID_DICTIONARY
(
  ID  NUMBER not null,
  OID VARCHAR2(200) not null,
  DSC VARCHAR2(200) not null
)
;
alter table OID_DICTIONARY
  add constraint PRIMARYOID_TABLE primary key (ID);


prompt
prompt Creating table TABLE_GUIDE
prompt ==========================
prompt
create table TABLE_GUIDE
(
  ID         NUMBER not null,
  USER_ID    NUMBER not null,
  GUIDE_ID   NUMBER not null,
  GUIDE_NAME VARCHAR2(20),
  SYSTEM_ID  NUMBER
)
;
comment on table TABLE_GUIDE
  is '设置向导记录用户步骤表';
alter table TABLE_GUIDE
  add constraint PK_GUIDE primary key (ID);

prompt
prompt Creating table XT_JS_MK_GN_INDEX
prompt ================================
prompt
create table XT_JS_MK_GN_INDEX
(
  ID    NUMBER not null,
  MKBH  VARCHAR2(50),
  JSBH  VARCHAR2(50),
  GNBH  VARCHAR2(50),
  CTIME DATE
)
;
alter table XT_JS_MK_GN_INDEX
  add constraint PRIMARYXT_JS_MK_GN_INDEX1 primary key (ID);

prompt
prompt Creating table XT_MK_GN_JBXX
prompt ============================
prompt
create table XT_MK_GN_JBXX
(
  GNBH  NUMBER not null,
  MKBH  VARCHAR2(50),
  GNMC  VARCHAR2(50),
  GNMS  VARCHAR2(200),
  GNURL VARCHAR2(200),
  ZXBZ  VARCHAR2(1),
  CTIME DATE
)
;
alter table XT_MK_GN_JBXX
  add constraint PRIMARYXT_MK_GN_JBXX1 primary key (GNBH);

prompt
prompt Creating table PROCEDURE_LOG
prompt ============================
prompt
create table PROCEDURE_LOG
(
  ID       NUMBER not null,
  PRO_NAME VARCHAR2(100),
  PRO_SQL  VARCHAR2(1000),
  ER_INFO  VARCHAR2(1000)
)
;
comment on table PROCEDURE_LOG
  is '存储过程异常日志信息';

prompt
prompt Creating table DETECTION_INFO
prompt =============================
prompt
create table DETECTION_INFO
(
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER,
  CHECK_WAY                CHAR(1),
  DETECTION_STATE_INFO     VARCHAR2(4000),
  PERFORMACE_DATA          VARCHAR2(4000),
  CURRENT_TIMES            NUMBER,
  START_TIME               DATE,
  WAIT_TIME                NUMBER,
  DELAY_TIME               NUMBER,
  NEXT_CHECK_TIME          DATE,
  OFF_LINE                 DATE,
  POLICE_LEVEL             NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DETECTIONED_STATE        VARCHAR2(2),
  NODE_IP                  VARCHAR2(64),
  STATUS_CHANGE_TIME       DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  SEQ_ID                   NUMBER,
  POLICE_EMERGENT          NUMBER default 1,
  INSERT_DB_TIME           DATE default sysdate
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
comment on column DETECTION_INFO.DETECTION_SET_INFO_ID
  is '监测设置id，外键';
comment on column DETECTION_INFO.CHECK_WAY
  is '监测方式不能为空，可选[0/1]0主动、1被动（设置为主动可能本记录为被动）';
comment on column DETECTION_INFO.DETECTION_STATE_INFO
  is '状态信息';
comment on column DETECTION_INFO.PERFORMACE_DATA
  is '性能数据';
comment on column DETECTION_INFO.CURRENT_TIMES
  is '当前尝试次数';
comment on column DETECTION_INFO.START_TIME
  is '开运时间';
comment on column DETECTION_INFO.WAIT_TIME
  is '检测等待时间单位秒';
comment on column DETECTION_INFO.DELAY_TIME
  is '检测时延单位秒';
comment on column DETECTION_INFO.NEXT_CHECK_TIME
  is '下一次计划主动式检测时间';
comment on column DETECTION_INFO.OFF_LINE
  is '计划宕机时间';
comment on column DETECTION_INFO.POLICE_LEVEL
  is '预警级别';
comment on column DETECTION_INFO.DATA_CHECK_TIME
  is '获取监测数据时间';
comment on column DETECTION_INFO.DATA_ARRIVE_TIME
  is '数据入库时间';
comment on column DETECTION_INFO.DETECTIONED_STATE
  is '被监控状态是否正常：-1执行不成功；0不正常；1正常';
comment on column DETECTION_INFO.NODE_IP
  is '主机ip，标识主机位置';
comment on column DETECTION_INFO.STATUS_CHANGE_TIME
  is '监控状态最后一次变化时间';
comment on column DETECTION_INFO.DATA_CHECK_TIME_DIGITAL
  is '获取监测数据时间 数字类型';
comment on column DETECTION_INFO.DATA_ARRIVE_TIME_DIGITAL
  is '数据入库时间 数字类型';
comment on column DETECTION_INFO.SEQ_ID
  is '物理节点唯一标识';
comment on column DETECTION_INFO.POLICE_EMERGENT
  is '告警是否紧急 0：紧急  1：非紧急';
alter table DETECTION_INFO
  add primary key (ID);
alter table DETECTION_INFO
  add foreign key (DETECTION_SET_INFO_ID)
  references DETECTION_SET_INFO (ID);
create index DETECTION_INFO_DATA_CHECK_TIME on DETECTION_INFO (DATA_CHECK_TIME) local;
create index INDEX_DI_SEQ_ID on DETECTION_INFO (SEQ_ID) local;
create index INDEX_DI_SET_ID on DETECTION_INFO (DETECTION_SET_INFO_ID) local;


prompt
prompt Creating table DELECT_INFO_NMSC
prompt ===============================
prompt
create table DELECT_INFO_NMSC
(
  DETECTION_INFO_ID        NUMBER not null,
  SEND_INFO                VARCHAR2(100),
  RETURN_INFO              VARCHAR2(100),
  IS_IDENTICAL             NUMBER,
  SEND_TIME                DATE,
  RETURN_TIME              DATE,
  DELAY_TIME               NUMBER,
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
alter table DELECT_INFO_NMSC
  add primary key (ID);
create index DELECT_INFO_NMSC_1 on DELECT_INFO_NMSC (DATA_CHECK_TIME) local;
create index INDEX_DET_NMSC_SEQ_ID on DELECT_INFO_NMSC (SEQ_ID) local;
create index INDEX_DET_NMSC_SET_ID on DELECT_INFO_NMSC (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DETECTION_INFO_WARNING
prompt =====================================
prompt
create table DETECTION_INFO_WARNING
(
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER,
  CHECK_WAY                CHAR(1),
  DETECTION_STATE_INFO     VARCHAR2(4000),
  PERFORMACE_DATA          VARCHAR2(4000),
  CURRENT_TIMES            NUMBER,
  START_TIME               DATE,
  WAIT_TIME                NUMBER,
  DELAY_TIME               NUMBER,
  NEXT_CHECK_TIME          DATE,
  OFF_LINE                 DATE,
  POLICE_LEVEL             NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  NOTICE_FLAG              CHAR(1),
  DETECTIONED_STATE        VARCHAR2(2),
  NOTICE_INFO              VARCHAR2(500),
  NODE_IP                  VARCHAR2(64),
  STATUS_CHANGE_TIME       DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  SEQ_ID                   NUMBER,
  DETECTION_INFO_ID        NUMBER,
  VALID                    NUMBER default 1,
  POLICE_EMERGENT          NUMBER default 1
)
partition by range (DATA_CHECK_TIME)
(
   partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
comment on table DETECTION_INFO_WARNING
  is '监控数据表(需警告数据)';
comment on column DETECTION_INFO_WARNING.DETECTION_SET_INFO_ID
  is '监测设置id，外键';
comment on column DETECTION_INFO_WARNING.CHECK_WAY
  is '监测方式不能为空，可选[0/1]0主动、1被动（设置为主动可能本记录为被动）';
comment on column DETECTION_INFO_WARNING.DETECTION_STATE_INFO
  is '状态信息';
comment on column DETECTION_INFO_WARNING.PERFORMACE_DATA
  is '性能数据';
comment on column DETECTION_INFO_WARNING.CURRENT_TIMES
  is '当前尝试次数';
comment on column DETECTION_INFO_WARNING.START_TIME
  is '开机时间（开运时间）';
comment on column DETECTION_INFO_WARNING.WAIT_TIME
  is '检测等待时间单位秒';
comment on column DETECTION_INFO_WARNING.DELAY_TIME
  is '检测时延单位秒';
comment on column DETECTION_INFO_WARNING.NEXT_CHECK_TIME
  is '下一次计划主动式检测时间';
comment on column DETECTION_INFO_WARNING.OFF_LINE
  is '计划宕机时间';
comment on column DETECTION_INFO_WARNING.POLICE_LEVEL
  is '预警级别';
comment on column DETECTION_INFO_WARNING.DATA_CHECK_TIME
  is '获取监测数据时间';
comment on column DETECTION_INFO_WARNING.DATA_ARRIVE_TIME
  is '数据入库时间';
comment on column DETECTION_INFO_WARNING.NOTICE_FLAG
  is '是否已发通知:0未发；1已发';
comment on column DETECTION_INFO_WARNING.DETECTIONED_STATE
  is '被监控状态是否正常：0不正常；1正常';
comment on column DETECTION_INFO_WARNING.NOTICE_INFO
  is '警告信息';
comment on column DETECTION_INFO_WARNING.NODE_IP
  is '主机ip，标识主机位置';
comment on column DETECTION_INFO_WARNING.STATUS_CHANGE_TIME
  is '监控状态最后一次变化时间';
comment on column DETECTION_INFO_WARNING.DATA_CHECK_TIME_DIGITAL
  is '获取监测数据时间 数字类型';
comment on column DETECTION_INFO_WARNING.DATA_ARRIVE_TIME_DIGITAL
  is '数据入库时间 数字类型';
comment on column DETECTION_INFO_WARNING.DETECTION_INFO_ID
  is 'detection_info表主键';
comment on column DETECTION_INFO_WARNING.VALID
  is '告警数据是否有效，1有效，0无效，默认有效';
comment on column DETECTION_INFO_WARNING.POLICE_EMERGENT
  is '告警是否紧急 0：紧急  1：非紧急';
alter table DETECTION_INFO_WARNING
  add primary key (ID);
create index DETECTION_INFO_WARNING_CT on DETECTION_INFO_WARNING (DATA_CHECK_TIME) local;
create index INDEX_DIW_SEQ_ID on DETECTION_INFO_WARNING (SEQ_ID) local;
create index INDEX_DIW_SET_ID on DETECTION_INFO_WARNING (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DETECT_INFO_CPU
prompt ==============================
prompt
create table DETECT_INFO_CPU
(
  DETECTION_INFO_ID        NUMBER not null,
  USER_USED_CPU_PERC       NUMBER,
  SYS_USED_CPU_PERC        NUMBER,
  WAIT_CPU_PERC            NUMBER,
  NICE_PERC                NUMBER,
  FREE_CPU_PERC            NUMBER,
  TOTAL_USED_PERC          NUMBER,
  CPU_MHZ                  NUMBER,
  CPU_NAME                 VARCHAR2(100),
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
alter table DETECT_INFO_CPU
  add primary key (ID);
create index DETECT_INFO_CPU_1 on DETECT_INFO_CPU (DATA_CHECK_TIME) local;
create index DETECT_INFO_CPU_2 on DETECT_INFO_CPU (USER_USED_CPU_PERC) local;
create index DETECT_INFO_CPU_3 on DETECT_INFO_CPU (SYS_USED_CPU_PERC) local;
create index DETECT_INFO_CPU_4 on DETECT_INFO_CPU (WAIT_CPU_PERC) local;
create index DETECT_INFO_CPU_5 on DETECT_INFO_CPU (NICE_PERC) local;
create index DETECT_INFO_CPU_6 on DETECT_INFO_CPU (FREE_CPU_PERC) local;
create index DETECT_INFO_CPU_7 on DETECT_INFO_CPU (TOTAL_USED_PERC) local;
create index INDEX_DET_CPU_SEQ_ID on DETECT_INFO_CPU (SEQ_ID) local;
create index INDEX_DET_CPU_SET_ID on DETECT_INFO_CPU (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DETECT_INFO_DISK
prompt ===============================
prompt
create table DETECT_INFO_DISK
(
  DETECTION_INFO_ID        NUMBER not null,
  DISK_RANGE               VARCHAR2(50),
  TOTAL_DISK_SIZE          NUMBER,
  FREE_DISK_SIZE           NUMBER,
  USED_DISK_PERC           NUMBER,
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  DISK_ISWRITE             NUMBER,
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER
)
partition by range (DATA_CHECK_TIME)
(
   partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
alter table DETECT_INFO_DISK
  add primary key (ID);
create index DETECT_INFO_DISK_1 on DETECT_INFO_DISK (DATA_CHECK_TIME) local;
create index DETECT_INFO_DISK_2 on DETECT_INFO_DISK (FREE_DISK_SIZE) local;
create index DETECT_INFO_DISK_3 on DETECT_INFO_DISK (USED_DISK_PERC) local;
create index INDEX_DET_DISK_SEQ_ID on DETECT_INFO_DISK (SEQ_ID) local;
create index INDEX_DET_DISK_SET_ID on DETECT_INFO_DISK (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DETECT_INFO_MEMORY
prompt =================================
prompt
create table DETECT_INFO_MEMORY
(
  DETECTION_INFO_ID         NUMBER not null,
  FREE_SPACE_INPAGING_FILES NUMBER,
  SIZE_STOREDINPAGING_FILES NUMBER,
  TOTAL_MEMORY_SIZE         NUMBER,
  USED_MEMORY_SIZE          NUMBER,
  FREE_MEMORY_SIZE          NUMBER,
  USED_MEMORY_PERC          NUMBER,
  DETECTIONED_STATE         VARCHAR2(2),
  SEQ_ID                    NUMBER,
  DATA_CHECK_TIME           DATE,
  DATA_ARRIVE_TIME          DATE,
  DATA_CHECK_TIME_DIGITAL   NUMBER,
  DATA_ARRIVE_TIME_DIGITAL  NUMBER,
  ID                        NUMBER not null,
  DETECTION_SET_INFO_ID     NUMBER
)
partition by range (DATA_CHECK_TIME)
(
   partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
alter table DETECT_INFO_MEMORY
  add primary key (ID);
create index DETECT_INFO_MEMORY_1 on DETECT_INFO_MEMORY (DATA_CHECK_TIME) local;
create index DETECT_INFO_MEMORY_2 on DETECT_INFO_MEMORY (FREE_SPACE_INPAGING_FILES) local;
create index DETECT_INFO_MEMORY_3 on DETECT_INFO_MEMORY (USED_MEMORY_PERC) local;
create index INDEX_DET_MEM_SEQ_ID on DETECT_INFO_MEMORY (SEQ_ID) local;
create index INDEX_DET_MEM_SET_ID on DETECT_INFO_MEMORY (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DETECT_INFO_NETDATA
prompt ==================================
prompt
create table DETECT_INFO_NETDATA
(
  DETECTION_INFO_ID        NUMBER not null,
  RX_PACKETS               NUMBER,
  TX_PACKETS               NUMBER,
  RX_BYTES                 NUMBER,
  TX_BYTES                 NUMBER,
  RX_ERRORS                NUMBER,
  TX_ERRORS                NUMBER,
  RX_DROPPED               NUMBER,
  TX_DROPPED               NUMBER,
  SPEED                    NUMBER,
  RX_BPS                   NUMBER,
  TX_BPS                   NUMBER,
  RX_PPS                   NUMBER,
  TX_PPS                   NUMBER,
  NAME                     VARCHAR2(200),
  RX_ERRORS_PERC           NUMBER,
  TX_ERRORS_PERC           NUMBER,
  RX_DROP_PERC             NUMBER,
  TX_DROP_PERC             NUMBER,
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  ID                       NUMBER,
  DETECTION_SET_INFO_ID    NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
create index DETECT_INFO_NETDATA_1 on DETECT_INFO_NETDATA (DATA_CHECK_TIME) local;
create index DETECT_INFO_NETDATA_2 on DETECT_INFO_NETDATA (RX_PACKETS) local;
create index DETECT_INFO_NETDATA_3 on DETECT_INFO_NETDATA (TX_PACKETS) local;
create index DETECT_INFO_NETDATA_4 on DETECT_INFO_NETDATA (RX_BYTES) local;
create index DETECT_INFO_NETDATA_5 on DETECT_INFO_NETDATA (TX_BYTES) local;
create index DETECT_INFO_NETDATA_6 on DETECT_INFO_NETDATA (RX_ERRORS) local;
create index DETECT_INFO_NETDATA_7 on DETECT_INFO_NETDATA (TX_ERRORS) local;
create index DETECT_INFO_NETDATA_8 on DETECT_INFO_NETDATA (RX_DROPPED) local;
create index DETECT_INFO_NETDATA_9 on DETECT_INFO_NETDATA (TX_DROPPED) local;
create index INDEX_DET_NETDATA_SEQ_ID on DETECT_INFO_NETDATA (SEQ_ID) local;
create index INDEX_DET_NETDATA_SET_ID on DETECT_INFO_NETDATA (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DETECT_INFO_PING
prompt ===============================
prompt
create table DETECT_INFO_PING
(
  DETECTION_INFO_ID        NUMBER not null,
  PACKETS_SEND             NUMBER,
  PACKETS_RECEIVED         NUMBER,
  PACKETS_LOST             NUMBER,
  PACKETS_LOST_RATE        NUMBER,
  TIME_CONSUMING_MIN       NUMBER,
  TIME_CONSUMING_MAX       NUMBER,
  TIME_CONSUMING_AVER      NUMBER,
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
alter table DETECT_INFO_PING
  add primary key (ID);
create index DETECT_INFO_PING_1 on DETECT_INFO_PING (DATA_CHECK_TIME) local;
create index DETECT_INFO_PING_2 on DETECT_INFO_PING (PACKETS_LOST_RATE) local;
create index DETECT_INFO_PING_3 on DETECT_INFO_PING (TIME_CONSUMING_AVER) local;

prompt
prompt Creating table DETECT_INFO_PROCESS
prompt ==================================
prompt
create table DETECT_INFO_PROCESS
(
  DETECTION_INFO_ID        NUMBER not null,
  CPU_USED_PERC            NUMBER,
  MEM_USED_PERC            NUMBER,
  PRO_START_TIME           DATE,
  PROC_STATE               VARCHAR2(2),
  PROC_PRIORITY            NUMBER,
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
alter table DETECT_INFO_PROCESS
  add primary key (ID);
create index DETECT_INFO_PROCESS_1 on DETECT_INFO_PROCESS (DATA_CHECK_TIME) local;
create index DETECT_INFO_PROCESS_2 on DETECT_INFO_PROCESS (CPU_USED_PERC) local;
create index DETECT_INFO_PROCESS_3 on DETECT_INFO_PROCESS (MEM_USED_PERC) local;
create index INDEX_DET_PROCESS_SEQ_ID on DETECT_INFO_PROCESS (SEQ_ID) local;
create index INDEX_DET_PROCESS_SET_ID on DETECT_INFO_PROCESS (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DETECT_INFO_SNMP_TRAP
prompt ====================================
prompt
create table DETECT_INFO_SNMP_TRAP
(
  DETECTION_INFO_ID        NUMBER not null,
  AGENT_SEND_IP            VARCHAR2(20),
  PDU_AGENT_IP             VARCHAR2(20),
  RECEIVER_TIME            NUMBER,
  TRAP_VERSION             NUMBER,
  GENERIC_TYPE             NUMBER,
  SPECIFIC_TYPE            NUMBER,
  TRAP_NAME                VARCHAR2(200),
  TRAP_OID                 VARCHAR2(200),
  TRAP_PDU_OIDS            VARCHAR2(2000),
  TRAP_PDU_OID_V           VARCHAR2(2000),
  ORIGINAL_PDU             VARCHAR2(1000),
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  DETECTION_SET_INFO_ID    NUMBER,
  ID                       NUMBER not null
)
;
alter table DETECT_INFO_SNMP_TRAP
  add primary key (ID);

prompt
prompt Creating table DETECT_INFO_SYSTEM_DATE
prompt ======================================
prompt
create table DETECT_INFO_SYSTEM_DATE
(
  DETECTION_INFO_ID        NUMBER not null,
  SERVICE_DATE             DATE,
  DETECT_DATE              DATE,
  TIME_DELAY               NUMBER,
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
alter table DETECT_INFO_SYSTEM_DATE
  add primary key (ID);
create index DETECT_INFO_SYSTEM_DATE_1 on DETECT_INFO_SYSTEM_DATE (DATA_CHECK_TIME) local;


prompt
prompt Creating table DI_DPBOARDSTATUSENTRY
prompt ====================================
prompt
create table DI_DPBOARDSTATUSENTRY
(
  ID                       NUMBER not null,
  DETECTION_INFO_ID        NUMBER not null,
  DPBOARDTEMPERATURE       NUMBER,
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DETECTION_SET_INFO_ID    NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
alter table DI_DPBOARDSTATUSENTRY
  add primary key (ID);
create index DI_DPBOARDSTATUSENTRY_1 on DI_DPBOARDSTATUSENTRY (DATA_CHECK_TIME) local;
create index DI_DPBOARDSTATUSENTRY_2 on DI_DPBOARDSTATUSENTRY (SEQ_ID) local;
create index DI_DPBOARDSTATUSENTRY_3 on DI_DPBOARDSTATUSENTRY (DPBOARDTEMPERATURE) local;
create index INDEX_DI_DPBORADL_SET_ID on DI_DPBOARDSTATUSENTRY (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DI_DPSLOTENTRY
prompt =============================
prompt
create table DI_DPSLOTENTRY
(
  ID                       NUMBER not null,
  DETECTION_INFO_ID        NUMBER not null,
  DPSLOTINDEX              NUMBER,
  DPSLOTTYPE               NUMBER,
  DPSLOTDESC               VARCHAR2(400),
  DPSLOTPORTNUM            NUMBER,
  DPSLOTSTATUS             NUMBER,
  DPSLOTISMAIN             NUMBER,
  DPSLOTRUNTIMES           VARCHAR2(400),
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DETECTION_SET_INFO_ID    NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
alter table DI_DPSLOTENTRY
  add primary key (ID);
create index DI_DPSLOTENTRY_1 on DI_DPSLOTENTRY (DATA_CHECK_TIME) local;
create index DI_DPSLOTENTRY_2 on DI_DPSLOTENTRY (SEQ_ID) local;
create index DI_DPSLOTENTRY_3 on DI_DPSLOTENTRY (DPSLOTSTATUS) local;
create index INDEX_DI_DPSLOT_SET_ID on DI_DPSLOTENTRY (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DI_DPSYSTEMFANENTRY
prompt ==================================
prompt
create table DI_DPSYSTEMFANENTRY
(
  DETECTION_INFO_ID        NUMBER not null,
  DPSYSTEMFANNO            NUMBER,
  DPSYSTEMFANSTAT          VARCHAR2(400),
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
comment on column DI_DPSYSTEMFANENTRY.DPSYSTEMFANSTAT
  is 'normal, abnormal, offline';
alter table DI_DPSYSTEMFANENTRY
  add primary key (ID);
create index DI_DPSYSTEMFANENTRY_1 on DI_DPSYSTEMFANENTRY (DATA_CHECK_TIME) local;
create index DI_DPSYSTEMFANENTRY_2 on DI_DPSYSTEMFANENTRY (SEQ_ID) local;
create index INDEX_DI_DSYSFAN_SET_ID on DI_DPSYSTEMFANENTRY (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DI_DPSYSTEMPOWERENTRY
prompt ====================================
prompt
create table DI_DPSYSTEMPOWERENTRY
(
  DETECTION_INFO_ID        NUMBER not null,
  DPSYSTEMPOWERNO          NUMBER,
  DPSYSTEMPOWERSTAT        VARCHAR2(400),
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
alter table DI_DPSYSTEMPOWERENTRY
  add primary key (ID);
create index DI_DPSYSTEMPOWERENTRY_1 on DI_DPSYSTEMPOWERENTRY (DATA_CHECK_TIME) local;
create index DI_DPSYSTEMPOWERENTRY_2 on DI_DPSYSTEMPOWERENTRY (SEQ_ID) local;
create index INDEX_DI_DSYSPOWER_SET_ID on DI_DPSYSTEMPOWERENTRY (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DI_DPSYSTEMSTATUS
prompt ================================
prompt
create table DI_DPSYSTEMSTATUS
(
  DETECTION_INFO_ID        NUMBER not null,
  DPCPURATIO               NUMBER,
  DPCPURATIOPEAK           NUMBER,
  DPCPURATIOAVERAGE        NUMBER,
  DPCPUTEMPERATURE         NUMBER,
  DPMEMRATIO               NUMBER,
  DPMEMRATIOPEAK           NUMBER,
  DPMEMRATIOAVERAGE        NUMBER,
  DPMAINBOARDTEMPERATURE   NUMBER,
  DPSESSION                NUMBER,
  DPCPURATIO30S            NUMBER,
  DPCPURATIO5MIN           NUMBER,
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
alter table DI_DPSYSTEMSTATUS
  add primary key (ID);
create index DI_DPSYSTEMSTATUS_1 on DI_DPSYSTEMSTATUS (DATA_CHECK_TIME) local;
create index DI_DPSYSTEMSTATUS_2 on DI_DPSYSTEMSTATUS (SEQ_ID) local;
create index DI_DPSYSTEMSTATUS_3 on DI_DPSYSTEMSTATUS (DPMAINBOARDTEMPERATURE) local;
create index INDEX_DI_DSYSSTATUS_SET_ID on DI_DPSYSTEMSTATUS (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DI_IFXTABLE
prompt ==========================
prompt
create table DI_IFXTABLE
(
  DETECTION_INFO_ID        NUMBER not null,
  IFNAME                   VARCHAR2(25),
  INMULTICASTPKTS          NUMBER,
  INBROADCASTPKTS          NUMBER,
  OUTMULCASTPKTS           NUMBER,
  OUTBROCASTPKTS           NUMBER,
  IFHCINOCTETS             NUMBER,
  HCINUCASTPKTS            NUMBER,
  HCIMULCASTPKTS           NUMBER,
  HCIBROCASTPKTS           NUMBER,
  HCOUTOCTETS              NUMBER,
  HCOUCASTPKTS             NUMBER,
  HCOMULCASTPKTS           NUMBER,
  HCOBROCASTPKTS           NUMBER,
  LINKUPDOWNTRAPE          NUMBER,
  IFHIGHSPEED              NUMBER,
  PROMISCUOUSMODE          NUMBER,
  CONNECTORPRESEN          NUMBER,
  IFALIAS                  VARCHAR2(50),
  COUNTERDISCONTI          VARCHAR2(100),
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
alter table DI_IFXTABLE
  add primary key (ID);
create index DI_IFXTABLE_1 on DI_IFXTABLE (DATA_CHECK_TIME) local;
create index DI_IFXTABLE_2 on DI_IFXTABLE (SEQ_ID) local;
create index INDEX_DI_IFXTABLE_SET_ID on DI_IFXTABLE (DETECTION_SET_INFO_ID) local;


prompt
prompt Creating table DI_SWITCHPORT
prompt ============================
prompt
create table DI_SWITCHPORT
(
  DETECTION_INFO_ID        NUMBER not null,
  IFINDEX                  NUMBER,
  IFDESCR                  VARCHAR2(400),
  IFTYPE                   NUMBER,
  IFMTU                    NUMBER,
  IFSPEED                  NUMBER,
  IFPHYSADDRESS            VARCHAR2(400),
  IFADMINSTATUS            NUMBER,
  IFOPERSTATUS             NUMBER,
  IFLASTCHANGE             VARCHAR2(50),
  IFINOCTETS               NUMBER,
  IFINUCASTPKTS            NUMBER,
  IFINNUCASTPKTS           NUMBER,
  IFINDISCARDS             NUMBER,
  IFINERRORS               NUMBER,
  IFINUNKNOWNPROTOS        NUMBER,
  IFOUTOCTETS              NUMBER,
  IFOUTUCASTPKTS           NUMBER,
  IFOUTNUCASTPKTS          NUMBER,
  IFOUTDISCARDS            NUMBER,
  IFOUTERRORS              NUMBER,
  IFOUTQLEN                NUMBER,
  IFSPECIFIC               VARCHAR2(400),
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  INOCTETSSPEED            NUMBER,
  INERRORSSCALE            NUMBER,
  OUTOCTETSSPEED           NUMBER,
  OUTERRORSSCALE           NUMBER,
  IFINDISCARDSPERC         NUMBER,
  IFOUTDISCARDSPERC        NUMBER,
  INPKTSSPEED              NUMBER,
  OUTPKTSSPEED             NUMBER,
  IFINDISCARDS_VARY        NUMBER,
  IFOUTDISCARDS_VARY       NUMBER,
  IFINERRORS_VARY          NUMBER,
  IFOUTERRORS_VARY         NUMBER,
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER,
  IFINOCTETS_T1            NUMBER,
  IFINUCASTPKTS_T1         NUMBER,
  IFINNUCASTPKTS_T1        NUMBER,
  IFOUTOCTETS_T1           NUMBER,
  IFOUTUCASTPKTS_T1        NUMBER,
  IFOUTNUCASTPKTS_T1       NUMBER,
  IFHIGHSPEED              NUMBER,
  DATA_64_FLAG             NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
comment on table DI_SWITCHPORT
  is '记录接口的信息';
comment on column DI_SWITCHPORT.DETECTION_INFO_ID
  is '检测信息ID';
comment on column DI_SWITCHPORT.IFINDEX
  is '接口表惟一的索引项，索引值为1~ ifNumber范围';
comment on column DI_SWITCHPORT.IFDESCR
  is '接口的描述，制造商名，产品名和版本等';
comment on column DI_SWITCHPORT.IFTYPE
  is '接口的类型,用一个整数表示,表示物理层和数据链路层协议确定的接口类型';
comment on column DI_SWITCHPORT.IFMTU
  is '表示该接口上可以发送或接收的最大协议数据单元大小(位组数)';
comment on column DI_SWITCHPORT.IFSPEED
  is '指定一个接口的传输速率，单位为“位/秒”（bps）';
comment on column DI_SWITCHPORT.IFPHYSADDRESS
  is '接口的物理地址';
comment on column DI_SWITCHPORT.IFADMINSTATUS
  is ' 用于配置接口的管理状态，up(1) down(2) testing(3)';
comment on column DI_SWITCHPORT.IFOPERSTATUS
  is '提供一个接口的当前操作状态， up(1) down(2) testing(3)';
comment on column DI_SWITCHPORT.IFLASTCHANGE
  is ' 接口进入当前状态的时间';
comment on column DI_SWITCHPORT.IFINOCTETS
  is '接口收到的总字节数';
comment on column DI_SWITCHPORT.IFINUCASTPKTS
  is '单点发送到一种高层协议上的包的总数目';
comment on column DI_SWITCHPORT.IFINNUCASTPKTS
  is '发往高层协议的非单播包数（广播和多播）';
comment on column DI_SWITCHPORT.IFINDISCARDS
  is ' 接口丢弃的输入包数';
comment on column DI_SWITCHPORT.IFINERRORS
  is '由于错误导致接收的错误包数';
comment on column DI_SWITCHPORT.IFINUNKNOWNPROTOS
  is '由于未知或不支持的协议而被抛弃的输入包数';
comment on column DI_SWITCHPORT.IFOUTOCTETS
  is '接口发送的总字节数';
comment on column DI_SWITCHPORT.IFOUTUCASTPKTS
  is '高层协议请求传输的单播包数';
comment on column DI_SWITCHPORT.IFOUTNUCASTPKTS
  is '高层协议请求的非单播（广播和多播）包数';
comment on column DI_SWITCHPORT.IFOUTDISCARDS
  is '由于资源局限而导致丢弃的发出包的总数目';
comment on column DI_SWITCHPORT.IFOUTERRORS
  is '由于错误而导致丢弃的发出包的总数目';
comment on column DI_SWITCHPORT.IFOUTQLEN
  is '输出包队列中包的总数(输出队列长度)';
comment on column DI_SWITCHPORT.IFSPECIFIC
  is ' 指向MIB中特定介质的定义';
comment on column DI_SWITCHPORT.SEQ_ID
  is 'seq id';
comment on column DI_SWITCHPORT.DATA_CHECK_TIME
  is '检测时间';
comment on column DI_SWITCHPORT.DATA_ARRIVE_TIME
  is '数据入库时间';
comment on column DI_SWITCHPORT.DATA_CHECK_TIME_DIGITAL
  is '检测时间（毫秒）';
comment on column DI_SWITCHPORT.DATA_ARRIVE_TIME_DIGITAL
  is '数据入库时间（毫秒）';
comment on column DI_SWITCHPORT.IFINDISCARDS_VARY
  is '输入丢包数';
comment on column DI_SWITCHPORT.IFOUTDISCARDS_VARY
  is '输出丢包数';
comment on column DI_SWITCHPORT.IFINERRORS_VARY
  is '输入差错数';
comment on column DI_SWITCHPORT.IFOUTERRORS_VARY
  is '输出差错数';
comment on column DI_SWITCHPORT.IFHIGHSPEED
  is '端口带宽（Mbps）';
comment on column DI_SWITCHPORT.DATA_64_FLAG
  is '64位数据标识 0否 1是';
alter table DI_SWITCHPORT
  add primary key (ID);
create index DI_SWITCHPORT_1 on DI_SWITCHPORT (DATA_CHECK_TIME) local;
create index DI_SWITCHPORT_2 on DI_SWITCHPORT (IFSPEED) local;
create index DI_SWITCHPORT_3 on DI_SWITCHPORT (IFADMINSTATUS) local;
create index DI_SWITCHPORT_4 on DI_SWITCHPORT (IFOUTOCTETS) local;
create index INDEX_DISW_SEQ_ID on DI_SWITCHPORT (SEQ_ID) local;
create index INDEX_DISW_SET_ID on DI_SWITCHPORT (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DI_SYSTEM
prompt ========================
prompt
create table DI_SYSTEM
(
  DETECTION_INFO_ID        NUMBER not null,
  SYSDESCR                 VARCHAR2(400),
  SYSOBJECTID              VARCHAR2(400),
  SYSUPTIME                VARCHAR2(100),
  SYSCONTACT               VARCHAR2(400),
  SYSNAME                  VARCHAR2(400),
  SYSLOCATION              VARCHAR2(400),
  SYSSERVICES              NUMBER,
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
comment on column DI_SYSTEM.SEQ_ID
  is 'seq id';
alter table DI_SYSTEM
  add primary key (ID);
create index DI_SYSTEM_1 on DI_SYSTEM (DATA_CHECK_TIME) local;
create index INDEX_DI_SYSTEM_SET_ID on DI_SYSTEM (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DI_SYSTEMINFO
prompt ============================
prompt
create table DI_SYSTEMINFO
(
  DETECTION_INFO_ID        NUMBER not null,
  HOST_NAME                VARCHAR2(200),
  OPERATE_SYSTEM           VARCHAR2(200),
  CPU_CNT                  NUMBER,
  CPU_MHZ                  NUMBER,
  MEMORY_SIZE              NUMBER,
  SWAP_SIZE                NUMBER,
  DISK_SIZE                NUMBER,
  NET_CNT                  NUMBER,
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  ID                       NUMBER not null,
  DETECTION_SET_INFO_ID    NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
alter table DI_SYSTEMINFO
  add primary key (ID);
create index DI_SYSTEMINFO_1 on DI_SYSTEMINFO (DATA_CHECK_TIME) local;
create index INDEX_DI_SYSTEMINFO_SET_ID on DI_SYSTEMINFO (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DI_SYSTEMINFO_DISK
prompt =================================
prompt
create table DI_SYSTEMINFO_DISK
(
  DETECTION_INFO_ID        NUMBER not null,
  DISK_RANG                VARCHAR2(50),
  DISK_SIZE                NUMBER,
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  DETECTION_SET_INFO_ID    NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
comment on column DI_SYSTEMINFO_DISK.DISK_RANG
  is '盘符';
comment on column DI_SYSTEMINFO_DISK.DISK_SIZE
  is '大小';
create index INDEX_DI_SYSDISK_SET_ID on DI_SYSTEMINFO_DISK (DETECTION_SET_INFO_ID) local;

prompt
prompt Creating table DI_SYSTEMINFO_NET
prompt ================================
prompt
create table DI_SYSTEMINFO_NET
(
  DETECTION_INFO_ID        NUMBER not null,
  NET_NAME                 VARCHAR2(100),
  NET_STATE                VARCHAR2(50),
  NET_SPEED                NUMBER,
  NET_IP                   VARCHAR2(50),
  NET_SUBMASK              VARCHAR2(50),
  NET_GATEWAY              VARCHAR2(50),
  NET_MAC                  VARCHAR2(50),
  DETECTIONED_STATE        VARCHAR2(2),
  SEQ_ID                   NUMBER,
  DATA_CHECK_TIME          DATE,
  DATA_ARRIVE_TIME         DATE,
  DATA_CHECK_TIME_DIGITAL  NUMBER,
  DATA_ARRIVE_TIME_DIGITAL NUMBER,
  DETECTION_SET_INFO_ID    NUMBER
)
partition by range (DATA_CHECK_TIME)
(
  partition DI_W201529 values less than (TO_DATE(' 2015-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    tablespace DI_W201529
);
comment on column DI_SYSTEMINFO_NET.NET_NAME
  is '网卡名称';
comment on column DI_SYSTEMINFO_NET.NET_STATE
  is '网卡状态';
comment on column DI_SYSTEMINFO_NET.NET_SPEED
  is '网卡带宽（单位: MHz）';
comment on column DI_SYSTEMINFO_NET.NET_IP
  is 'IP';
comment on column DI_SYSTEMINFO_NET.NET_SUBMASK
  is '子网掩码';
comment on column DI_SYSTEMINFO_NET.NET_GATEWAY
  is '网关';
comment on column DI_SYSTEMINFO_NET.NET_MAC
  is 'MAC地址';
create index INDEX_DI_SYSNET_SET_ID on DI_SYSTEMINFO_NET (DETECTION_SET_INFO_ID) local;



spool off
