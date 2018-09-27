--外网无电源和风扇的监测 ：先新建电源和风扇的监测，监测设置管理配置(需要配置setId：电源和风扇的)

drop table DI_DPSYSTEMFANENTRY;
drop table DI_DPSYSTEMPOWERENTRY;


-- Create sequence  device_brand_info
create sequence SEQ_DEVICE_BRAND_INFO
minvalue 1
maxvalue 999999999999
start with 5
increment by 1
cache 20
cycle
order;

-- Create sequence  device_brand_type
create sequence SEQ_DEVICE_BRAND_TYPE
minvalue 1
maxvalue 999999999999
start with 10
increment by 1
cache 20
cycle
order;

-- Create sequence device_type_info
create sequence SEQ_DEVICE_TYPE_INFO
minvalue 1
maxvalue 999999999999
start with 100
increment by 1
cache 20
cycle
order;

/*
一、	新增监测类别：
    迪普风扇    
	dpSystemFanEntry  DI_DPSYSTEMFANENTRY
	objectSnmp   1.3.6.1.4.1.31648.3.21.1

	修改字段名:选择no作为分类标识

二、	新增监测类别：
    迪普电源 
	dpSystemPowerEntry  DI_DPSYSTEMPOWERENTRY
	objectSnmp  1.3.6.1.4.1.31648.3.20.1

	修改字段名:选择no作为分类标识

三、新增监测设置：电源和风扇的
	新增：不能选择的节点，要分配给DC管理才可以选择

这样就不用增加detection_info_set_id和id、修改主键、不用新建触发器及sequence了
*/



