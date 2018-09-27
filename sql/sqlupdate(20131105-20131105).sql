--任务4的结果表增加字段：任务结果失败的具体原因，目前只用于下发失败的情况(41)，主要用于下发失败后，再次初始化周期任务的结果时，默认结果为1（失败），具体结果为41（下发失败）
alter table MISSION_RESULT_TABLE4  add (RESULT_DETAIL NUMBER);
comment on column MISSION_RESULT_TABLE4.RESULT_DETAIL is '任务结果失败的具体原因，目前只用于下发失败的情况(41)，主要用于下发失败后，再次初始化周期任务的结果时，默认结果为1（失败），具体结果为41（下发失败）';