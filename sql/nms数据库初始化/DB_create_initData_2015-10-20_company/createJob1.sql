declare job_id pls_integer;
begin
  sys.dbms_job.submit(job => job_id ,
                      what => 'pro_driver_add_Partition;',
                      next_date => sysdate,
                      interval => 'trunc(sysdate)+7+1/24');
  commit;
end;