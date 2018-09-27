--删除模拟数据
--detection_info_new
delete from detection_info_new din where  din.detection_info_id in (
    select t.id from detection_info t
    where  t.detection_state_info='监测成功(Random)'  and t.performace_data='监测成功(Random)'
);
commit;

--detection_info_warning
delete from detection_info_warning din where  din.detection_info_id in (
    select t.id from detection_info t
    where  t.detection_state_info='监测成功(Random)'  and t.performace_data='监测成功(Random)'
);
commit;

--迪普风扇 模拟数据的删除
truncate table di_dpsystemfanentry;
commit;

--迪普电源 模拟数据的删除     
truncate table di_dpsystempowerentry; 
commit;

--系统信息 模拟数据的删除
--select count(*) from di_system ds where ds.syslocation='Right here, right now.';

delete from di_system ds where ds.syslocation='Right here, right now.';
commit;

 
--di_switchport表 模拟数据的删除:按分区进行删除 DI_W201318、按seqId删除、按rownum删除
--一个节点一个节点的删除（2万条很快就删除了，8万条：1-2分钟）

--分区表有多少条记录
select count(*) from di_switchport /*partition(DI_W201320)*/ t where /*t.seq_id=98 and */t.ifphysaddress='(Random)3c:e5:a6:02:4c:75' ;
--查询从哪个分区开始删除
select max(t.data_check_time) from di_switchport /*partition(DI_W201316)*/ t 
where t.seq_id=500 and t.ifphysaddress='(Random)3c:e5:a6:02:4c:75';

delete from di_switchport /*partition(DI_W201320)*/ t 
where /*t.seq_id=128 and*/ t.ifphysaddress='(Random)3c:e5:a6:02:4c:75' /*and rownum<100*/ ;
commit;



--detection_info 模拟数据删除
delete from detection_info /*partition(DI_W201313)*/ t
where /*t.seq_id=250 and*/ t.performace_data='监测成功(Random)'/* and rownum<100 */;
commit;

--分区表有多少条记录
select count(*) from detection_info /*partition(DI_W201313)*/ t
where/* t.seq_id=132 and */  t.performace_data='监测成功(Random)';

select * from detection_info /*partition(DI_W201313)*/ t
where/* t.seq_id=132 and */  t.performace_data='监测成功(Random)';


select min(t.data_check_time) from detection_info /*partition(DI_W201313)*/ t
where /*t.seq_id=132 and*/ t.performace_data='监测成功(Random)';

--节点seqId查询
select nt.node_ip,nt.seq_id,nt.node_type from node_table nt where nt.node_type=1;