-- 异常服务器列表、异常网元列表，默认显示非紧急告警
   -- URL添加 menuVisit=true 参数
-- 异常服务器、异常网元、告警信息列表增加过滤条件：过滤超周期监测，默认过滤超周期告警
   -- URL添加 timeoutDetecFilter=true 参数

update Xt_mk_jbxx
   set mkurl = '/detection/detectionWarning.do?action=queryNE'||chr(38)||'menuVisit=true'||chr(38)||'timeoutDetecFilter=true'
 where mkmc = '异常网元';
update Xt_mk_jbxx
   set mkurl = '/detection/detectionWarning.do?action=query'||chr(38)||'menuVisit=true'||chr(38)||'timeoutDetecFilter=true'
 where mkmc = '异常服务器';
update Xt_mk_jbxx
   set mkurl = '/detection/detectionWarning.do?action=queryAllConfigLevel'||chr(38)||'timeoutDetecFilter=true'
 where mkmc = '告警信息' and mkurl like '%action=queryAllConfigLevel%';