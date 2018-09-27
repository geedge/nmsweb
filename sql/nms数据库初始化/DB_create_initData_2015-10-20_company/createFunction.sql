-------------------------------------------
-- Export file for user NMS              --
-- Created by dell on 2015/5/5, 11:34:35 --
-------------------------------------------

spool createFunction.log

prompt
prompt Creating function IS_DATE
prompt =========================
prompt
create or replace function is_date(param in varchar2) return number is
--判断所给字符串的后8位是否为日期类型
   val DATE;
   str varchar2(60);
begin
   --如果param长度大于等于8，则截取最后的8个字符进行判断，是则返回1，否则返回0
   if length(param) >=8 then
      str := substr(param,-8);
   end if;    
   
   val := to_date(nvl(str,'a'),'yyyyMMdd');
   return 1;
   exception
        when others then
            return 0;
end is_date;
/

prompt
prompt Creating function LESS_EUQAL_DATE
prompt =================================
prompt
create or replace function less_euqal_date(param in varchar2,leDate in date) return number is
--首先判断所给字符串是否为日期，如果不是日期返回0，如果是，则跟leDate比较，小于等于leDate返回1,大于leDate返回2
   val DATE;
   str varchar2(60);
begin
   --如果param长度大于等于8，则截取最后的8个字符进行判断，是则返回1，否则返回0
   if length(param) >=8 then
      str := substr(param,-8);
   end if;

   val := to_date(nvl(str,'a'),'yyyyMMdd');
   
   if val <= leDate then
      return 1;
   end if;
   
   return 2;
   
   exception
        when others then
            return 0;
end less_euqal_date;
/

prompt
prompt Creating function ORACLE_TO_UNIX
prompt ================================
prompt
CREATE OR REPLACE FUNCTION ORACLE_TO_UNIX(in_date IN DATE) RETURN NUMBER IS
BEGIN
---------------------------------------------------------------------------------------------------------------------------
--Copyright (c)2011,中国科学院计算技术研究所
--All rights reserved
--
--此函数的功能
--oracle时间转unix时间
--当前版本：2. 0
--作         者：邵波
--操作系统：oracle 10g r2
--日         期：2011.6.30
---
---------------------------------------------------------------------------------------------------------------------------
--  RETURN( (in_date -TO_DATE('19700101','yyyymmdd'))*86400 - TO_NUMBER(SUBSTR(TZ_OFFSET(sessiontimezone),1,3))*3600);
--END;
---------------------------------------------------------------------------------------------------------------------------
  RETURN( (in_date -TO_DATE('19700101','yyyymmdd'))*86400 - 8*3600);
END;
---------------------------------------------------------------------------------------------------------------------------
/


spool off
