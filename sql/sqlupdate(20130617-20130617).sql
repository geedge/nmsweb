--菜单变更与新增
UPDATE xt_mk_jbxx t SET t.mkmc='特种监测' WHERE t.mkmc='网元监测';
--“数据展示”父菜单下新增子菜单：网元监测  url：/detection/monitorData.do?action=queryNE

--拓扑图SVG实现方式预置数据
--删除原数据
DELETE FROM nodegroup_position;
--底图
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 0, 0, 1, NULL, 'image', 0, 0, 1133, 755, 'red', 1, 'bgImg.png', 0, sysdate, NULL, sysdate,NULL );

--服务器
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 121, 0, 2, NULL, 'image', 822, 56, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 122, 0, 2, NULL, 'image', 822, 170, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 123, 0, 2, NULL, 'image', 822, 299, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 124, 0, 2, NULL, 'image', 822, 412, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 125, 0, 2, NULL, 'image', 904, 484, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 126, 0, 2, NULL, 'image', 822, 528, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 127, 0, 2, NULL, 'image', 906, 599, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 128, 0, 2, NULL, 'image', 822, 648, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );

--节点组
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 129, 0, 2, NULL, 'image', 578, 50, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 130, 0, 2, NULL, 'image', 580, 172, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 131, 0, 2, NULL, 'image', 580, 300, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 132, 0, 2, NULL, 'image', 580, 416, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 133, 0, 2, NULL, 'image', 432, 50, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 134, 0, 2, NULL, 'image', 432, 172, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 135, 0, 2, NULL, 'image', 432, 300, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 136, 0, 2, NULL, 'image', 432, 416, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 137, 0, 2, NULL, 'image', 432, 534, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 138, 0, 2, NULL, 'image', 432, 639, 25, 25, 'red', 1, 'green_bulb.png', 0, sysdate, NULL, sysdate,NULL );

--交换机
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 139, 0, 2, NULL, 'image', 702, 299, 25, 25, 'red', 1, 'red_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 140, 0, 2, NULL, 'image', 502, 48, 25, 25, 'red', 1, 'red_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 141, 0, 2, NULL, 'image', 506, 170, 25, 25, 'red', 1, 'red_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 142, 0, 2, NULL, 'image', 506, 297, 25, 25, 'red', 1, 'red_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 143, 0, 2, NULL, 'image', 506, 414, 25, 25, 'red', 1, 'red_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 144, 0, 2, NULL, 'image', 510, 633, 25, 25, 'red', 1, 'red_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 145, 0, 2, NULL, 'image', 360, 48, 25, 25, 'red', 1, 'red_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 146, 0, 2, NULL, 'image', 362, 232, 25, 25, 'red', 1, 'red_bulb.png', 0, sysdate, NULL, sysdate,NULL );
insert into NODEGROUP_POSITION (ID, SYSTEM_ID, GROUP_ID, PGROUP_ID, SHOW_LEVEL, SHOW_INDEX, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, SHOW_STATUS, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID)
values (seq_nodegroup_posITION.Nextval, 61, 147, 0, 2, NULL, 'image', 362, 472, 25, 25, 'red', 1, 'red_bulb.png', 0, sysdate, NULL, sysdate,NULL );





-- Create table
create table DEVICE_BOARDSOLT_BOARD
(
  ID                     NUMBER not null,
  DEVICE_BRAND_CODE      VARCHAR2(64),
  DEVICE_BOARD_SOLT_CODE VARCHAR2(64),
  DEVICE_BOARD_CODE      VARCHAR2(64),
  DEVICE_TYPE_CODE       VARCHAR2(64)
)
tablespace NMS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column DEVICE_BOARDSOLT_BOARD.DEVICE_BRAND_CODE
  is '品牌code';
comment on column DEVICE_BOARDSOLT_BOARD.DEVICE_BOARD_SOLT_CODE
  is '槽位code';
comment on column DEVICE_BOARDSOLT_BOARD.DEVICE_BOARD_CODE
  is '板卡code';
comment on column DEVICE_BOARDSOLT_BOARD.DEVICE_TYPE_CODE
  is '设备型号';
-- Create/Recreate primary, unique and foreign key constraints 
alter table DEVICE_BOARDSOLT_BOARD
  add constraint PK_DEVICE_BOARDSOLT_BOARD primary key (ID)
  using index 
  tablespace NMS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );



