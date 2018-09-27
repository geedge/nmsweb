insert into TYPE_TABLE (ID, SHOW_NUM, TYPE_STATE, TYPE_DESC, TYPE_NAME, TYPE_IDENTITY)
values (SEQ_TYPE_TABLE.nextval, 13, 0, '此项值启用，用于设置数据展示“状态信息”查询条件联想输入的检索关键字。', '数据监测状态信息', 'monitorStatusInfo');

insert into OPTION_TABLE (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE, DELAY_TIME)
values (SEQ_OPTION_TABLE.nextval, 'monitorStatusInfo', '数据状态异常，连续四次超过告警值', '数据状态异常，连续四次超过告警值', 3, 0, '0');

insert into OPTION_TABLE (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE, DELAY_TIME)
values (SEQ_OPTION_TABLE.nextval, 'monitorStatusInfo', '网络异常', '网络异常', 4, 0, '0');

insert into OPTION_TABLE (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE, DELAY_TIME)
values (SEQ_OPTION_TABLE.nextval, 'monitorStatusInfo', '获取SNMP表出错', '获取SNMP表出错', 5, 0, '0');

insert into OPTION_TABLE (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE, DELAY_TIME)
values (SEQ_OPTION_TABLE.nextval, 'monitorStatusInfo', '未取到监测数据', '未取到监测数据', 6, 0, '0');

insert into OPTION_TABLE (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE, DELAY_TIME)
values (SEQ_OPTION_TABLE.nextval, 'monitorStatusInfo', '超过 2 监测周期，未接收到监测结果信息', '超过 2 监测周期，未接收到监测结果信息', 1, 0, '0');

insert into OPTION_TABLE (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE, DELAY_TIME)
values (SEQ_OPTION_TABLE.nextval, 'monitorStatusInfo', '数据状态异常，超过告警值', '数据状态异常，超过告警值', 2, 0, '0');

insert into OPTION_TABLE (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE, DELAY_TIME)
values (SEQ_OPTION_TABLE.nextval, 'monitorStatusInfo', '内存总大小', '内存总大小', 1, 0, '0');

insert into OPTION_TABLE (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE, DELAY_TIME)
values (SEQ_OPTION_TABLE.nextval, 'monitorStatusInfo', '获取该节点系统时间失败', '获取该节点系统时间失败', 7, 0, '0');