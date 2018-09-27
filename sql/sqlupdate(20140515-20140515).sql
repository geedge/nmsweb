--设置监测告警时，增加指定标识字段
alter table data_police_relation add  marker VARCHAR2(1024);
comment on column data_police_relation.marker is '设置告警时，指定多个标识符（如多个盘符、多个CPU、多个网卡），如硬盘使用率，空：所有盘存在一个盘使用率超过告警值，则告警；all：所有盘总的使用率超过告警值，则告警；指定多个盘符：指定盘存在一个盘使用率超过告警值，则告警';

--过滤标识对应的字段
alter table data_police_relation add  MARKER_FILED_ID NUMBER;
comment on column data_police_relation.MARKER_FILED_ID is '设置告警时，过滤标识marker对应的字段在metadata表中的id。';