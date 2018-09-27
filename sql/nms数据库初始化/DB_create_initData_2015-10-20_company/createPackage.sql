-------------------------------------------
-- Export file for user NMS              --
-- Created by dell on 2015/5/5, 11:22:56 --
-------------------------------------------

spool createPackage.log

prompt
prompt Creating package PACK_NODELATTICE
prompt =================================
prompt
create or replace package pack_nodelattice as

  -- Author  : ZHENZHEN
  -- Created : 2012-11-13 14:36:23
  -- Purpose : 手动删除 node_table表中的记录时，相应更新 node_lattice_table相关记录

  -- Public type declarations
  type t_seqIds is table of NODE_TABLE.Seq_Id%Type index by binary_integer;

  -- Public variable declarations
  v_nodeSeqs t_seqIds;
  v_numbers binary_integer:=0;

end pack_nodelattice;
/


spool off
