-- 触发器 邮件 
create or replace trigger before_insert_email_table
  before insert on EMAIL_TABLE
  for each row
declare
  -- local variables here
begin
if ( :new.id is null )   --insert
then
    select SEQ_EMAIL_TABLE.nextVal into :new.id from dual ;
end if;

end before_insert_email_table;

-- 触发器 detection_info 
create or replace trigger before_insert_detection_info
  before insert on detection_info
  for each row
declare

  -- attributies
  detection_info_id_a      number        := :new.id; -- 监测记录id
  detection_set_info_id_a  NUMBER        := :new.detection_set_info_id;  -- 监测设置id，外键
  check_way_a              CHAR(1)       := :new.check_way;              -- 监测方式不能为空，可选[0/1]0主动、1被动（设置为主动可能本记录为被动）
  detection_state_info_a   VARCHAR2(1024) := :new.detection_state_info;   -- 状态信息
  performace_data_a        VARCHAR2(1024) := :new.performace_data;        -- 性能数据
  current_times_a          NUMBER        := :new.current_times;          -- 当前尝试次数
  start_time_a             DATE          := :new.start_time;             -- 开机时间（开运时间）
  wait_time_a              NUMBER        := :new.wait_time;              -- 检测等待时间单位秒
  delay_time_a             NUMBER        := :new.delay_time;             -- 检测时延单位秒
  next_check_time_a        DATE          := :new.next_check_time;        -- 下一次计划主动式检测时间
  off_line_a               DATE          := :new.off_line;               -- 计划宕机时间
  police_level_a           NUMBER        := :new.police_level;           -- 告警级别
  data_check_time_a        DATE          := :new.data_check_time;        -- 获取监测数据时间
  data_arrive_time_a       DATE          := :new.data_arrive_time;       -- 数据入库时间
  detectioned_state_a      VARCHAR2(2)   := :new.detectioned_state;      -- 被监控状态是否正常：0不正常；1正常
  seq_id_a                 NUMBER        := :new.seq_id;
  --notice_flag_a            CHAR(1)       := '0'  ;                        -- 是否已发通知:0未发；1已发
  node_ip_a                VARCHAR2(15)  := :new.node_ip;                 -- 节点IP
  data_check_time_digital_a  NUMBER        := :new.data_check_time_digital;                --获取监测数据时间 数字类型
  data_arrive_time_digital_a NUMBER        := :new.data_arrive_time_digital;                --数据入库时间 数字类型
  --params
  info_new_flag            NUMBER        := 0 ;                          -- 判断是否为最新监控数据 缺省0 数据不存在，需要insert，为1 需要update 为2 无需操作
  status_change_time_a     DATE;
  --info_warning_flag        NUMBER        := 0 ;                           -- 判断是否为警报信息  缺省为0 否则为1
  --check_gap_temp                  NUMBER;
 --CURSOR
  CURSOR info_new_cursor is
  select * from detection_info_new din
  where din.detection_set_info_id = detection_set_info_id_a
  --and din.node_ip = node_ip_a
  and din.seq_id = seq_id_a
  order by din.data_check_time desc;
  info_new_row  detection_info_new%ROWTYPE;               -- 游标名的声明 与 指定游标集合结构 定义。

