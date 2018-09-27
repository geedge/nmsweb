---------------------------------------------
-- Export file for user NMST               --
-- Created by dell on 2015/10/20, 13:55:40 --
---------------------------------------------

spool createSeq.log

prompt
prompt Creating sequence SEQ_CHECK_TYPE_INFO
prompt =====================================
prompt
create sequence SEQ_CHECK_TYPE_INFO
minvalue 1
maxvalue 999999999999
start with 721
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_CHECK_TYPE_NAME
prompt =====================================
prompt
create sequence SEQ_CHECK_TYPE_NAME
minvalue 1
maxvalue 999999999999999999999999999
start with 1659
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_DATA_POLICE_RELATION
prompt ==========================================
prompt
create sequence SEQ_DATA_POLICE_RELATION
minvalue 1
maxvalue 999999999999
start with 381
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence SEQ_DELECT_INFO_NMSC
prompt ======================================
prompt
create sequence SEQ_DELECT_INFO_NMSC
minvalue 1
maxvalue 999999999999
start with 1447424
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DETECTION_INFO
prompt ====================================
prompt
create sequence SEQ_DETECTION_INFO
minvalue 1
maxvalue 999999999999
start with 44002275
increment by 1000
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DETECTION_INFO_NEW
prompt ========================================
prompt
create sequence SEQ_DETECTION_INFO_NEW
minvalue 1
maxvalue 999999999999999999999999999
start with 5417728
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_DETECTION_INFO_WARNING
prompt ============================================
prompt
create sequence SEQ_DETECTION_INFO_WARNING
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DETECTION_SET_IDEN
prompt ========================================
prompt
create sequence SEQ_DETECTION_SET_IDEN
minvalue 1
maxvalue 999999999999999999999999999
start with 1769
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_DETECTION_SET_INFO
prompt ========================================
prompt
create sequence SEQ_DETECTION_SET_INFO
minvalue 1
maxvalue 999999999999
start with 701
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DETECT_INFO_CPU
prompt =====================================
prompt
create sequence SEQ_DETECT_INFO_CPU
minvalue 1
maxvalue 999999999999
start with 5290346
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DETECT_INFO_DISK
prompt ======================================
prompt
create sequence SEQ_DETECT_INFO_DISK
minvalue 1
maxvalue 999999999999
start with 3508184
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DETECT_INFO_MEMORY
prompt ========================================
prompt
create sequence SEQ_DETECT_INFO_MEMORY
minvalue 1
maxvalue 999999999999
start with 1550649
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DETECT_INFO_NETDATA
prompt =========================================
prompt
create sequence SEQ_DETECT_INFO_NETDATA
minvalue 1
maxvalue 999999999999
start with 1924058
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DETECT_INFO_PING
prompt ======================================
prompt
create sequence SEQ_DETECT_INFO_PING
minvalue 1
maxvalue 999999999999
start with 184969
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DETECT_INFO_PROCESS
prompt =========================================
prompt
create sequence SEQ_DETECT_INFO_PROCESS
minvalue 1
maxvalue 999999999999
start with 420075
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DETECT_INFO_SNMP_TRAP
prompt ===========================================
prompt
create sequence SEQ_DETECT_INFO_SNMP_TRAP
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DETECT_INFO_SYSTEM_DATE
prompt =============================================
prompt
create sequence SEQ_DETECT_INFO_SYSTEM_DATE
minvalue 1
maxvalue 999999999999
start with 455109
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DEVICE_BOARDSOLT_BOARD
prompt ============================================
prompt
create sequence SEQ_DEVICE_BOARDSOLT_BOARD
minvalue 1
maxvalue 999999999999
start with 2159
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DEVICE_BRAND_INFO
prompt =======================================
prompt
create sequence SEQ_DEVICE_BRAND_INFO
minvalue 1
maxvalue 999999999999
start with 344
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DEVICE_BRAND_TYPE
prompt =======================================
prompt
create sequence SEQ_DEVICE_BRAND_TYPE
minvalue 1
maxvalue 999999999999
start with 726
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DEVICE_TYPE_INFO
prompt ======================================
prompt
create sequence SEQ_DEVICE_TYPE_INFO
minvalue 1
maxvalue 999999999999
start with 2381
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DICTIONARY_TABLE
prompt ======================================
prompt
create sequence SEQ_DICTIONARY_TABLE
minvalue 1
maxvalue 999999999999
start with 42927501
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_CHECKSET_GRID
prompt ======================================
prompt
create sequence SEQ_DI_CHECKSET_GRID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_DPBOARDSTATUSENTRY
prompt ===========================================
prompt
create sequence SEQ_DI_DPBOARDSTATUSENTRY
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_DPSLOTENTRY
prompt ====================================
prompt
create sequence SEQ_DI_DPSLOTENTRY
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_DPSYSTEMFANENTRY
prompt =========================================
prompt
create sequence SEQ_DI_DPSYSTEMFANENTRY
minvalue 1
maxvalue 999999999999
start with 341598
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_DPSYSTEMFANENTRY2
prompt ==========================================
prompt
create sequence SEQ_DI_DPSYSTEMFANENTRY2
minvalue 1
maxvalue 999999999999
start with 21
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_DPSYSTEMPOWERENTRY
prompt ===========================================
prompt
create sequence SEQ_DI_DPSYSTEMPOWERENTRY
minvalue 1
maxvalue 999999999999
start with 658052
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_DPSYSTEMPOWERENTRY2
prompt ============================================
prompt
create sequence SEQ_DI_DPSYSTEMPOWERENTRY2
minvalue 1
maxvalue 999999999999
start with 41
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_DPSYSTEMSTATUS
prompt =======================================
prompt
create sequence SEQ_DI_DPSYSTEMSTATUS
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_IFXTABLE
prompt =================================
prompt
create sequence SEQ_DI_IFXTABLE
minvalue 1
maxvalue 999999999999
start with 2001
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_KINGTEST
prompt =================================
prompt
create sequence SEQ_DI_KINGTEST
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_MENCPU
prompt ===============================
prompt
create sequence SEQ_DI_MENCPU
minvalue 1
maxvalue 999999999999
start with 2
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_SWITCHPORT
prompt ===================================
prompt
create sequence SEQ_DI_SWITCHPORT
minvalue 1
maxvalue 999999999999
start with 8939321
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_SYSTEM
prompt ===============================
prompt
create sequence SEQ_DI_SYSTEM
minvalue 1
maxvalue 999999999999
start with 222351
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_SYSTEMINFO
prompt ===================================
prompt
create sequence SEQ_DI_SYSTEMINFO
minvalue 1
maxvalue 999999999999
start with 505650
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_SYSTEMZG
prompt =================================
prompt
create sequence SEQ_DI_SYSTEMZG
minvalue 1
maxvalue 999999999999
start with 2362
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_TCT
prompt ============================
prompt
create sequence SEQ_DI_TCT
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_TCT2
prompt =============================
prompt
create sequence SEQ_DI_TCT2
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_TCT3
prompt =============================
prompt
create sequence SEQ_DI_TCT3
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_TCT4
prompt =============================
prompt
create sequence SEQ_DI_TCT4
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_TESTLOCAL
prompt ==================================
prompt
create sequence SEQ_DI_TESTLOCAL
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_DI_TT_INDEX
prompt =================================
prompt
create sequence SEQ_DI_TT_INDEX
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_EMAIL_TABLE
prompt =================================
prompt
create sequence SEQ_EMAIL_TABLE
minvalue 1
maxvalue 999999999999999999999999999
start with 21783174
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_EVENT_RECORD_LIBRARY
prompt ==========================================
prompt
create sequence SEQ_EVENT_RECORD_LIBRARY
minvalue 1
maxvalue 999999999999999999999999999
start with 10946
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_FAIL_COMMUNICATION_INFO
prompt =============================================
prompt
create sequence SEQ_FAIL_COMMUNICATION_INFO
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_GORUP_SYSTEM_TABLE
prompt ========================================
prompt
create sequence SEQ_GORUP_SYSTEM_TABLE
minvalue 1
maxvalue 999999999999
start with 261
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_IMG_URL
prompt =============================
prompt
create sequence SEQ_IMG_URL
minvalue 1
maxvalue 999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_METADATA
prompt ==============================
prompt
create sequence SEQ_METADATA
minvalue 1
maxvalue 999999999999
start with 963
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_MIB_SORT
prompt ==============================
prompt
create sequence SEQ_MIB_SORT
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_MISSION_FILE_INFORMATION
prompt ==============================================
prompt
create sequence SEQ_MISSION_FILE_INFORMATION
minvalue 1
maxvalue 999999999999999999999999999
start with 2733
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_MISSION_PARAMETER_DEFAULTS
prompt ================================================
prompt
create sequence SEQ_MISSION_PARAMETER_DEFAULTS
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_MISSION_PARAMETER_TABLE1
prompt ==============================================
prompt
create sequence SEQ_MISSION_PARAMETER_TABLE1
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_MISSION_PARAMETER_TABLE2
prompt ==============================================
prompt
create sequence SEQ_MISSION_PARAMETER_TABLE2
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_MISSION_PARAMETER_TABLE3
prompt ==============================================
prompt
create sequence SEQ_MISSION_PARAMETER_TABLE3
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_MISSION_PARAMETER_TABLE4
prompt ==============================================
prompt
create sequence SEQ_MISSION_PARAMETER_TABLE4
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_MISSION_PARAMETER_TABLE5
prompt ==============================================
prompt
create sequence SEQ_MISSION_PARAMETER_TABLE5
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_MISSION_RESULT_TABLE1
prompt ===========================================
prompt
create sequence SEQ_MISSION_RESULT_TABLE1
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_MISSION_RESULT_TABLE2
prompt ===========================================
prompt
create sequence SEQ_MISSION_RESULT_TABLE2
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_MISSION_RESULT_TABLE3
prompt ===========================================
prompt
create sequence SEQ_MISSION_RESULT_TABLE3
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_MISSION_RESULT_TABLE4
prompt ===========================================
prompt
create sequence SEQ_MISSION_RESULT_TABLE4
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_MISSION_RESULT_TABLE5
prompt ===========================================
prompt
create sequence SEQ_MISSION_RESULT_TABLE5
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_MISSION_STATE_TABLE
prompt =========================================
prompt
create sequence SEQ_MISSION_STATE_TABLE
minvalue 1
maxvalue 999999999999
start with 6836
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_NMS_ERROR_CODE
prompt ====================================
prompt
create sequence SEQ_NMS_ERROR_CODE
minvalue 1
maxvalue 999999999999999999999999999
start with 0
increment by -20
nocache;

