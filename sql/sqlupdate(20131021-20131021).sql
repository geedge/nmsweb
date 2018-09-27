--告警信息列表显示的告警级别（告警信息列表显示的均为紧急的告警）
insert into type_table (ID, SHOW_NUM, TYPE_STATE, TYPE_DESC, TYPE_NAME, TYPE_IDENTITY)
values (seq_type_table.nextval, 1, 0, '告警信息列表显示的告警级别（告警信息列表显示的均为紧急的告警）', '告警信息显示的级别', 'detecWarningLevel');

--option_table表
insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE, DELAY_TIME)
values (seq_option_table.nextval, 'detecWarningLevel', '1', '1级告警', 1, 0, '0');

insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE, DELAY_TIME)
values (seq_option_table.nextval, 'detecWarningLevel', '2', '2级告警', 2, 1, '0');

insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE, DELAY_TIME)
values (seq_option_table.nextval, 'detecWarningLevel', '3', '3级告警', 3, 1, '0');

insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE, DELAY_TIME)
values (seq_option_table.nextval, 'detecWarningLevel', '4', '4级告警', 4, 1, '0');

insert into option_table (ID, TYPE_IDENTITY, TYPE_CODE, TYPE_VALUE, SHOW_NUM, TYPE_STATE, DELAY_TIME)
values (seq_option_table.nextval, 'detecWarningLevel', '5', '5级告警', 5, 1, '0');

--1.将告警信息列表的url配置为：/detection/detectionWarning.do?action=queryAllConfigLevel
--2.以下告警为1级、紧急：NC挂掉（握手失败）、网络异常、客户端挂掉（网络异常）、DC异常（超周期无监测数据）、脚本停止运行（加进程监测：1级、紧急；需要更新NC、web）。将其它告警设置配置为5级，非紧急
--3.脚本停止运行（加进程监测：1级、紧急；):1级、紧急、NO、equals、进程不存在时，报紧急告警、无进程
--4.4个周期无数据为1级紧急告警（NC正常，无监测数据产生）、4个周期连续告警（5级，非紧急告警;前提是设置了告警;所以设置告警的时候设置为非紧急即可;最终的紧急状态取决于设置的状态）
--5.告警信息显示在第二个位置（业务逻辑拓扑之后，从DB中改）



