-- 新增机框和板卡对应的关系
insert into device_brand_type (id,device_brand_code,par_device_type_code,sub_device_type_code) values (seq_device_brand_type.nextval,'HUAWEI','HUAWEI-9312','LEODX16SFC00');


-- 新增板卡信息
insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00', 'HUAWEI', 'LEODX16SFC00�忨', 1, '0', 'image', 10, 10, 373, 41, 'red', 1, 'LEODX16SFC00.png', 'LEODX16SFC00',SYSDATE, 1, '', '', '', '', '', '', '', 2, 0, 0, 1, null, null);


-- 新增板卡端口的信息
insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-0', 'HUAWEI', 'XGigabitEthernet-0', 0, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 121, 7, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-1', 'HUAWEI', 'XGigabitEthernet-1', 1, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 121, 22, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-2', 'HUAWEI', 'XGigabitEthernet-2', 2, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 136, 7, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-3', 'HUAWEI', 'XGigabitEthernet-3', 3, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 136, 22, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-4', 'HUAWEI', 'XGigabitEthernet-4', 4, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 151, 7, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-5', 'HUAWEI', 'XGigabitEthernet-5', 5, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 151, 22, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-6', 'HUAWEI', 'XGigabitEthernet-6', 6, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 166, 7, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-7', 'HUAWEI', 'XGigabitEthernet-7', 7, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 166, 22, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-8', 'HUAWEI', 'XGigabitEthernet-8', 8, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 198, 7, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-9', 'HUAWEI', 'XGigabitEthernet-9', 9, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 198, 22, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-10', 'HUAWEI', 'XGigabitEthernet-10', 10, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 213, 7, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-11', 'HUAWEI', 'XGigabitEthernet-11', 11, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 213, 22, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-12', 'HUAWEI', 'XGigabitEthernet-12', 12, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 228, 7, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-13', 'HUAWEI', 'XGigabitEthernet-13', 13, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 228, 22, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-14', 'HUAWEI', 'XGigabitEthernet-14', 14, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 243, 7, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM, IS_POSITIONDEV, HAS_INSTANCE)
values (seq_device_type_info.nextval, 'LEODX16SFC00-15', 'HUAWEI', 'XGigabitEthernet-15', 15, (select t.id from device_type_info t where t.device_type_code = 'LEODX16SFC00'), 'image', 243, 22, 13, 8, 'red', 1, 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, to_date('10-10-2015 16:15:20', 'dd-mm-yyyy hh24:mi:ss'), 242, 'DI_SWITCHPORT', 'ifDescr', '', '', '', 3, 1, 1, 1, 0, 0);


-- 新增机框板槽和板卡的对应信息
insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-1', 'LEODX16SFC00', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-2', 'LEODX16SFC00', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-3', 'LEODX16SFC00', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-4', 'LEODX16SFC00', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-5', 'LEODX16SFC00', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-6', 'LEODX16SFC00', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-7', 'LEODX16SFC00', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-8', 'LEODX16SFC00', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-9', 'LEODX16SFC00', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-10', 'LEODX16SFC00', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-11', 'LEODX16SFC00', 'HUAWEI-9312');

insert into device_boardsolt_board (ID, DEVICE_BRAND_CODE, DEVICE_BOARD_SOLT_CODE, DEVICE_BOARD_CODE, DEVICE_TYPE_CODE)
values (seq_device_boardsolt_board.nextval, 'HUAWEI', 'HUAWEI-9312-12', 'LEODX16SFC00', 'HUAWEI-9312');

COMMIT;