-- Create sequence 
create sequence seq_device_boardsolt_board
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;


---device_boardsolt_board 表预置数据 for 板卡槽位与子设备位置匹配
--ZTE ZXR10-T240G
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-1', 'ZXR10-T240G-BLANK', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-1', 'RS-T160G-2XGP-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-1', 'RS-T160G-4P48-12GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-1', 'RS-XG-4XGESFP+LE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-1', 'RS-XGTN3-4P192-8XGESFP+', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-1', 'RS-XGTN3-16MPOS12-12GESFP', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-1', 'RS-T160G-8P48-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-1', 'RS-XGTN3-8POS48-24GESFP', 'ZXR10-T240G');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-2', 'ZXR10-T240G-BLANK', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-2', 'RS-T160G-2XGP-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-2', 'RS-T160G-4P48-12GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-2', 'RS-XG-4XGESFP+LE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-2', 'RS-XGTN3-4P192-8XGESFP+', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-2', 'RS-XGTN3-16MPOS12-12GESFP', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-2', 'RS-T160G-8P48-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-2', 'RS-XGTN3-8POS48-24GESFP', 'ZXR10-T240G');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-3', 'ZXR10-T240G-BLANK', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-3', 'RS-T160G-2XGP-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-3', 'RS-T160G-4P48-12GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-3', 'RS-XG-4XGESFP+LE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-3', 'RS-XGTN3-4P192-8XGESFP+', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-3', 'RS-XGTN3-16MPOS12-12GESFP', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-3', 'RS-T160G-8P48-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-3', 'RS-XGTN3-8POS48-24GESFP', 'ZXR10-T240G');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-4', 'ZXR10-T240G-BLANK', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-4', 'RS-T160G-2XGP-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-4', 'RS-T160G-4P48-12GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-4', 'RS-XG-4XGESFP+LE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-4', 'RS-XGTN3-4P192-8XGESFP+', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-4', 'RS-XGTN3-16MPOS12-12GESFP', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-4', 'RS-T160G-8P48-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-4', 'RS-XGTN3-8POS48-24GESFP', 'ZXR10-T240G');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-5', 'ZXR10-T240G-BLANK', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-5', 'RS-T160G-2XGP-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-5', 'RS-T160G-4P48-12GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-5', 'RS-XG-4XGESFP+LE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-5', 'RS-XGTN3-4P192-8XGESFP+', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-5', 'RS-XGTN3-16MPOS12-12GESFP', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-5', 'RS-T160G-8P48-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-5', 'RS-XGTN3-8POS48-24GESFP', 'ZXR10-T240G');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-6', 'ZXR10-T240G-BLANK', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-6', 'RS-T160G-2XGP-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-6', 'RS-T160G-4P48-12GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-6', 'RS-XG-4XGESFP+LE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-6', 'RS-XGTN3-4P192-8XGESFP+', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-6', 'RS-XGTN3-16MPOS12-12GESFP', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-6', 'RS-T160G-8P48-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-6', 'RS-XGTN3-8POS48-24GESFP', 'ZXR10-T240G');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-7', 'ZXR10-T240G-BLANK', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-7', 'RS-T160G-2XGP-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-7', 'RS-T160G-4P48-12GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-7', 'RS-XG-4XGESFP+LE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-7', 'RS-XGTN3-4P192-8XGESFP+', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-7', 'RS-XGTN3-16MPOS12-12GESFP', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-7', 'RS-T160G-8P48-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-7', 'RS-XGTN3-8POS48-24GESFP', 'ZXR10-T240G');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-8', 'ZXR10-T240G-BLANK', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-8', 'RS-T160G-2XGP-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-8', 'RS-T160G-4P48-12GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-8', 'RS-XG-4XGESFP+LE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-8', 'RS-XGTN3-4P192-8XGESFP+', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-8', 'RS-XGTN3-16MPOS12-12GESFP', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-8', 'RS-T160G-8P48-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-8', 'RS-XGTN3-8POS48-24GESFP', 'ZXR10-T240G');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-9', 'ZXR10-T240G-BLANK', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-9', 'RS-T160G-2XGP-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-9', 'RS-T160G-4P48-12GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-9', 'RS-XG-4XGESFP+LE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-9', 'RS-XGTN3-4P192-8XGESFP+', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-9', 'RS-XGTN3-16MPOS12-12GESFP', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-9', 'RS-T160G-8P48-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-9', 'RS-XGTN3-8POS48-24GESFP', 'ZXR10-T240G');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-10', 'ZXR10-T240G-BLANK', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-10', 'RS-T160G-2XGP-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-10', 'RS-T160G-4P48-12GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-10', 'RS-XG-4XGESFP+LE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-10', 'RS-XGTN3-4P192-8XGESFP+', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-10', 'RS-XGTN3-16MPOS12-12GESFP', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-10', 'RS-T160G-8P48-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-10', 'RS-XGTN3-8POS48-24GESFP', 'ZXR10-T240G');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-11', 'ZXR10-T240G-BLANK', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-11', 'RS-T160G-2XGP-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-11', 'RS-T160G-4P48-12GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-11', 'RS-XG-4XGESFP+LE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-11', 'RS-XGTN3-4P192-8XGESFP+', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-11', 'RS-XGTN3-16MPOS12-12GESFP', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-11', 'RS-T160G-8P48-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-11', 'RS-XGTN3-8POS48-24GESFP', 'ZXR10-T240G');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-12', 'ZXR10-T240G-BLANK', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-12', 'RS-T160G-2XGP-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-12', 'RS-T160G-4P48-12GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-12', 'RS-XG-4XGESFP+LE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-12', 'RS-XGTN3-4P192-8XGESFP+', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-12', 'RS-XGTN3-16MPOS12-12GESFP', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-12', 'RS-T160G-8P48-24GE', 'ZXR10-T240G');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-12', 'RS-XGTN3-8POS48-24GESFP', 'ZXR10-T240G');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-13', 'RS-T240G-MCSII', 'ZXR10-T240G');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-T240G-14', 'RS-T240G-MCSII', 'ZXR10-T240G');