prompt
prompt Creating sequence SEQ_NMS_ERROR_INFO
prompt ====================================
prompt
create sequence SEQ_NMS_ERROR_INFO
minvalue 1
maxvalue 999999999999
start with 955667
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_NODEGROUP_ARROW_POSITION
prompt ==============================================
prompt
create sequence SEQ_NODEGROUP_ARROW_POSITION
minvalue 1
maxvalue 999999999999
start with 621
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_NODEGROUP_BGIMG_POSITION
prompt ==============================================
prompt
create sequence SEQ_NODEGROUP_BGIMG_POSITION
minvalue 1
maxvalue 999999999999
start with 181
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_NODEGROUP_MEM_TABLE
prompt =========================================
prompt
create sequence SEQ_NODEGROUP_MEM_TABLE
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_NODEGROUP_POSITION
prompt ========================================
prompt
create sequence SEQ_NODEGROUP_POSITION
minvalue 1
maxvalue 999999999999
start with 801
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_NODEGROUP_TABLE
prompt =====================================
prompt
create sequence SEQ_NODEGROUP_TABLE
minvalue 1
maxvalue 999999999999
start with 361
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_NODE_BOX_TABLE
prompt ====================================
prompt
create sequence SEQ_NODE_BOX_TABLE
minvalue 1
maxvalue 999999999999
start with 301
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_NODE_FIGURE_INFO
prompt ======================================
prompt
create sequence SEQ_NODE_FIGURE_INFO
minvalue 1
maxvalue 999999999999
start with 22369
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_NODE_IP_TABLE
prompt ===================================
prompt
create sequence SEQ_NODE_IP_TABLE
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_NODE_LATTICE_TABLE
prompt ========================================
prompt
create sequence SEQ_NODE_LATTICE_TABLE
minvalue 1
maxvalue 999999999999
start with 99841
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_NODE_POSITION
prompt ===================================
prompt
create sequence SEQ_NODE_POSITION
minvalue 1
maxvalue 999999999999
start with 161
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_NODE_ROOM_LATTICE_TABLE
prompt =============================================
prompt
create sequence SEQ_NODE_ROOM_LATTICE_TABLE
minvalue 1
maxvalue 999999999999999999999999999
start with 5101
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_NODE_ROOM_TABLE
prompt =====================================
prompt
create sequence SEQ_NODE_ROOM_TABLE
minvalue 1
maxvalue 999999999999999999999999999
start with 261
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_NODE_TABLE
prompt ================================
prompt
create sequence SEQ_NODE_TABLE
minvalue 1
maxvalue 999999999999
start with 1681
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_OID_DICTIONARY
prompt ====================================
prompt
create sequence SEQ_OID_DICTIONARY
minvalue 1
maxvalue 99999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_OPTION_TABLE
prompt ==================================
prompt
create sequence SEQ_OPTION_TABLE
minvalue 1
maxvalue 9999999999999
start with 231
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_ORDER_TABLE
prompt =================================
prompt
create sequence SEQ_ORDER_TABLE
minvalue 1
maxvalue 999999999999
start with 21
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_PLUGIN_INFO
prompt =================================
prompt
create sequence SEQ_PLUGIN_INFO
minvalue 1
maxvalue 999999999999999999999999999
start with 120
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_POLICE_POINT_SET
prompt ======================================
prompt
create sequence SEQ_POLICE_POINT_SET
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_PROCEDURE_LOG
prompt ===================================
prompt
create sequence SEQ_PROCEDURE_LOG
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_PROEXECINFO
prompt =================================
prompt
create sequence SEQ_PROEXECINFO
minvalue 1
maxvalue 999999999999
start with 1528
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_PRO_EXEC_LOG
prompt ==================================
prompt
create sequence SEQ_PRO_EXEC_LOG
minvalue 1
maxvalue 999999999999999999999999999
start with 386509
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SEQ_ID
prompt ============================
prompt
create sequence SEQ_SEQ_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1581
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SERVER_IP_SEGMENT
prompt =======================================
prompt
create sequence SEQ_SERVER_IP_SEGMENT
minvalue 1
maxvalue 999999999999999999999999999
start with 1082
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SERVER_TABLE
prompt ==================================
prompt
create sequence SEQ_SERVER_TABLE
minvalue 1
maxvalue 999999999999999999999999999
start with 241
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SET_DET_DATA_CON
prompt ======================================
prompt
create sequence SEQ_SET_DET_DATA_CON
minvalue 1
maxvalue 99999999999999999
start with 6
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_SORT_INFO
prompt ===============================
prompt
create sequence SEQ_SORT_INFO
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_SYSTEM_TABLE
prompt ==================================
prompt
create sequence SEQ_SYSTEM_TABLE
minvalue 1
maxvalue 999999999999
start with 464
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_TABLEDBOPERATIONRPT
prompt =========================================
prompt
create sequence SEQ_TABLEDBOPERATIONRPT
minvalue 1
maxvalue 999999999999
start with 50119
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_TABLEDEPARTMENT
prompt =====================================
prompt
create sequence SEQ_TABLEDEPARTMENT
minvalue 1
maxvalue 999999999999
start with 121
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_TABLELOGINRPT
prompt ===================================
prompt
create sequence SEQ_TABLELOGINRPT
minvalue 1
maxvalue 999999999999
start with 9491
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_TABLEUSERDEPARTMENT
prompt =========================================
prompt
create sequence SEQ_TABLEUSERDEPARTMENT
minvalue 1
maxvalue 999999999999
start with 602
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_TABLE_GUIDE
prompt =================================
prompt
create sequence SEQ_TABLE_GUIDE
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_TESTTRRGGER
prompt =================================
prompt
create sequence SEQ_TESTTRRGGER
minvalue 1
maxvalue 999999999999
start with 894703
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_TEST_BONECP_ZG
prompt ====================================
prompt
create sequence SEQ_TEST_BONECP_ZG
minvalue 1
maxvalue 999999999999999999999999999
start with 2294621
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TROUBLE_STATE
prompt ===================================
prompt
create sequence SEQ_TROUBLE_STATE
minvalue 1
maxvalue 9999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TYPE_TABLE
prompt ================================
prompt
create sequence SEQ_TYPE_TABLE
minvalue 1
maxvalue 99999999999999999
start with 284
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_XT_JS_JBXX
prompt ================================
prompt
create sequence SEQ_XT_JS_JBXX
minvalue 1
maxvalue 999999999999
start with 227
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_XT_JS_MK_GN_INDEX
prompt =======================================
prompt
create sequence SEQ_XT_JS_MK_GN_INDEX
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_XT_JS_MK_INDEX
prompt ====================================
prompt
create sequence SEQ_XT_JS_MK_INDEX
minvalue 1
maxvalue 999999999999
start with 8380
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_XT_MK_GN_JBXX
prompt ===================================
prompt
create sequence SEQ_XT_MK_GN_JBXX
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_XT_MK_JBXX
prompt ================================
prompt
create sequence SEQ_XT_MK_JBXX
minvalue 1
maxvalue 999999999999
start with 570
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_XT_YH_JBXX
prompt ================================
prompt
create sequence SEQ_XT_YH_JBXX
minvalue 1
maxvalue 999999999999
start with 241
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence SEQ_XT_YH_JS_INDEX
prompt ====================================
prompt
create sequence SEQ_XT_YH_JS_INDEX
minvalue 1
maxvalue 999999999999
start with 601
increment by 1
cache 20
cycle
order;


spool off
