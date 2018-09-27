--节点表新增用户名、密码、网元类型字段
alter table node_table add (NODE_USERNAME VARCHAR2(20),NODE_PASSWORD VARCHAR2(50),NETWORK_ELEMENT_TYPE NUMBER);

--新增网元类型数据字典
insert into TYPE_TABLE (ID, SHOW_NUM, TYPE_STATE, TYPE_DESC, TYPE_NAME)
values (41, 3, 0, null, '网元节点分类');
insert into OPTION_TABLE (ID, TYPE_ID, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE)
values (seq_option_table.nextval, 41, '1', '专用设备', 1, 0);
insert into OPTION_TABLE (ID, TYPE_ID, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE)
values (seq_option_table.nextval, 41, '2', '盘阵', 2, 0);
insert into OPTION_TABLE (ID, TYPE_ID, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE)
values (seq_option_table.nextval, 41, '3', '封堵路由器', 3, 0);
insert into OPTION_TABLE (ID, TYPE_ID, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE)
values (seq_option_table.nextval, 41, '4', '其他网元', 4, 0);