--为device_type_info增加字段：是否为槽位设备、是否配置实例
alter table device_type_info add (IS_POSITIONDEV NUMBER default 0);
comment on column device_type_info.IS_POSITIONDEV is '是否为槽位设备，1是，0否';

alter table device_type_info add (HAS_INSTANCE NUMBER default 1);
comment on column device_type_info.HAS_INSTANCE is '是否配置实例，1是，0否';

--设置 是否为槽位设备字段的值 及 是否配置实例的值
update device_type_info set HAS_INSTANCE=1;
update device_type_info set is_positiondev=0;
update device_type_info set is_positiondev=1 where is_leaf=0 and show_level=2 and id not in(1278,895,894,861,860,777,764,763,762,555,554,553,552,551,550,454,455,456,317,265,264,263,261,260,233,218,5,4,2);

--特种设备配置：修改sequence 的下一个值
drop sequence seq_device_type_info;
create sequence SEQ_DEVICE_TYPE_INFO
minvalue 1
maxvalue 999999999999
start with 1438
increment by 1
cache 20
cycle
order;

drop sequence SEQ_DEVICE_BRAND_TYPE;
create sequence SEQ_DEVICE_BRAND_TYPE
minvalue 1
maxvalue 999999999999
start with 410
increment by 1
cache 20
cycle
order;




