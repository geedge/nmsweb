--修改异常网元列表的url（统一异常服务器和异常网元的显示样式）
update xt_mk_jbxx  set mkurl='/detection/detectionWarning.do?action=queryNE' where mkmc='异常网元';
commit;