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
      IF ( info_new_row.data_check_time < :new.data_check_time )
      THEN info_new_flag := 1;              -- 判断结构开始，当前记录是新更新detection_info_new表
      ELSE info_new_flag := 2;              -- 跳过detection_info_new保存，当前记录非最新纪录，无需更新
      END IF;         --判断结构结束
      
      IF(info_new_flag = 0 or info_new_flag = 1)
      THEN

        --状态变更字段判断
        --如果监测记录的状态变化，或者监测记录状态未变但是报警级别变化
        IF (info_new_row.detectioned_state <> detectioned_state_a or (info_new_row.detectioned_state = detectioned_state_a and info_new_row.police_level <> police_level_a))
        THEN
            :new.status_change_time := data_check_time_a;      -- 新入数据状态变更时间 更新
            status_change_time_a := data_check_time_a;  
        ELSE     --状态无变更时 数据使用new表状态变更时间insert into TESTTRRGGER(ID,DID,TEXT) values(SEQ_testtrrgger.Nextval,:new.id,'开始触发器info_new_row.data_check_time < :new.start_time');
          --判断当前记录是不是正常入库数据，如果和detection_info_new表的记录间隔在两个周期之内为正常数据，大于两个周期则新监测时间为状态变更时间
            status_change_time_a := info_new_row.status_change_time;
            :new.status_change_time := info_new_row.status_change_time;
        END IF;
        
        --状态持续时间为空时，默认取监测时间
        if(status_change_time_a is null) 
        then 
             status_change_time_a := :new.data_check_time;
        end if;
 
        --新状态持续时间为NC监测启动时间
        IF( status_change_time_a < :new.start_time)
        THEN
             status_change_time_a := :new.start_time;
        END IF;
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

end before_insert_detection_info;
