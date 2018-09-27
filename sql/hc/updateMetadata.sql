update metadata set SORT_SIGN=1 where TABLE_NAME='DI_SWITCHPORT' and FILED_NAME='ifIndex' and check_type_id = 10;
update metadata set SORT_SIGN=0 where TABLE_NAME='DI_SWITCHPORT' and FILED_NAME='ifDescr' and check_type_id = 10;
commit;
