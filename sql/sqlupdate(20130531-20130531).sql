--option_table  表添加延时时间字段及设置值

alter table option_table add(delay_time VARCHAR2(50));

comment on column OPTION_TABLE.DELAY_TIME
  is '为0时，即时发，为-1时不发，其他数值为延时分钟数';
  
update option_table set DELAY_TIME='0' where TYPE_IDENTITY='emergent' and TYPE_CODE='0';

update option_table set DELAY_TIME='5' where TYPE_IDENTITY='emergent' and TYPE_CODE='1';

commit;