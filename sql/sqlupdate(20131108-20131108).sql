--2013-11-08 修改内容：任务更新描述避免重复
--如果结果描述里已包括新描述，则不组合描述，不然会造成相同描述出现多次，否则将新旧描述组合


CREATE OR REPLACE TRIGGER BEFORE_UPDATE_MISSION_RESULT_4
  BEFORE UPDATE ON "MISSION_RESULT_TABLE4"
  REFERENCING OLD AS o NEW AS n FOR EACH ROW
DECLARE
  --中间参数
  --length_rda         number                := lengthb(nvl(:o.result_desc,'')||nvl(:n.result_desc,''));
BEGIN
  -- 思路整理：
  -- result_4 存在两种业务
  --    1、有效任务执行流程
  --        程序中将任务结果状态初始化为3 中间结果为40、50、60、70、80、81
  --        最终结果为0（成功）或1（失败）  结果不再变更
  --    2、撤销任务执行流程
  --        程序将任意结果变更为5  中间结果为6（已下发）
  --        最终结果为7（撤销完成） 结果不再变更
  -- 整理 根据旧信息状态区别两种业务 对5、6、7 结果指定处理；其他结果为另一业务
  --      5可覆盖除了7以外的任意结果

  -- 结果变更实现
  if updating('result') THEN
     -- 业务撤销任务执行流程 7为最终结果
     if (:n.result in (5,6,7)) then
        if (:o.result = 7) then
           :n.result := :o.result;
        end if;
     else
     -- 业务有效任务执行流程 撤销任务的状态不可更改
        if (:o.result in (5,6,7)) then
           :n.result := :o.result;
        else
           --任务结果更新过滤 0或1 或结果为空时保持旧的结果
           if (:n.result <> -1 and ((:o.result = 0) or (:o.result = 1) or (:n.result is null)))  then
              :n.result := :o.result;
           end if;
        end if;
     end if;
  end if;

  --任务结果描述更新
  if updating('result_desc') then
     if :o.result_desc is not null and :n.result_desc is not null and instr(:o.result_desc,:n.result_desc)>0 then  --如果结果描述里已包括新描述，则不组合描述，不然会造成相同描述出现多次
        :n.result_desc := nvl(:o.result_desc,'');
     else --否则将新旧描述组合
        :n.result_desc := nvl(:o.result_desc,'')||nvl(:n.result_desc,'');
     end if;
  end if;

  --回传文件信息处理，非空时，和原有数据拼接再保存
  if updating('file_info') THEN
     if (:o.file_info is not NULL) then
         if(:n.file_info is not null) then
             :n.file_info := nvl(:o.file_info,'')||'@@@'||nvl(:n.file_info,'');
         else
             :n.file_info := nvl(:o.file_info,'');
         end if;

     end if;
  end if;
END;