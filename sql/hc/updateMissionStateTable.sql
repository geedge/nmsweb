update mission_state_table set look_user_id =null;

alter table mission_state_table modify (Look_user_id varchar(100));
  comment on column mission_state_table.Look_user_id is '查看人ID';