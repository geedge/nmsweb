--将'新增相似'按钮，修改为'任务拷贝'
update xt_mk_jbxx set mkmc='任务拷贝' where mkmc='新增相似';
commit;