begin
OPEN info_new_cursor;  -- 打开游标
  LOOP     -- 循环开始
      FETCH info_new_cursor INTO info_new_row;    -- 将游标集合存到游标中
      EXIT WHEN info_new_cursor%NOTFOUND;   -- 循环条件
      --是否更新detection_info_new表标识判断
      IF ( info_new_row.data_check_time < data_check_time_a )
      THEN info_new_flag := 1;              -- 判断结构开始，当前记录是新更新detection_info_new表
      ELSE info_new_flag := 2;              -- 跳过detection_info_new保存，当前记录非最新纪录，无需更新
      END IF;         --判断结构结束
      IF(info_new_flag = 0 or info_new_flag = 1)
      THEN
        --如果新监测数据的监测大于detection_info_new表对应记录的监测时间，并且监测间隔在0到两个周期之间是正常数据，
        IF ( info_new_row.data_check_time < :new.data_check_time )
        THEN 
          --detection_info_new表对应记录的监测时间如果在新记录的启动时间之前则更改detection_info_new表记录状态变更时间
          IF(info_new_row.data_check_time < :new.start_time)
          THEN status_change_time_a := :new.data_check_time;
          END IF;
        END IF;
        --状态变更字段判断
        --如果监测记录的状态变化，或者监测记录状态未变但是报警级别变化
        IF (info_new_row.detectioned_state <> detectioned_state_a or (info_new_row.detectioned_state = detectioned_state_a and info_new_row.police_level <> police_level_a))
        THEN
            IF(:new.start_time > info_new_row.data_check_time)
            THEN
                :new.status_change_time := data_check_time_a;      -- 新入数据状态变更时间 更新
                status_change_time_a := data_check_time_a;  
            ELSE
                :new.status_change_time := :new.start_time;      -- 新入数据状态变更时间 更新
                status_change_time_a := :new.start_time;  
            END IF;
        ELSE     --状态无变更时 数据使用new表状态变更时间insert into TESTTRRGGER(ID,DID,TEXT) values(SEQ_testtrrgger.Nextval,:new.id,'开始触发器info_new_row.data_check_time < :new.start_time');
          --判断当前记录是不是正常入库数据，如果和detection_info_new表的记录间隔在两个周期之内为正常数据，大于两个周期则新监测时间为状态变更时间
            status_change_time_a := info_new_row.status_change_time;
            :new.status_change_time := info_new_row.status_change_time;
        END IF;

        if(status_change_time_a is null) then status_change_time_a := :new.data_check_time;
        end if;
 
      end if;
  END LOOP;           --循环结束
  CLOSE info_new_cursor;   -- 关闭游标
  --节点设置在detection_info_new表没有对应记录，新增。新增记录中的状态变更时间为监测时间
  if ( info_new_flag = 0 )   --insert
  THEN
  status_change_time_a := :new.data_check_time;
            insert into detection_info_new
            (detection_set_info_id  ,check_way  ,detection_state_info  ,performace_data  ,current_times  ,start_time  ,wait_time  ,delay_time  ,next_check_time  ,off_line  ,police_level  ,node_ip  ,data_check_time  ,data_arrive_time  ,detectioned_state  ,status_change_time  ,seq_id  ,detection_info_id,data_check_time_digital,data_arrive_time_digital) values
            (detection_set_info_id_a,check_way_a,detection_state_info_a,performace_data_a,current_times_a,start_time_a,wait_time_a,delay_time_a,next_check_time_a,off_line_a,police_level_a,node_ip_a,data_check_time_a,data_arrive_time_a,detectioned_state_a,status_change_time_a,seq_id_a,detection_info_id_a,data_check_time_digital_a,data_arrive_time_digital_a);
  end if;
  --节点设置在detection_info_new表有相应记录并且是新记录，则更新detection_info_new记录
  if ( info_new_flag = 1 )   --update
  THEN
  
    update detection_info_new din set
            din.check_way =check_way_a
            , din.detection_state_info = detection_state_info_a
            , din.performace_data = performace_data_a
            , din.current_times = current_times_a
            , din.start_time = start_time_a
            , din.wait_time = wait_time_a
            , din.delay_time = delay_time_a
            , din.next_check_time = next_check_time_a
            , din.off_line = off_line_a
            , din.police_level = police_level_a
            , din.node_ip = node_ip_a
            , din.data_check_time = data_check_time_a
            , din.data_arrive_time = data_arrive_time_a
            , din.detectioned_state = detectioned_state_a
            , din.status_change_time = status_change_time_a
            , detection_info_id = detection_info_id_a
            ,data_check_time_digital = data_check_time_digital_a
            ,data_arrive_time_digital = data_arrive_time_digital_a
            where din.detection_set_info_id = detection_set_info_id_a
            and din.seq_id = seq_id_a;

  end if;

  --insert into LOGTABLE(name,num,newdate) values(info_new_flag,detection_set_info_id_a,data_check_time_a);
  --info_warning
  --if(police_level_a<99)
  --then
  --     insert into detection_info_warning
  --     (detection_set_info_id  ,check_way  ,detection_state_info  ,performace_data  ,current_times  ,start_time  ,wait_time  ,delay_time  ,next_check_time  ,off_line  ,police_level  ,police_parm  ,data_check_time  ,data_arrive_time  ,detectioned_state  ,notice_flag) values
  --     (detection_set_info_id_a,check_way_a,detection_state_info_a,performace_data_a,current_times_a,start_time_a,wait_time_a,delay_time_a,next_check_time_a,off_line_a,police_level_a,police_parm_a,data_check_time_a,data_arrive_time_a,detectioned_state_a,notice_flag_a);
  --end if;
