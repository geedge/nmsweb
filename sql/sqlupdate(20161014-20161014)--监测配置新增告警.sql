-----为cpu监测新增告警 总使用率达到100%
-----添加cpu总使用率报警字段
insert into metadata (ID, CHECK_TYPE_ID, TABLE_NAME, TABLE_COMMENTS, FILED_NAME, FILED_COMMENTS, FILED_TYPE, CREATE_DATE, CREATE_PERSON, STATE, UPDATE_DATE, UPDATE_PERSON, CHART_STATE, SHOW_NUM, ISNULL, OID, SORT_SIGN, TYPE_ID)
values (seq_metadata.nextval, (select id from check_type_info where check_type_name1 = 'CPU监测'), 'DETECT_INFO_CPU', '', 'TOTAL_USED_PERC', '总的使用率(%)', 'Number', null, 1, '0', null, 0, '0', 7, null, '', 1, '');

-----添加cpu总使用率的告警
insert into data_police_relation (ID, DETECTION_SET_INFO_ID, METADATA_ID, POLICE_STATE, POLICE_VALUE, POLICE_UNIT, POLICE_SYMBOLS, POLICE_LEVEL, POLICE_SHOW_INFO, POLICE_EMERGENT, MARKER, MARKER_FILED_ID)
values (seq_data_police_relation.nextval, (select id from detection_set_info where process_iden_name = 'CPU监测'), (select id from metadata where filed_comments = '总的使用率(%)'), '0', '100', '%', '>=', 0, '', 0, '', null);




-----为硬盘监测新增告警 总使用率达到95%
-----添加硬盘总使用率报警字段
insert into metadata (ID, CHECK_TYPE_ID, TABLE_NAME, TABLE_COMMENTS, FILED_NAME, FILED_COMMENTS, FILED_TYPE, CREATE_DATE, CREATE_PERSON, STATE, UPDATE_DATE, UPDATE_PERSON, CHART_STATE, SHOW_NUM, ISNULL, OID, SORT_SIGN, TYPE_ID)
values (seq_metadata.nextval, (select id from check_type_info where check_type_name1 = '硬盘监测'), 'DETECT_INFO_DISK', '', 'USED_DISK_PERC', '磁盘总使用率(%)', 'Number', null, 1, '0', null, null, '0', 4, null, '', 1, '');

-----添加硬盘总使用率的告警
insert into data_police_relation (ID, DETECTION_SET_INFO_ID, METADATA_ID, POLICE_STATE, POLICE_VALUE, POLICE_UNIT, POLICE_SYMBOLS, POLICE_LEVEL, POLICE_SHOW_INFO, POLICE_EMERGENT, MARKER, MARKER_FILED_ID)
values (seq_data_police_relation.nextval, (select id from detection_set_info where process_iden_name = '硬盘监测'), (select id from metadata where filed_comments = '磁盘总使用率(%)'), '0', '95', '%', '=', 0, '', 0, '', null);
