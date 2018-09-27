-- 删除nms_error_code 表数据信息
truncate table nms_error_code ;
commit;
-- 插入nms_error_code 表数据信息
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (1, 'ServerProcessNotExist', 'Server进程不存在', 'Server未启动', 0);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (2, 'DCProcessNotExist', 'DC进程不存在', 'DC进程不存在', 0);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (3, 'DCOverLoad', 'DC压力过大', 'DC压力过大（节点超过一定数量或者请求信息过多）', 0);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (28, 'NetWorkError', '网络不通', 'PING不通', 0);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (5, 'NoRescponse', '无响应', 'PING通，握手不成功', 0);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (6, 'DataResolveError', '数据解析异常', 'catch到的异常，其他数据对应的错误通过监测数据本身报警', 0);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (7, 'UnknownError', '未知错误', '程序未能分析的错误', 0);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (9, 'CreateSocketError', '创建通讯失败', '创建通讯失败', 0);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (8, 'DCHandshakeError', 'DC握手通信失败', 'Web与DC握手通信失败，DC未运行或DC运行但握手失败', 0);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (10, 'NCWorkError', 'NC工作异常', 'NC端异常', 0);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (11, 'DCSocketServerStartError', 'DC通讯服务启动失败', 'DC端通讯服务启动失败', 0);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (13, 'DCSocketRuntimeError', 'DC通讯过程中异常', 'DC端通讯内容异常的错误代码，用于基本通讯告警', 0);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (12, 'DCSocketServerRuntimeError', 'DC通讯服务运行时异常', 'DC通讯服务运行时异常', 0);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (21, 'ProcessNotExist', '进程不存在', '目标进程不存在，用于Web、DC、NC、第三方监测线程、执行线程不存在等', 1);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (22, 'ThreadRuntimeError', '执行异常', '各程序代码执行异常，适用于Web、DC、NC、各部分程序线程执行错误', 3);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (23, 'HandShakeError', '通讯握手失败', '通讯握手失败，适用于web与DC握手，DC与NC握手', 2);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (24, 'ProtListenerError', '端口监听失败', '端口监听失败，适用于通讯服务端口监听和snmp服务端口监听失败情况', 2);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (25, 'DeamonNotExist', '守护进程不存在', '守护进程不存在，适用于NC守护进程未启动、DC守护进程未启动', 2);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (26, 'DataResoveError', '数据解析错误', '数据解析错误，适用于DC端各类信息解析异常情况', 3);
insert into NMS_ERROR_CODE (ID, ERROR_CODE, ERROR_NAME, ERROR_DES, ERROR_LEVEL)
values (27, 'SocketError', '通讯失败', '通讯过程中异常导致失败，适用于web、DC、NC 通讯线程异常情况', 3);
commit;

--nms_error_info表 增加字段
alter table nms_error_info add (ERROR_DES VARCHAR2(200));
comment on column NMS_ERROR_INFO.ERROR_DES is '异常描述信息';