--ZTE  ZXR10-8912
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-1', 'RS-89-S2-48-GE-RJ', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-1', 'RS-89H2-24GE-SF', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-1', 'ZXR10-8912-BLANK', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-1', 'RS-89S2-4XGE-XFP', 'ZXR10-8912');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-2', 'RS-89-S2-48-GE-RJ', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-2', 'RS-89H2-24GE-SF', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-2', 'ZXR10-8912-BLANK', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-2', 'RS-89S2-4XGE-XFP', 'ZXR10-8912');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-3', 'RS-89-S2-48-GE-RJ', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-3', 'RS-89H2-24GE-SF', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-3', 'ZXR10-8912-BLANK', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-3', 'RS-89S2-4XGE-XFP', 'ZXR10-8912');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-4', 'RS-89-S2-48-GE-RJ', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-4', 'RS-89H2-24GE-SF', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-4', 'ZXR10-8912-BLANK', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-4', 'RS-89S2-4XGE-XFP', 'ZXR10-8912');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-5', 'RS-89-S2-48-GE-RJ', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-5', 'RS-89H2-24GE-SF', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-5', 'ZXR10-8912-BLANK', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-5', 'RS-89S2-4XGE-XFP', 'ZXR10-8912');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-6', 'RS-89-S2-48-GE-RJ', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-6', 'RS-89H2-24GE-SF', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-6', 'ZXR10-8912-BLANK', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-6', 'RS-89S2-4XGE-XFP', 'ZXR10-8912');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-7', 'RS-89-S2-48-GE-RJ', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-7', 'RS-89H2-24GE-SF', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-7', 'ZXR10-8912-BLANK', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-7', 'RS-89S2-4XGE-XFP', 'ZXR10-8912');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-8', 'RS-89-S2-48-GE-RJ', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-8', 'RS-89H2-24GE-SF', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-8', 'ZXR10-8912-BLANK', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-8', 'RS-89S2-4XGE-XFP', 'ZXR10-8912');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-9', 'RS-89-S2-48-GE-RJ', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-9', 'RS-89H2-24GE-SF', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-9', 'ZXR10-8912-BLANK', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-9', 'RS-89S2-4XGE-XFP', 'ZXR10-8912');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-10', 'RS-89-S2-48-GE-RJ', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-10', 'RS-89H2-24GE-SF', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-10', 'ZXR10-8912-BLANK', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-10', 'RS-89S2-4XGE-XFP', 'ZXR10-8912');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-11', 'RS-89-S2-48-GE-RJ', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-11', 'RS-89H2-24GE-SF', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-11', 'ZXR10-8912-BLANK', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-11', 'RS-89S2-4XGE-XFP', 'ZXR10-8912');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-12', 'RS-89-S2-48-GE-RJ', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-12', 'RS-89H2-24GE-SF', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-12', 'ZXR10-8912-BLANK', 'ZXR10-8912');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-12', 'RS-89S2-4XGE-XFP', 'ZXR10-8912');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-13', 'RS-8912-MSCII', 'ZXR10-8912');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'ZTE', 'ZXR10-8912-14', 'RS-8912-MSCII', 'ZXR10-8912');