end before_detection_info;



--更新deviceTypeInfo表的数据
truncate table device_type_info; 
alter table device_type_info add MAX_DEVICE_NUM number default 1;

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (1, 'DPX8000-A12', 'DPtech', 'DPtech DPX8000-A12 分流设备', 1, '0', 'image', 35, 0, 432, 607, 'red', 1, 'DPX8000-A12.png', 'DPX8000-A12', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SYSTEM', '', '', '', '', 1, 0, 0, 5);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (2, 'MPUA', 'DPtech', 'MPUA主控板在DPX8000系列产品中起主导作用，实现系统的初始化配置、管理以及控制报文的处理等。', 1, '0', 'image', 10, 10, 354, 34, 'red', 1, 'MPUA.png', 'MPUA', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (3, 'DPX8000-A12-One', 'DPtech', 'DPX8000-A12默认槽位1', 1, '1', 'image', 26, 47, 354, 34, 'red', 1, 'DPX8000-A12.png', 'DPX8000-A12', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (4, 'PF4XPS8XGES-E', 'DPtech', '分流业务板（PF4XPS8XGES-E），插在业务槽位，提供4个XFP 10GE  POS光接口，8个万兆以太网光接口(SFP+)。', 1, '0', 'image', 10, 10, 354, 34, 'red', 1, 'PF4XPS8XGES-E.png', 'PF4XPS8XGES-E', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (5, '8XGEP-D', 'DPtech', '接口板（8XGEP-D）插在业务槽位，提供8个XFP 10GE以太网光接口。', 1, '0', 'image', 20, 50, 354, 34, 'red', 1, '8XGEP-D.png', '8XGEP-D', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (6, 'S5048E', 'H3C', 'H3C S5048E交换机', 1, '0', 'image', 0, 25, 500, 60, 'red', 1, 'S5048E.png', 'S5048E', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SYSTEM', '', '', '', '', 1, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (7, 'DPX8000-A12-Two', 'DPtech', 'DPX8000-A12默认槽位2', 2, '1', 'image', 26, 83, 354, 34, 'red', 1, 'DPX8000-A12.png', 'DPX8000-A12', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (8, 'DPX8000-A12-Three', 'DPtech', 'DPX8000-A12默认槽位3', 3, '1', 'image', 26, 120, 354, 34, 'red', 1, 'DPX8000-A12.png', 'DPX8000-A12', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (9, 'DPX8000-A12-Four', 'DPtech', 'DPX8000-A12默认槽位4', 4, '1', 'image', 26, 157, 354, 34, 'red', 1, 'DPX8000-A12.png', 'DPX8000-A12', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (10, 'DPX8000-A12-Five', 'DPtech', 'DPX8000-A12默认槽位5', 5, '1', 'image', 26, 194, 354, 34, 'red', 1, 'DPX8000-A12.png', 'DPX8000-A12', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (11, 'DPX8000-A12-Six', 'DPtech', 'DPX8000-A12默认槽位6', 6, '1', 'image', 26, 231, 354, 34, 'red', 1, 'DPX8000-A12.png', 'DPX8000-A12', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (12, 'DPX8000-A12-Seven', 'DPtech', 'DPX8000-A12默认槽位7', 7, '1', 'image', 26, 268, 354, 34, 'red', 1, 'DPX8000-A12.png', 'DPX8000-A12', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (13, 'DPX8000-A12-Eight', 'DPtech', 'DPX8000-A12默认槽位8', 8, '1', 'image', 26, 305, 354, 34, 'red', 1, 'DPX8000-A12.png', 'DPX8000-A12', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (14, 'DPX8000-A12-Nine', 'DPtech', 'DPX8000-A12默认槽位9', 9, '1', 'image', 26, 342, 354, 34, 'red', 1, 'DPX8000-A12.png', 'DPX8000-A12', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (15, 'DPX8000-A12-Ten', 'DPtech', 'DPX8000-A12默认槽位10', 10, '1', 'image', 26, 379, 354, 34, 'red', 1, 'DPX8000-A12.png', 'DPX8000-A12', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (16, 'DPX8000-A12-Eleven', 'DPtech', 'DPX8000-A12默认槽位11', 11, '1', 'image', 26, 415, 354, 34, 'red', 1, 'DPX8000-A12.png', 'DPX8000-A12', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (17, 'DPX8000-A12-Twelve', 'DPtech', 'DPX8000-A12默认槽位12', 12, '1', 'image', 26, 452, 354, 34, 'red', 1, 'DPX8000-A12.png', 'DPX8000-A12', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 0, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (18, 'MPUA-Port0', 'DPtech', 'MPUA主控板默认端口0', 0, '2', 'image', 100, 6, 11, 8, 'red', 1, 'MPUA-Port0.png', 'meth0_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (19, 'PF4XPS8XGES-E-One', 'DPtech', 'PF4XPS8XGES-E端口1', 1, '4', 'image', 87, 18, 18, 8, 'red', 1, 'PF4XPS8XGES-E-POS.png', 'pos[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (20, 'PF4XPS8XGES-E-Two', 'DPtech', 'PF4XPS8XGES-E端口2', 2, '4', 'image', 141, 18, 18, 8, 'red', 1, 'PF4XPS8XGES-E-POS.png', 'pos[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (21, 'PF4XPS8XGES-E-Three', 'DPtech', 'PF4XPS8XGES-E端口3', 3, '4', 'image', 193, 18, 18, 8, 'red', 1, 'PF4XPS8XGES-E-POS.png', 'pos[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (22, 'PF4XPS8XGES-E-Four', 'DPtech', 'PF4XPS8XGES-E端口4', 4, '4', 'image', 252, 4, 14, 8, 'red', 1, 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (23, 'PF4XPS8XGES-E-Five', 'DPtech', 'PF4XPS8XGES-E端口5', 5, '4', 'image', 252, 19, 14, 8, 'red', 1, 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (24, 'PF4XPS8XGES-E-Six', 'DPtech', 'PF4XPS8XGES-E端口6', 6, '4', 'image', 265, 4, 14, 8, 'red', 1, 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (25, 'PF4XPS8XGES-E-Seven', 'DPtech', 'PF4XPS8XGES-E端口7', 7, '4', 'image', 265, 19, 14, 8, 'red', 1, 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (26, 'PF4XPS8XGES-E-Eight', 'DPtech', 'PF4XPS8XGES-E端口8', 8, '4', 'image', 279, 4, 14, 8, 'red', 1, 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (27, 'PF4XPS8XGES-E-Nine', 'DPtech', 'PF4XPS8XGES-E端口9', 9, '4', 'image', 279, 19, 14, 8, 'red', 1, 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (28, 'PF4XPS8XGES-E-Ten', 'DPtech', 'PF4XPS8XGES-E端口10', 10, '4', 'image', 292, 4, 14, 8, 'red', 1, 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (29, 'PF4XPS8XGES-E-Eleven', 'DPtech', 'PF4XPS8XGES-E端口11', 11, '4', 'image', 292, 19, 14, 8, 'red', 1, 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (30, 'PF4XPS8XGES-E-Zero', 'DPtech', 'PF4XPS8XGES-E端口0', 0, '4', 'image', 35, 18, 18, 8, 'red', 1, 'PF4XPS8XGES-E-POS.png', 'pos[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (31, 'MPUA-Port1', 'DPtech', 'MPUA主控板默认端口1', 1, '2', 'image', 100, 19, 11, 8, 'red', 1, 'MPUA-Port1.png', 'meth0_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (32, 'S5048E-1', 'H3C', 'H3C S5048E交换机端口1', 1, '6', 'image', 16, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (33, 'S5048E-2', 'H3C', 'H3C S5048E交换机端口2', 2, '6', 'image', 16, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (34, 'S5048E-3', 'H3C', 'H3C S5048E交换机端口3', 3, '6', 'image', 32, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (35, 'S5048E-4', 'H3C', 'H3C S5048E交换机端口4', 4, '6', 'image', 32, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (36, 'S5048E-5', 'H3C', 'H3C S5048E交换机端口5', 5, '6', 'image', 48, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (37, 'S5048E-6', 'H3C', 'H3C S5048E交换机端口6', 6, '6', 'image', 48, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (38, 'S5048E-7', 'H3C', 'H3C S5048E交换机端口7', 7, '6', 'image', 64, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (39, 'S5048E-8', 'H3C', 'H3C S5048E交换机端口8', 8, '6', 'image', 64, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (40, 'S5048E-9', 'H3C', 'H3C S5048E交换机端口9', 9, '6', 'image', 80, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (41, 'S5048E-10', 'H3C', 'H3C S5048E交换机端口10', 10, '6', 'image', 80, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (42, 'S5048E-11', 'H3C', 'H3C S5048E交换机端口11', 11, '6', 'image', 96, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (43, 'S5048E-12', 'H3C', 'H3C S5048E交换机端口12', 12, '6', 'image', 96, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (44, 'S5048E-13', 'H3C', 'H3C S5048E交换机端口13', 13, '6', 'image', 112, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (45, 'S5048E-14', 'H3C', 'H3C S5048E交换机端口14', 14, '6', 'image', 112, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (46, 'S5048E-15', 'H3C', 'H3C S5048E交换机端口15', 15, '6', 'image', 128, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (47, 'S5048E-16', 'H3C', 'H3C S5048E交换机端口16', 16, '6', 'image', 128, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (48, 'S5048E-17', 'H3C', 'H3C S5048E交换机端口17', 17, '6', 'image', 152, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (49, 'S5048E-18', 'H3C', 'H3C S5048E交换机端口18', 18, '6', 'image', 152, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (50, 'S5048E-19', 'H3C', 'H3C S5048E交换机端口19', 19, '6', 'image', 168, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (51, 'S5048E-20', 'H3C', 'H3C S5048E交换机端口20', 20, '6', 'image', 168, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (52, 'S5048E-21', 'H3C', 'H3C S5048E交换机端口21', 21, '6', 'image', 184, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (53, 'S5048E-22', 'H3C', 'H3C S5048E交换机端口22', 22, '6', 'image', 184, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (54, 'S5048E-23', 'H3C', 'H3C S5048E交换机端口23', 23, '6', 'image', 200, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (55, 'S5048E-24', 'H3C', 'H3C S5048E交换机端口24', 24, '6', 'image', 200, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (56, 'S5048E-25', 'H3C', 'H3C S5048E交换机端口25', 25, '6', 'image', 216, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (57, 'S5048E-26', 'H3C', 'H3C S5048E交换机端口26', 26, '6', 'image', 216, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (58, 'S5048E-27', 'H3C', 'H3C S5048E交换机端口27', 27, '6', 'image', 232, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (59, 'S5048E-28', 'H3C', 'H3C S5048E交换机端口28', 28, '6', 'image', 232, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (60, 'S5048E-29', 'H3C', 'H3C S5048E交换机端口29', 29, '6', 'image', 248, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (61, 'S5048E-30', 'H3C', 'H3C S5048E交换机端口30', 30, '6', 'image', 248, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (62, 'S5048E-31', 'H3C', 'H3C S5048E交换机端口31', 31, '6', 'image', 264, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (63, 'S5048E-32', 'H3C', 'H3C S5048E交换机端口32', 32, '6', 'image', 264, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (64, 'S5048E-33', 'H3C', 'H3C S5048E交换机端口33', 33, '6', 'image', 288, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (65, 'S5048E-34', 'H3C', 'H3C S5048E交换机端口34', 34, '6', 'image', 288, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (66, 'S5048E-35', 'H3C', 'H3C S5048E交换机端口35', 35, '6', 'image', 304, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (67, 'S5048E-36', 'H3C', 'H3C S5048E交换机端口36', 36, '6', 'image', 304, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (68, 'S5048E-37', 'H3C', 'H3C S5048E交换机端口37', 37, '6', 'image', 320, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (69, 'S5048E-38', 'H3C', 'H3C S5048E交换机端口38', 38, '6', 'image', 320, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (70, 'S5048E-39', 'H3C', 'H3C S5048E交换机端口39', 39, '6', 'image', 336, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (71, 'S5048E-40', 'H3C', 'H3C S5048E交换机端口40', 40, '6', 'image', 336, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (72, 'S5048E-41', 'H3C', 'H3C S5048E交换机端口41', 41, '6', 'image', 352, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (73, 'S5048E-42', 'H3C', 'H3C S5048E交换机端口42', 42, '6', 'image', 352, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (74, 'S5048E-43', 'H3C', 'H3C S5048E交换机端口43', 43, '6', 'image', 368, 37, 10, 10, 'red', 1, 'S5048E1.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (75, 'S5048E-44', 'H3C', 'H3C S5048E交换机端口44', 44, '6', 'image', 368, 16, 10, 10, 'red', 1, 'S5048E2.png', 'GigabitEthernet0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (76, 'S5048E-45', 'H3C', 'H3C S5048E交换机端口45', 45, '6', 'image', 384, 37, 10, 10, 'red', 1, 'S5048E1.png', 'Copper0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (77, 'S5048E-46', 'H3C', 'H3C S5048E交换机端口46', 46, '6', 'image', 384, 16, 10, 10, 'red', 1, 'S5048E2.png', 'Copper0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (78, 'S5048E-47', 'H3C', 'H3C S5048E交换机端口47', 47, '6', 'image', 400, 37, 10, 10, 'red', 1, 'S5048E1.png', 'Copper0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (79, 'S5048E-48', 'H3C', 'H3C S5048E交换机端口48', 48, '6', 'image', 400, 16, 10, 10, 'red', 1, 'S5048E2.png', 'Copper0/[Y]', to_date('01-03-2013', 'dd-mm-yyyy'), 4, to_date('01-03-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 2, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (80, 'DPX8000-A12-Fan0', 'DPtech', 'DPX8000-A12风扇指示灯0', 0, '1', 'image', 385, 225, 19, 19, 'red', 1, 'DPX8000-A12-Fan.png', '[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_DPSYSTEMFANENTRY', 'DPSYSTEMFANNO', 'DPSYSTEMFANSTAT', '=', 'abnormal', 2, 0, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (81, 'DPX8000-A12-Fan1', 'DPtech', 'DPX8000-A12风扇指示灯1', 1, '1', 'image', 385, 444, 19, 19, 'red', 1, 'DPX8000-A12-Fan.png', '[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_DPSYSTEMFANENTRY', 'DPSYSTEMFANNO', 'DPSYSTEMFANSTAT', '=', 'abnormal', 2, 0, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (82, 'DPX8000-A12-Fan', 'DPtech', 'DPX8000-A12风扇指示灯（暂时没用）', 1, '0', 'image', 200, 300, 10, 10, 'red', 1, 'DPX8000-A12-Fan.png', 'DPX8000-A12-Fan', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (83, 'DPX8000-A12-Power0', 'DPtech', 'DPX8000-A12电源指示灯0', 0, '1', 'image', 76, 516, 18, 20, 'red', 1, 'DPX8000-A12-Power.png', '[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_DPSYSTEMPOWERENTRY', 'DPSYSTEMPOWERNO', 'DPSYSTEMPOWERSTAT', '=', 'abnormal', 2, 0, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (84, 'DPX8000-A12-Power1', 'DPtech', 'DPX8000-A12电源指示灯1', 1, '1', 'image', 76, 562, 18, 20, 'red', 1, 'DPX8000-A12-Power.png', '[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_DPSYSTEMPOWERENTRY', 'DPSYSTEMPOWERNO', 'DPSYSTEMPOWERSTAT', '=', 'abnormal', 2, 0, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (85, 'DPX8000-A12-Power2', 'DPtech', 'DPX8000-A12电源指示灯2', 2, '1', 'image', 291, 516, 18, 20, 'red', 1, 'DPX8000-A12-Power.png', '[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_DPSYSTEMPOWERENTRY', 'DPSYSTEMPOWERNO', 'DPSYSTEMPOWERSTAT', '=', 'abnormal', 2, 0, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (86, 'DPX8000-A12-Power3', 'DPtech', 'DPX8000-A12电源指示灯3', 3, '1', 'image', 291, 562, 18, 20, 'red', 1, 'DPX8000-A12-Power.png', '[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_DPSYSTEMPOWERENTRY', 'DPSYSTEMPOWERNO', 'DPSYSTEMPOWERSTAT', '=', 'abnormal', 2, 0, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (87, 'MPUA_SUB', 'DPtech', '虚拟的第三级设备（测试用）', 1, '0', 'image', 400, 400, 170, 15, 'red', 1, 'MPUA_SUB.png', 'meth0_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 3, 0, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (88, '8XGEP-D-Zero', 'DPtech', '8XGEP-D端口0', 0, '5', 'image', 19, 16, 18, 8, 'red', 1, '8XGEP-D.png', 'pos[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (89, '8XGEP-D-One', 'DPtech', '8XGEP-D端口1', 1, '5', 'image', 59, 16, 18, 8, 'red', 1, '8XGEP-D.png', 'pos[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (90, '8XGEP-D-Two', 'DPtech', '8XGEP-D端口2', 2, '5', 'image', 100, 16, 18, 8, 'red', 1, '8XGEP-D.png', 'pos[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (91, '8XGEP-D-Three', 'DPtech', '8XGEP-D端口3', 3, '5', 'image', 141, 16, 18, 8, 'red', 1, '8XGEP-D.png', 'pos[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (92, '8XGEP-D-Four', 'DPtech', '8XGEP-D端口4', 4, '5', 'image', 184, 16, 18, 8, 'red', 1, '8XGEP-D.png', 'eth[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (93, '8XGEP-D-Five', 'DPtech', '8XGEP-D端口5', 5, '5', 'image', 226, 16, 18, 8, 'red', 1, '8XGEP-D.png', 'eth[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (94, '8XGEP-D-Six', 'DPtech', '8XGEP-D端口6', 6, '5', 'image', 259, 16, 18, 8, 'red', 1, '8XGEP-D.png', 'eth[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (95, '8XGEP-D-Seven', 'DPtech', '8XGEP-D端口7', 7, '5', 'image', 301, 16, 18, 8, 'red', 1, '8XGEP-D.png', 'eth[X]_[Y]', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, 'DI_SWITCHPORT', 'IFDESCR', '', '', '', 3, 1, 1, 1);

insert into device_type_info (ID, DEVICE_TYPE_CODE, DEVICE_RAND_CODE, DEVICE_DESC, SHOW_INDEX, PID, FIGURE_TYPE, FIGURE_X, FIGURE_Y, FIGURE_WIDTH, FIGURE_HEIGHT, FIGURE_STROKE, FIGURE_STROKE_WIDTH, FIGURE_FILL, NAME_FORMAT, ADD_TIME, ADD_USERID, LAST_UPDATE_TIME, LAST_UPDATE_USERID, DI_TABLE_NAME, INDEX_FILED, STATUS_FILED, STATUS_SYMBOLS, STATUS_VALUE, SHOW_LEVEL, IS_LINK, IS_LEAF, MAX_DEVICE_NUM)
values (96, '8XGEP-D-BLANK', 'DPtech', '8XGEP-D空白版', 1, '0', 'image', 30, 30, 354, 34, 'red', 1, '8XGEP-D-BLANK.png', '8XGEP-D-BLANK', to_date('25-02-2013', 'dd-mm-yyyy'), 4, to_date('25-02-2013', 'dd-mm-yyyy'), 4, '', '', '', '', '', 2, 0, 1, 1);

commit;