--DPtech DPX8000-A12
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-One', '8XGEP-D', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-One', '8XGEP-D-BLANK', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-One', 'PF4XPS8XGES-E', 'DPX8000-A12');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Two', '8XGEP-D', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Two', '8XGEP-D-BLANK', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Two', 'PF4XPS8XGES-E', 'DPX8000-A12');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Three', '8XGEP-D', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Three', '8XGEP-D-BLANK', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Three', 'PF4XPS8XGES-E', 'DPX8000-A12');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Four', '8XGEP-D', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Four', '8XGEP-D-BLANK', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Four', 'PF4XPS8XGES-E', 'DPX8000-A12');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Five', '8XGEP-D', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Five', '8XGEP-D-BLANK', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Five', 'PF4XPS8XGES-E', 'DPX8000-A12');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Six', 'MPUA', 'DPX8000-A12');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Seven', 'MPUA', 'DPX8000-A12');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Eight', '8XGEP-D', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Eight', '8XGEP-D-BLANK', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Eight', 'PF4XPS8XGES-E', 'DPX8000-A12');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Nine', '8XGEP-D', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Nine', '8XGEP-D-BLANK', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Nine', 'PF4XPS8XGES-E', 'DPX8000-A12');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Ten', '8XGEP-D', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Ten', '8XGEP-D-BLANK', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Ten', 'PF4XPS8XGES-E', 'DPX8000-A12');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Eleven', '8XGEP-D', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Eleven', '8XGEP-D-BLANK', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Eleven', 'PF4XPS8XGES-E', 'DPX8000-A12');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Twelve', '8XGEP-D', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Twelve', '8XGEP-D-BLANK', 'DPX8000-A12');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'DPtech', 'DPX8000-A12-Twelve', 'PF4XPS8XGES-E', 'DPX8000-A12');
--

--H3C H3C-S12518
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-0', 'LST1MRPNC1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-1', 'LST1MRPNC1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-2', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-2', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-2', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-2', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-2', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-3', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-3', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-3', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-3', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-3', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-4', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-4', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-4', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-4', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-4', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-5', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-5', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-5', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-5', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-5', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-6', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-6', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-6', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-6', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-6', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-7', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-7', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-7', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-7', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-7', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-8', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-8', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-8', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-8', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-8', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-9', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-9', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-9', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-9', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-9', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-10', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-10', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-10', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-10', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-10', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-11', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-11', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-11', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-11', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-11', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-12', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-12', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-12', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-12', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-12', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-13', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-13', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-13', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-13', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-13', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-14', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-14', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-14', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-14', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-14', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-15', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-15', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-15', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-15', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-15', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-16', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-16', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-16', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-16', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-16', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-17', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-17', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-17', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-17', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-17', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-18', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-18', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-18', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-18', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-18', 'LST1XP16LEY1', 'H3C-S12518');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-19', '1000BASE-X-SFP', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-19', '10GBASE-R-SFP+', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-19', 'H3C-S12518-BLANK', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-19', 'LST1GP48LEY1', 'H3C-S12518');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'H3C', 'H3C-S12518-19', 'LST1XP16LEY1', 'H3C-S12518');

--HUAWEI HUAWEI-SSP3000
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-1', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-1', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-1', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-1', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-1', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-1', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-2', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-2', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-2', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-2', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-2', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-2', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-3', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-3', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-3', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-3', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-3', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-3', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-4', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-4', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-4', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-4', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-4', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-4', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-5', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-5', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-5', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-5', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-5', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-5', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-6', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-6', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-6', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-6', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-6', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-6', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-7', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-7', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-7', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-7', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-7', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-7', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-8', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-8', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-8', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-8', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-8', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-8', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-9', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-9', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-9', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-9', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-9', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-9', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-10', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-10', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-10', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-10', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-10', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-10', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-11', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-11', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-11', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-11', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-11', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-11', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-12', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-12', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-12', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-12', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-12', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-12', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-13', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-13', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-13', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-13', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-13', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-13', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-14', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-14', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-14', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-14', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-14', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-14', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-15', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-15', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-15', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-15', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-15', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-15', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-16', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-16', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-16', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-16', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-16', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-16', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-17', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-17', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-17', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-17', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-17', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-17', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-18', 'HUAWEI-SSP3000-BLANK', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-18', 'SX11E2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-18', 'SX11MPUB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-18', 'SX11P2XXD0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-18', 'SX11P8CFB0', 'HUAWEI-SSP3000');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-18', 'SX11P8UFD0', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-19', 'CONTROL19-22', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-20', 'CONTROL19-22', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-21', 'CONTROL19-22', 'HUAWEI-SSP3000');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-SSP3000-22', 'CONTROL19-22', 'HUAWEI-SSP3000');




--HUAWEI HUAWEI-9312
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-1', 'F48TC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-1', 'G24SC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-1', 'G24SD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-1', 'G48TD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-1', 'HUAWEI-9312-BLANK', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-1', 'X2UXC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-1', 'X4UXC', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-2', 'F48TC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-2', 'G24SC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-2', 'G24SD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-2', 'G48TD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-2', 'HUAWEI-9312-BLANK', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-2', 'X2UXC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-2', 'X4UXC', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-3', 'F48TC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-3', 'G24SC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-3', 'G24SD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-3', 'G48TD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-3', 'HUAWEI-9312-BLANK', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-3', 'X2UXC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-3', 'X4UXC', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-4', 'F48TC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-4', 'G24SC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-4', 'G24SD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-4', 'G48TD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-4', 'HUAWEI-9312-BLANK', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-4', 'X2UXC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-4', 'X4UXC', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-5', 'F48TC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-5', 'G24SC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-5', 'G24SD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-5', 'G48TD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-5', 'HUAWEI-9312-BLANK', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-5', 'X2UXC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-5', 'X4UXC', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-6', 'F48TC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-6', 'G24SC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-6', 'G24SD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-6', 'G48TD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-6', 'HUAWEI-9312-BLANK', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-6', 'X2UXC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-6', 'X4UXC', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-7', 'F48TC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-7', 'G24SC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-7', 'G24SD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-7', 'G48TD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-7', 'HUAWEI-9312-BLANK', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-7', 'X2UXC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-7', 'X4UXC', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-8', 'F48TC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-8', 'G24SC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-8', 'G24SD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-8', 'G48TD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-8', 'HUAWEI-9312-BLANK', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-8', 'X2UXC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-8', 'X4UXC', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-9', 'F48TC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-9', 'G24SC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-9', 'G24SD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-9', 'G48TD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-9', 'HUAWEI-9312-BLANK', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-9', 'X2UXC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-9', 'X4UXC', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-10', 'F48TC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-10', 'G24SC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-10', 'G24SD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-10', 'G48TD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-10', 'HUAWEI-9312-BLANK', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-10', 'X2UXC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-10', 'X4UXC', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-11', 'F48TC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-11', 'G24SC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-11', 'G24SD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-11', 'G48TD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-11', 'HUAWEI-9312-BLANK', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-11', 'X2UXC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-11', 'X4UXC', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-12', 'F48TC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-12', 'G24SC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-12', 'G24SD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-12', 'G48TD', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-12', 'HUAWEI-9312-BLANK', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-12', 'X2UXC', 'HUAWEI-9312');
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-12', 'X4UXC', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-13', 'SRUA', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-14', 'SRUA', 'HUAWEI-9312');



--NMS系统发送邮件参数设置
insert into type_table (ID, SHOW_NUM, TYPE_STATE, TYPE_DESC, TYPE_NAME, TYPE_IDENTITY)
values (SEQ_TYPE_TABLE.Nextval, 10, 0, '状态启动发送；状态停用不发送；', '系统是否使用邮件', 'emailflag');
















