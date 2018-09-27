

-- ----------------------------
-- Records of check_type_info
-- ----------------------------
INSERT INTO `check_type_info` VALUES ('0', 'systeminfo', null, null, 'DI_SYSTEMINFO', '0', 'i18n_check_type_info.systeminfo.TABLE_DESC_n81i', '0', '2013-01-31 16:40:12', '4', null, '1', null, null, null, 'i18n_check_type_info.systeminfo.CHECK_TYPE_NAME1_n81i');
INSERT INTO `check_type_info` VALUES ('1', 'cpu', 'total_used_perc', 'cpu', 'DETECT_INFO_CPU', '0', null, '0', null, '4', null, '1', null, null, null, 'i18n_check_type_info.cpu.CHECK_TYPE_NAME1_n81i');
INSERT INTO `check_type_info` VALUES ('2', 'memory', 'used_memory_perc', 'memory', 'DETECT_INFO_MEMORY', '0', null, '0', null, '4', null, '1', null, null, null, 'i18n_check_type_info.memory.CHECK_TYPE_NAME1_n81i');
INSERT INTO `check_type_info` VALUES ('3', 'disk', 'used_disk_perc', 'disk', 'DETECT_INFO_DISK', '0', null, '0', null, '4', null, '1', null, null, null, 'i18n_check_type_info.disk.CHECK_TYPE_NAME1_n81i');
INSERT INTO `check_type_info` VALUES ('4', 'net', 'rx_dropped', 'net', 'DETECT_INFO_NETDATA', '0', null, '0', null, '4', null, '1', null, null, null, 'i18n_check_type_info.net.CHECK_TYPE_NAME1_n81i');
INSERT INTO `check_type_info` VALUES ('5', 'systemdate', 'time_delay', 'systemdate', 'DETECT_INFO_SYSTEM_DATE', '0', null, '0', null, '4', null, '1', null, null, null, 'i18n_check_type_info.systemdate.CHECK_TYPE_NAME1_n81i');
INSERT INTO `check_type_info` VALUES ('6', 'PING', 'packets_lost_rate', 'ping', 'DETECT_INFO_PING', '0', null, '0', null, '4', null, '1', null, null, null, 'i18n_check_type_info.PING.CHECK_TYPE_NAME1_n81i');
INSERT INTO `check_type_info` VALUES ('7', 'NMSClient', null, null, 'DELECT_INFO_NMSC', '0', 'i18n_check_type_info.NMSClient.TABLE_DESC_n81i', '0', null, '4', null, '1', null, null, null, 'i18n_check_type_info.NMSClient.CHECK_TYPE_NAME1_n81i');
INSERT INTO `check_type_info` VALUES ('8', 'process', null, null, 'DETECT_INFO_PROCESS', '0', 'i18n_check_type_info.process.TABLE_DESC_n81i', '0', null, '4', null, '1', null, null, null, 'i18n_check_type_info.process.CHECK_TYPE_NAME1_n81i');
INSERT INTO `check_type_info` VALUES ('9', 'SYSTEM', null, null, 'DI_SYSTEM', '0', 'i18n_check_type_info.SYSTEM.TABLE_DESC_n81i', '0', '2012-11-27 13:41:11', '4', null, '580', '192', '1', '1.3.6.1.2.1.1', 'SYSTEM');
INSERT INTO `check_type_info` VALUES ('10', 'switchport', null, null, 'DI_SWITCHPORT', '0', null, '0', '2012-11-13 10:03:24', '4', null, '539', '192', '1', '1.3.6.1.2.1.2.2.1', 'i18n_check_type_info.switchport.CHECK_TYPE_NAME1_n81i');
INSERT INTO `check_type_info` VALUES ('11', 'SNMP_TRAP', null, 'i18n_check_type_info.SNMP_TRAP.CHECK_REMARK_n81i', 'DETECT_INFO_SNMP_TRAP', '1', 'i18n_check_type_info.SNMP_TRAP.TABLE_DESC_n81i', '2', '2012-05-07 14:18:28', '4', null, '44', '-1', '2', null, null);
INSERT INTO `check_type_info` VALUES ('17', 'ifXTable', null, null, 'DI_IFXTABLE', '0', null, '1', '2013-03-18 15:05:53', '4', null, '1', '1', '1', '1.3.6.1.2.1.31.1.1.1', 'ifXTable');


-- ----------------------------
-- Records of data_police_relation
-- ----------------------------
INSERT INTO `data_police_relation` VALUES ('1', '6', '52', '0', '50', '%', '>=', '0', '', '0', '', '52');
INSERT INTO `data_police_relation` VALUES ('2', '7', '58', '0', '1', 'i18n_POLICE_UNIT_n81i', '=', '0', 'i18n_data_police_relation.2.POLICE_SHOW_INFO_n81i', '0', null, null);



-- ----------------------------
-- Records of delect_info_nmsc
-- ----------------------------



-- ----------------------------
-- Records of detection_info
-- ----------------------------



-- ----------------------------
-- Records of detection_info_new
-- ----------------------------



-- ----------------------------
-- Records of detection_info_warning
-- ----------------------------



-- ----------------------------
-- Records of detection_set_info
-- ----------------------------
INSERT INTO `detection_set_info` VALUES ('0', '', '0', '15', '1', '0', '3', 'servicessysinfo', '1', '', '', null, '1', null, null, null, null, null, null, null, '4', '', '1', null, '-1', '', '', 'i18n_detection_set_info.servicessysinfo.PROCESS_IDEN_NAME_n81i', '');
INSERT INTO `detection_set_info` VALUES ('1', null, '1', '5', '1', '0', '3', 'cpu', '1', null, null, null, '1', null, null, null, null, null, null, null, '4', null, '1', null, '-1', null, null, 'i18n_detection_set_info.cpu.PROCESS_IDEN_NAME_n81i', null);
INSERT INTO `detection_set_info` VALUES ('2', null, '2', '5', '1', '0', '3', 'memory', '1', null, null, null, '1', null, null, null, null, null, null, null, '4', null, '1', null, '-1', null, null, 'i18n_detection_set_info.memory.PROCESS_IDEN_NAME_n81i', null);
INSERT INTO `detection_set_info` VALUES ('3', null, '3', '5', '1', '0', '3', 'disk', '1', null, null, null, '1', null, null, null, null, null, null, null, '4', null, '1', null, '-1', null, null, 'i18n_detection_set_info.disk.PROCESS_IDEN_NAME_n81i', null);
INSERT INTO `detection_set_info` VALUES ('4', null, '4', '5', '1', '0', '3', 'net', '1', null, null, null, '1', null, null, null, null, null, null, null, '4', null, '1', null, '-1', null, null, 'i18n_detection_set_info.net.PROCESS_IDEN_NAME_n81i', null);
INSERT INTO `detection_set_info` VALUES ('5', '', '5', '5', '0', '0', '3', 'systemdate', '1', '', '', null, '1', null, null, null, null, null, null, null, '4', '', '1', null, '-1', '', '', 'i18n_detection_set_info.systemdate.PROCESS_IDEN_NAME_n81i', '');
INSERT INTO `detection_set_info` VALUES ('6', null, '6', '5', '0', '0', '3', 'ping', '0', null, null, null, '1', '1', '1', null, null, null, null, null, '4', null, '1', null, '-1', null, null, 'PING', null);
INSERT INTO `detection_set_info` VALUES ('7', null, '7', '5', '0', '0', '3', 'nmsclient', '1', null, null, null, '1', null, null, null, null, null, null, null, '4', null, '1', null, '-1', null, null, 'i18n_detection_set_info.nmsclient.PROCESS_IDEN_NAME_n81i', null);
INSERT INTO `detection_set_info` VALUES ('8', null, '9', '5', '0', '10', '3', 'SYSTEM', '0', null, null, null, '0', null, null, null, null, null, null, null, '4', null, '1', null, '-1', null, null, 'i18n_detection_set_info.SYSTEM.PROCESS_IDEN_NAME_n81i', null);
INSERT INTO `detection_set_info` VALUES ('9', null, '10', '5', '0', '10', '3', 'switchport', '0', null, null, null, '0', null, null, null, null, null, null, null, '4', null, '1', null, '-1', null, null, 'i18n_detection_set_info.switchport.PROCESS_IDEN_NAME_n81i', null);



-- ----------------------------
-- Records of detect_info_cpu
-- ----------------------------


-- ----------------------------
-- Records of detect_info_disk
-- ----------------------------



-- ----------------------------
-- Records of detect_info_memory
-- ----------------------------



-- ----------------------------
-- Records of detect_info_netdata
-- ----------------------------



-- ----------------------------
-- Records of detect_info_ping
-- ----------------------------


-- ----------------------------
-- Records of detect_info_port
-- ----------------------------



-- ----------------------------
-- Records of detect_info_process
-- ----------------------------



-- ----------------------------
-- Records of detect_info_snmp_trap
-- ----------------------------


-- ----------------------------
-- Records of detect_info_system_date
-- ----------------------------



-- ----------------------------
-- Records of device_boardsolt_board
-- ----------------------------

INSERT INTO `device_boardsolt_board` VALUES ('100016', 'SINOVATIO', 'SINOVATIO_9012-4', 'SINOVATIO_9012-2LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100017', 'SINOVATIO', 'SINOVATIO_9012-4', 'SINOVATIO_9012-4LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100018', 'SINOVATIO', 'SINOVATIO_9012-4', 'SINOVATIO_9012-10g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100019', 'SINOVATIO', 'SINOVATIO_9012-4', 'SINOVATIO_9012-100g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100044', 'SINOVATIO', 'SINOVATIO_9012-13', 'SINOVATIO_9012-2LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100045', 'SINOVATIO', 'SINOVATIO_9012-13', 'SINOVATIO_9012-4LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100046', 'SINOVATIO', 'SINOVATIO_9012-13', 'SINOVATIO_9012-10g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100047', 'SINOVATIO', 'SINOVATIO_9012-13', 'SINOVATIO_9012-100g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100052', 'SINOVATIO', 'SINOVATIO_9012-1', 'SINOVATIO_9012-2LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100053', 'SINOVATIO', 'SINOVATIO_9012-1', 'SINOVATIO_9012-4LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100054', 'SINOVATIO', 'SINOVATIO_9012-1', 'SINOVATIO_9012-10g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100055', 'SINOVATIO', 'SINOVATIO_9012-1', 'SINOVATIO_9012-100g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100056', 'SINOVATIO', 'SINOVATIO_9012-2', 'SINOVATIO_9012-2LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100057', 'SINOVATIO', 'SINOVATIO_9012-2', 'SINOVATIO_9012-4LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100058', 'SINOVATIO', 'SINOVATIO_9012-2', 'SINOVATIO_9012-10g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100059', 'SINOVATIO', 'SINOVATIO_9012-2', 'SINOVATIO_9012-100g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100060', 'SINOVATIO', 'SINOVATIO_9012-3', 'SINOVATIO_9012-2LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100061', 'SINOVATIO', 'SINOVATIO_9012-3', 'SINOVATIO_9012-4LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100062', 'SINOVATIO', 'SINOVATIO_9012-3', 'SINOVATIO_9012-10g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100063', 'SINOVATIO', 'SINOVATIO_9012-3', 'SINOVATIO_9012-100g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100064', 'SINOVATIO', 'SINOVATIO_9012-5', 'SINOVATIO_9012-2LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100065', 'SINOVATIO', 'SINOVATIO_9012-5', 'SINOVATIO_9012-4LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100066', 'SINOVATIO', 'SINOVATIO_9012-5', 'SINOVATIO_9012-10g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100067', 'SINOVATIO', 'SINOVATIO_9012-5', 'SINOVATIO_9012-100g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100068', 'SINOVATIO', 'SINOVATIO_9012-6', 'SINOVATIO_9012-2LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100069', 'SINOVATIO', 'SINOVATIO_9012-6', 'SINOVATIO_9012-4LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100070', 'SINOVATIO', 'SINOVATIO_9012-6', 'SINOVATIO_9012-10g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100071', 'SINOVATIO', 'SINOVATIO_9012-6', 'SINOVATIO_9012-100g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100072', 'SINOVATIO', 'SINOVATIO_9012-9', 'SINOVATIO_9012-2LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100073', 'SINOVATIO', 'SINOVATIO_9012-9', 'SINOVATIO_9012-4LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100074', 'SINOVATIO', 'SINOVATIO_9012-9', 'SINOVATIO_9012-10g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100075', 'SINOVATIO', 'SINOVATIO_9012-9', 'SINOVATIO_9012-100g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100076', 'SINOVATIO', 'SINOVATIO_9012-10', 'SINOVATIO_9012-2LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100077', 'SINOVATIO', 'SINOVATIO_9012-10', 'SINOVATIO_9012-4LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100078', 'SINOVATIO', 'SINOVATIO_9012-10', 'SINOVATIO_9012-10g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100079', 'SINOVATIO', 'SINOVATIO_9012-10', 'SINOVATIO_9012-100g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100080', 'SINOVATIO', 'SINOVATIO_9012-11', 'SINOVATIO_9012-2LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100081', 'SINOVATIO', 'SINOVATIO_9012-11', 'SINOVATIO_9012-4LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100082', 'SINOVATIO', 'SINOVATIO_9012-11', 'SINOVATIO_9012-10g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100083', 'SINOVATIO', 'SINOVATIO_9012-11', 'SINOVATIO_9012-100g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100084', 'SINOVATIO', 'SINOVATIO_9012-12', 'SINOVATIO_9012-2LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100085', 'SINOVATIO', 'SINOVATIO_9012-12', 'SINOVATIO_9012-4LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100086', 'SINOVATIO', 'SINOVATIO_9012-12', 'SINOVATIO_9012-10g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100087', 'SINOVATIO', 'SINOVATIO_9012-12', 'SINOVATIO_9012-100g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100088', 'SINOVATIO', 'SINOVATIO_9012-14', 'SINOVATIO_9012-2LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100089', 'SINOVATIO', 'SINOVATIO_9012-14', 'SINOVATIO_9012-4LIGHT', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100090', 'SINOVATIO', 'SINOVATIO_9012-14', 'SINOVATIO_9012-10g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100091', 'SINOVATIO', 'SINOVATIO_9012-14', 'SINOVATIO_9012-100g', 'SINOVATIO_9012');
INSERT INTO `device_boardsolt_board` VALUES ('100092', 'SUGON', 'FF-N3100-1', 'FF-N3100-W10G_BUSINESS', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100093', 'SUGON', 'FF-N3100-1', 'FF-N3100-W100G_BUSINESS', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100094', 'SUGON', 'FF-N3100-1', 'FF-N3100-WBLANK', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100095', 'SUGON', 'FF-N3100-1', 'FF-N3100-WPROTECT', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100096', 'SUGON', 'FF-N3100-1', 'FF-N3100-WSWITCH', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100097', 'SUGON', 'FF-N3100-2', 'FF-N3100-W10G_BUSINESS', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100098', 'SUGON', 'FF-N3100-2', 'FF-N3100-W100G_BUSINESS', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100099', 'SUGON', 'FF-N3100-2', 'FF-N3100-WBLANK', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100100', 'SUGON', 'FF-N3100-2', 'FF-N3100-WPROTECT', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100101', 'SUGON', 'FF-N3100-2', 'FF-N3100-WSWITCH', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100102', 'SUGON', 'FF-N3100-3', 'FF-N3100-W10G_BUSINESS', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100103', 'SUGON', 'FF-N3100-3', 'FF-N3100-W100G_BUSINESS', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100104', 'SUGON', 'FF-N3100-3', 'FF-N3100-WBLANK', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100105', 'SUGON', 'FF-N3100-3', 'FF-N3100-WPROTECT', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100106', 'SUGON', 'FF-N3100-3', 'FF-N3100-WSWITCH', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100107', 'SUGON', 'FF-N3100-4', 'FF-N3100-NBLANK', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100108', 'SUGON', 'FF-N3100-4', 'FF-N3100-NMANAGER', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100109', 'SUGON', 'FF-N3100-5', 'FF-N3100-NBLANK', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100110', 'SUGON', 'FF-N3100-5', 'FF-N3100-NMANAGER', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100111', 'SUGON', 'FF-N3100-6', 'FF-N3100-W10G_BUSINESS', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100112', 'SUGON', 'FF-N3100-6', 'FF-N3100-W100G_BUSINESS', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100113', 'SUGON', 'FF-N3100-6', 'FF-N3100-WBLANK', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100114', 'SUGON', 'FF-N3100-6', 'FF-N3100-WPROTECT', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100115', 'SUGON', 'FF-N3100-6', 'FF-N3100-WSWITCH', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100116', 'SUGON', 'FF-N3100-7', 'FF-N3100-W10G_BUSINESS', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100117', 'SUGON', 'FF-N3100-7', 'FF-N3100-W100G_BUSINESS', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100118', 'SUGON', 'FF-N3100-7', 'FF-N3100-WBLANK', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100119', 'SUGON', 'FF-N3100-7', 'FF-N3100-WPROTECT', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100120', 'SUGON', 'FF-N3100-7', 'FF-N3100-WSWITCH', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100121', 'SUGON', 'FF-N3100-8', 'FF-N3100-W10G_BUSINESS', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100122', 'SUGON', 'FF-N3100-8', 'FF-N3100-W100G_BUSINESS', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100123', 'SUGON', 'FF-N3100-8', 'FF-N3100-WBLANK', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100124', 'SUGON', 'FF-N3100-8', 'FF-N3100-WPROTECT', 'FF-N3100');
INSERT INTO `device_boardsolt_board` VALUES ('100125', 'SUGON', 'FF-N3100-8', 'FF-N3100-WSWITCH', 'FF-N3100');



-- ----------------------------
-- Records of device_brand_info
-- ----------------------------
INSERT INTO `device_brand_info` VALUES ('100000', 'SUGON', 'SUGON', 'SUGON', '2018-07-10 15:01:43', '1', '2018-07-10 15:01:43', '1');
INSERT INTO `device_brand_info` VALUES ('100001', 'SINOVATIO', 'SINOVATIO', 'SINOVATIO', '2018-07-10 15:02:04', '1', '2018-07-10 15:02:04', '1');



-- ----------------------------
-- Records of device_brand_type
-- ----------------------------
INSERT INTO `device_brand_type` VALUES ('100000', 'SINOVATIO', 'SINOVATIO_9012', 'SINOVATIO_9012-2LIGHT');
INSERT INTO `device_brand_type` VALUES ('100001', 'SINOVATIO', 'SINOVATIO_9012', 'SINOVATIO_9012-4LIGHT');
INSERT INTO `device_brand_type` VALUES ('100002', 'SINOVATIO', 'SINOVATIO_9012', 'SINOVATIO_9012-10g');
INSERT INTO `device_brand_type` VALUES ('100003', 'SINOVATIO', 'SINOVATIO_9012', 'SINOVATIO_9012-100g');
INSERT INTO `device_brand_type` VALUES ('100004', 'SUGON', 'FF-N3100', 'FF-N3100-NBLANK');
INSERT INTO `device_brand_type` VALUES ('100005', 'SUGON', 'FF-N3100', 'FF-N3100-NMANAGER');
INSERT INTO `device_brand_type` VALUES ('100006', 'SUGON', 'FF-N3100', 'FF-N3100-W10G_BUSINESS');
INSERT INTO `device_brand_type` VALUES ('100007', 'SUGON', 'FF-N3100', 'FF-N3100-W100G_BUSINESS');
INSERT INTO `device_brand_type` VALUES ('100008', 'SUGON', 'FF-N3100', 'FF-N3100-WBLANK');
INSERT INTO `device_brand_type` VALUES ('100009', 'SUGON', 'FF-N3100', 'FF-N3100-WPROTECT');
INSERT INTO `device_brand_type` VALUES ('100010', 'SUGON', 'FF-N3100', 'FF-N3100-WSWITCH');



-- ----------------------------
-- Records of device_info
-- ----------------------------



-- ----------------------------
-- Records of device_type_info
-- ----------------------------
INSERT INTO `device_type_info` VALUES ('1', 'DPX8000-A12', 'DPtech', 'DPtech DPX8000-A12分流设备', '1', '0', 'image', '35', '0', '432', '607', 'red', '1', 'DPX8000-A12.png', 'DPX8000-A12', '2013-02-25 00:00:00', '4', '2013-05-30 12:51:58', '81', 'DI_SYSTEM', null, null, null, null, '1', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('2', 'MPUA', 'DPtech', 'MPUA主控板在DPX8000系列产品中起主导作用，实现系统的初始化配置、管理以及控制报文的处理等。', '1', '0', 'image', '10', '10', '354', '34', 'red', '1', 'MPUA.png', 'MPUA', '2013-02-25 00:00:00', '4', '2013-05-30 12:51:59', '81', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('3', 'DPX8000-A12-One', 'DPtech', 'DPX8000-A12默认槽位', '1', '1', 'image', '26', '47', '354', '34', 'red', '1', 'DPX8000-A12.png', 'DPX8000-A12', '2013-02-25 00:00:00', '4', '2013-05-30 12:51:59', '81', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('4', 'PF4XPS8XGES-E', 'DPtech', '分流业务板（PF4XPS8XGES-E），插在业务槽位，提供4个XFP 10GE  POS光接口，8个万兆以太网光接口(SFP+)。', '1', '0', 'image', '10', '10', '354', '34', 'red', '1', 'PF4XPS8XGES-E.png', 'PF4XPS8XGES-E', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('5', '8XGEP-D', 'DPtech', '接口板（8XGEP-D）插在业务槽位，提供8个XFP 10GE以太网光接口。', '1', '0', 'image', '20', '50', '354', '34', 'red', '1', '8XGEP-D.png', '8XGEP-D', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('6', 'S5048E', 'H3C', 'H3C S5048E交换机', '1', '0', 'image', '0', '25', '500', '60', 'red', '1', 'S5048E.png', 'S5048E', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SYSTEM', null, null, null, null, '1', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('7', 'DPX8000-A12-Two', 'DPtech', 'DPX8000-A12默认槽位2', '2', '1', 'image', '26', '83', '354', '34', 'red', '1', 'DPX8000-A12.png', 'DPX8000-A12', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('8', 'DPX8000-A12-Three', 'DPtech', 'DPX8000-A12默认槽位3', '3', '1', 'image', '26', '120', '354', '34', 'red', '1', 'DPX8000-A12.png', 'DPX8000-A12', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('9', 'DPX8000-A12-Four', 'DPtech', 'DPX8000-A12默认槽位4', '4', '1', 'image', '26', '157', '354', '34', 'red', '1', 'DPX8000-A12.png', 'DPX8000-A12', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('10', 'DPX8000-A12-Five', 'DPtech', 'DPX8000-A12默认槽位5', '5', '1', 'image', '26', '194', '354', '34', 'red', '1', 'DPX8000-A12.png', 'DPX8000-A12', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('11', 'DPX8000-A12-Six', 'DPtech', 'DPX8000-A12默认槽位6', '6', '1', 'image', '26', '231', '354', '34', 'red', '1', 'DPX8000-A12.png', 'DPX8000-A12', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('12', 'DPX8000-A12-Seven', 'DPtech', 'DPX8000-A12默认槽位7', '7', '1', 'image', '26', '268', '354', '34', 'red', '1', 'DPX8000-A12.png', 'DPX8000-A12', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('13', 'DPX8000-A12-Eight', 'DPtech', 'DPX8000-A12默认槽位8', '8', '1', 'image', '26', '305', '354', '34', 'red', '1', 'DPX8000-A12.png', 'DPX8000-A12', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('14', 'DPX8000-A12-Nine', 'DPtech', 'DPX8000-A12默认槽位9', '9', '1', 'image', '26', '342', '354', '34', 'red', '1', 'DPX8000-A12.png', 'DPX8000-A12', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('15', 'DPX8000-A12-Ten', 'DPtech', 'DPX8000-A12默认槽位10', '10', '1', 'image', '26', '379', '354', '34', 'red', '1', 'DPX8000-A12.png', 'DPX8000-A12', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('16', 'DPX8000-A12-Eleven', 'DPtech', 'DPX8000-A12默认槽位11', '11', '1', 'image', '26', '415', '354', '34', 'red', '1', 'DPX8000-A12.png', 'DPX8000-A12', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('17', 'DPX8000-A12-Twelve', 'DPtech', 'DPX8000-A12默认槽位12', '12', '1', 'image', '26', '452', '354', '34', 'red', '1', 'DPX8000-A12.png', 'DPX8000-A12', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('18', 'MPUA-Port0', 'DPtech', 'MPUA主控板默认端口0', '0', '2', 'image', '100', '6', '11', '8', 'red', '1', 'MPUA-Port0.png', 'meth0_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('19', 'PF4XPS8XGES-E-One', 'DPtech', 'PF4XPS8XGES-E端口1', '1', '4', 'image', '87', '18', '18', '8', 'red', '1', 'PF4XPS8XGES-E-POS.png', 'pos[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('20', 'PF4XPS8XGES-E-Two', 'DPtech', 'PF4XPS8XGES-E端口2', '2', '4', 'image', '141', '18', '18', '8', 'red', '1', 'PF4XPS8XGES-E-POS.png', 'pos[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('21', 'PF4XPS8XGES-E-Three', 'DPtech', 'PF4XPS8XGES-E端口3', '3', '4', 'image', '193', '18', '18', '8', 'red', '1', 'PF4XPS8XGES-E-POS.png', 'pos[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('22', 'PF4XPS8XGES-E-Four', 'DPtech', 'PF4XPS8XGES-E端口4', '4', '4', 'image', '252', '4', '14', '8', 'red', '1', 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('23', 'PF4XPS8XGES-E-Five', 'DPtech', 'PF4XPS8XGES-E端口5', '5', '4', 'image', '252', '19', '14', '8', 'red', '1', 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('24', 'PF4XPS8XGES-E-Six', 'DPtech', 'PF4XPS8XGES-E端口6', '6', '4', 'image', '265', '4', '14', '8', 'red', '1', 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('25', 'PF4XPS8XGES-E-Seven', 'DPtech', 'PF4XPS8XGES-E端口7', '7', '4', 'image', '265', '19', '14', '8', 'red', '1', 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('26', 'PF4XPS8XGES-E-Eight', 'DPtech', 'PF4XPS8XGES-E端口8', '8', '4', 'image', '279', '4', '14', '8', 'red', '1', 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('27', 'PF4XPS8XGES-E-Nine', 'DPtech', 'PF4XPS8XGES-E端口9', '9', '4', 'image', '279', '19', '14', '8', 'red', '1', 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('28', 'PF4XPS8XGES-E-Ten', 'DPtech', 'PF4XPS8XGES-E端口10', '10', '4', 'image', '292', '4', '14', '8', 'red', '1', 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('29', 'PF4XPS8XGES-E-Eleven', 'DPtech', 'PF4XPS8XGES-E端口11', '11', '4', 'image', '292', '19', '14', '8', 'red', '1', 'PF4XPS8XGES-E-Eth.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('30', 'PF4XPS8XGES-E-Zero', 'DPtech', 'PF4XPS8XGES-E端口0', '0', '4', 'image', '35', '18', '18', '8', 'red', '1', 'PF4XPS8XGES-E-POS.png', 'pos[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('31', 'MPUA-Port1', 'DPtech', 'MPUA主控板默认端口1', '1', '2', 'image', '100', '19', '11', '8', 'red', '1', 'MPUA-Port1.png', 'meth0_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('32', 'S5048E-1', 'H3C', 'H3C S5048E交换机端口1', '1', '6', 'image', '16', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('33', 'S5048E-2', 'H3C', 'H3C S5048E交换机端口2', '2', '6', 'image', '16', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('34', 'S5048E-3', 'H3C', 'H3C S5048E交换机端口3', '3', '6', 'image', '32', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('35', 'S5048E-4', 'H3C', 'H3C S5048E交换机端口4', '4', '6', 'image', '32', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('36', 'S5048E-5', 'H3C', 'H3C S5048E交换机端口5', '5', '6', 'image', '48', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('37', 'S5048E-6', 'H3C', 'H3C S5048E交换机端口6', '6', '6', 'image', '48', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('38', 'S5048E-7', 'H3C', 'H3C S5048E交换机端口7', '7', '6', 'image', '64', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('39', 'S5048E-8', 'H3C', 'H3C S5048E交换机端口8', '8', '6', 'image', '64', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('40', 'S5048E-9', 'H3C', 'H3C S5048E交换机端口9', '9', '6', 'image', '80', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('41', 'S5048E-10', 'H3C', 'H3C S5048E交换机端口10', '10', '6', 'image', '80', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('42', 'S5048E-11', 'H3C', 'H3C S5048E交换机端口11', '11', '6', 'image', '96', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('43', 'S5048E-12', 'H3C', 'H3C S5048E交换机端口12', '12', '6', 'image', '96', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('44', 'S5048E-13', 'H3C', 'H3C S5048E交换机端口13', '13', '6', 'image', '112', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('45', 'S5048E-14', 'H3C', 'H3C S5048E交换机端口14', '14', '6', 'image', '112', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('46', 'S5048E-15', 'H3C', 'H3C S5048E交换机端口15', '15', '6', 'image', '128', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('47', 'S5048E-16', 'H3C', 'H3C S5048E交换机端口16', '16', '6', 'image', '128', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('48', 'S5048E-17', 'H3C', 'H3C S5048E交换机端口17', '17', '6', 'image', '152', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('49', 'S5048E-18', 'H3C', 'H3C S5048E交换机端口18', '18', '6', 'image', '152', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('50', 'S5048E-19', 'H3C', 'H3C S5048E交换机端口19', '19', '6', 'image', '168', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('51', 'S5048E-20', 'H3C', 'H3C S5048E交换机端口20', '20', '6', 'image', '168', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('52', 'S5048E-21', 'H3C', 'H3C S5048E交换机端口21', '21', '6', 'image', '184', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('53', 'S5048E-22', 'H3C', 'H3C S5048E交换机端口22', '22', '6', 'image', '184', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('54', 'S5048E-23', 'H3C', 'H3C S5048E交换机端口23', '23', '6', 'image', '200', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('55', 'S5048E-24', 'H3C', 'H3C S5048E交换机端口24', '24', '6', 'image', '200', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('56', 'S5048E-25', 'H3C', 'H3C S5048E交换机端口25', '25', '6', 'image', '216', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('57', 'S5048E-26', 'H3C', 'H3C S5048E交换机端口26', '26', '6', 'image', '216', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('58', 'S5048E-27', 'H3C', 'H3C S5048E交换机端口27', '27', '6', 'image', '232', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('59', 'S5048E-28', 'H3C', 'H3C S5048E交换机端口28', '28', '6', 'image', '232', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('60', 'S5048E-29', 'H3C', 'H3C S5048E交换机端口29', '29', '6', 'image', '248', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('61', 'S5048E-30', 'H3C', 'H3C S5048E交换机端口30', '30', '6', 'image', '248', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('62', 'S5048E-31', 'H3C', 'H3C S5048E交换机端口31', '31', '6', 'image', '264', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('63', 'S5048E-32', 'H3C', 'H3C S5048E交换机端口32', '32', '6', 'image', '264', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('64', 'S5048E-33', 'H3C', 'H3C S5048E交换机端口33', '33', '6', 'image', '288', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('65', 'S5048E-34', 'H3C', 'H3C S5048E交换机端口34', '34', '6', 'image', '288', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('66', 'S5048E-35', 'H3C', 'H3C S5048E交换机端口35', '35', '6', 'image', '304', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('67', 'S5048E-36', 'H3C', 'H3C S5048E交换机端口36', '36', '6', 'image', '304', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('68', 'S5048E-37', 'H3C', 'H3C S5048E交换机端口37', '37', '6', 'image', '320', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('69', 'S5048E-38', 'H3C', 'H3C S5048E交换机端口38', '38', '6', 'image', '320', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('70', 'S5048E-39', 'H3C', 'H3C S5048E交换机端口39', '39', '6', 'image', '336', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('71', 'S5048E-40', 'H3C', 'H3C S5048E交换机端口40', '40', '6', 'image', '336', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('72', 'S5048E-41', 'H3C', 'H3C S5048E交换机端口41', '41', '6', 'image', '352', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('73', 'S5048E-42', 'H3C', 'H3C S5048E交换机端口42', '42', '6', 'image', '352', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('74', 'S5048E-43', 'H3C', 'H3C S5048E交换机端口43', '43', '6', 'image', '368', '37', '10', '10', 'red', '1', 'S5048E1.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('75', 'S5048E-44', 'H3C', 'H3C S5048E交换机端口44', '44', '6', 'image', '368', '16', '10', '10', 'red', '1', 'S5048E2.png', 'GigabitEthernet0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('76', 'S5048E-45', 'H3C', 'H3C S5048E交换机端口45', '45', '6', 'image', '384', '37', '10', '10', 'red', '1', 'S5048E1.png', 'Copper0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('77', 'S5048E-46', 'H3C', 'H3C S5048E交换机端口46', '46', '6', 'image', '384', '16', '10', '10', 'red', '1', 'S5048E2.png', 'Copper0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('78', 'S5048E-47', 'H3C', 'H3C S5048E交换机端口47', '47', '6', 'image', '400', '37', '10', '10', 'red', '1', 'S5048E1.png', 'Copper0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('79', 'S5048E-48', 'H3C', 'H3C S5048E交换机端口48', '48', '6', 'image', '400', '16', '10', '10', 'red', '1', 'S5048E2.png', 'Copper0/[Y]', '2013-03-01 00:00:00', '4', '2013-03-01 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '2', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('80', 'DPX8000-A12-Fan0', 'DPtech', 'DPX8000-A12风扇指示灯0', '0', '1', 'image', '385', '225', '19', '19', 'red', '1', 'DPX8000-A12-Fan.png', '[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_DPSYSTEMFANENTRY', 'DPSYSTEMFANNO', 'DPSYSTEMFANSTAT', '=', 'abnormal', '2', '0', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('81', 'DPX8000-A12-Fan1', 'DPtech', 'DPX8000-A12风扇指示灯1', '1', '1', 'image', '385', '444', '19', '19', 'red', '1', 'DPX8000-A12-Fan.png', '[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_DPSYSTEMFANENTRY', 'DPSYSTEMFANNO', 'DPSYSTEMFANSTAT', '=', 'abnormal', '2', '0', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('82', 'DPX8000-A12-Fan', 'DPtech', 'DPX8000-A12风扇指示灯（暂时没用）', '1', '0', 'image', '200', '300', '10', '10', 'red', '1', 'DPX8000-A12-Fan.png', 'DPX8000-A12-Fan', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '2', '0', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('83', 'DPX8000-A12-Power0', 'DPtech', 'DPX8000-A12电源指示灯0', '0', '1', 'image', '76', '516', '18', '20', 'red', '1', 'DPX8000-A12-Power.png', '[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_DPSYSTEMPOWERENTRY', 'DPSYSTEMPOWERNO', 'DPSYSTEMPOWERSTAT', '=', 'abnormal', '2', '0', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('84', 'DPX8000-A12-Power1', 'DPtech', 'DPX8000-A12电源指示灯1', '1', '1', 'image', '76', '562', '18', '20', 'red', '1', 'DPX8000-A12-Power.png', '[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_DPSYSTEMPOWERENTRY', 'DPSYSTEMPOWERNO', 'DPSYSTEMPOWERSTAT', '=', 'abnormal', '2', '0', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('85', 'DPX8000-A12-Power2', 'DPtech', 'DPX8000-A12电源指示灯2', '2', '1', 'image', '291', '516', '18', '20', 'red', '1', 'DPX8000-A12-Power.png', '[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_DPSYSTEMPOWERENTRY', 'DPSYSTEMPOWERNO', 'DPSYSTEMPOWERSTAT', '=', 'abnormal', '2', '0', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('86', 'DPX8000-A12-Power3', 'DPtech', 'DPX8000-A12电源指示灯3', '3', '1', 'image', '291', '562', '18', '20', 'red', '1', 'DPX8000-A12-Power.png', '[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_DPSYSTEMPOWERENTRY', 'DPSYSTEMPOWERNO', 'DPSYSTEMPOWERSTAT', '=', 'abnormal', '2', '0', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('87', 'MPUA_SUB', 'DPtech', '虚拟的第三级设备（测试用）', '1', '0', 'image', '400', '400', '170', '15', 'red', '1', 'MPUA_SUB.png', 'meth0_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '3', '0', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('88', '8XGEP-D-Zero', 'DPtech', '8XGEP-D端口0', '0', '5', 'image', '19', '16', '18', '8', 'red', '1', '8XGEP-D.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('89', '8XGEP-D-One', 'DPtech', '8XGEP-D端口1', '1', '5', 'image', '59', '16', '18', '8', 'red', '1', '8XGEP-D.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('90', '8XGEP-D-Two', 'DPtech', '8XGEP-D端口2', '2', '5', 'image', '100', '16', '18', '8', 'red', '1', '8XGEP-D.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('91', '8XGEP-D-Three', 'DPtech', '8XGEP-D端口3', '3', '5', 'image', '141', '16', '18', '8', 'red', '1', '8XGEP-D.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('92', '8XGEP-D-Four', 'DPtech', '8XGEP-D端口4', '4', '5', 'image', '184', '16', '18', '8', 'red', '1', '8XGEP-D.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('93', '8XGEP-D-Five', 'DPtech', '8XGEP-D端口5', '5', '5', 'image', '226', '16', '18', '8', 'red', '1', '8XGEP-D.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('94', '8XGEP-D-Six', 'DPtech', '8XGEP-D端口6', '6', '5', 'image', '259', '16', '18', '8', 'red', '1', '8XGEP-D.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('95', '8XGEP-D-Seven', 'DPtech', '8XGEP-D端口7', '7', '5', 'image', '301', '16', '18', '8', 'red', '1', '8XGEP-D.png', 'eth[X]_[Y]', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('96', '8XGEP-D-BLANK', 'DPtech', '8XGEP-D空白版', '1', '0', 'image', '30', '30', '354', '34', 'red', '1', '8XGEP-D-BLANK.png', '8XGEP-D-BLANK', '2013-02-25 00:00:00', '4', '2013-02-25 00:00:00', '4', null, null, null, null, null, '2', '0', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('217', 'ZXR10-T240G', 'ZTE', '中兴t240G', '1', '0', 'image', '35', '0', '442', '775', 'red', '1', 'ZXR10-T240G.png', 'ZXR10-T240G', '2013-05-20 14:59:20', '4', '2013-05-20 14:59:20', '4', 'DI_SYSTEM', null, null, null, null, '1', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('218', 'ZXR10-T240G-BLANK', 'ZTE', '中兴空白板', '1', '0', 'image', '10', '10', '359', '40', 'red', '1', 'ZXR10-T240G-BLANK.png', 'ZXR10-T240G-BLANK', '2013-05-20 16:20:52', '4', '2013-05-20 16:20:52', '4', null, null, null, null, null, '2', '0', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('219', 'ZXR10-T240G-1', 'ZTE', 'ZXR10-T240G槽位-1', '1', '217', 'image', '54', '40', '359', '40', 'red', '1', 'ZXR10-T240G.png', 'ZXR10-T240G', '2013-05-20 16:36:11', '4', '2013-05-20 16:36:11', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('220', 'ZXR10-T240G-2', 'ZTE', 'ZXR10-T240G槽位-2', '2', '217', 'image', '54', '80', '359', '40', 'red', '1', 'ZXR10-T240G.png', 'ZXR10-T240G', '2013-05-20 16:36:11', '4', '2013-05-20 16:36:11', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('221', 'ZXR10-T240G-3', 'ZTE', 'ZXR10-T240G槽位-3', '3', '217', 'image', '54', '120', '359', '40', 'red', '1', 'ZXR10-T240G.png', 'ZXR10-T240G', '2013-05-20 16:36:11', '4', '2013-05-20 16:36:11', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('222', 'ZXR10-T240G-4', 'ZTE', 'ZXR10-T240G槽位-4', '4', '217', 'image', '54', '160', '359', '40', 'red', '1', 'ZXR10-T240G.png', 'ZXR10-T240G', '2013-05-20 16:36:11', '4', '2013-05-20 16:36:11', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('223', 'ZXR10-T240G-5', 'ZTE', 'ZXR10-T240G槽位-5', '5', '217', 'image', '54', '200', '359', '40', 'red', '1', 'ZXR10-T240G.png', 'ZXR10-T240G', '2013-05-20 16:36:11', '4', '2013-05-20 16:36:11', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('224', 'ZXR10-T240G-6', 'ZTE', 'ZXR10-T240G槽位-6', '6', '217', 'image', '54', '240', '359', '40', 'red', '1', 'ZXR10-T240G.png', 'ZXR10-T240G', '2013-05-20 16:36:11', '4', '2013-05-20 16:36:11', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('225', 'ZXR10-T240G-13', 'ZTE', 'ZXR10-T240G槽位-13', '13', '217', 'image', '54', '280', '359', '40', 'red', '1', 'ZXR10-T240G.png', 'ZXR10-T240G', '2013-05-20 16:36:11', '4', '2013-05-20 16:36:11', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('226', 'ZXR10-T240G-14', 'ZTE', 'ZXR10-T240G槽位-14', '14', '217', 'image', '54', '320', '359', '40', 'red', '1', 'ZXR10-T240G.png', 'ZXR10-T240G', '2013-05-20 16:36:11', '4', '2013-05-20 16:36:11', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('227', 'ZXR10-T240G-7', 'ZTE', 'ZXR10-T240G槽位-7', '7', '217', 'image', '54', '360', '359', '40', 'red', '1', 'ZXR10-T240G.png', 'ZXR10-T240G', '2013-05-20 16:36:11', '4', '2013-05-20 16:36:11', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('228', 'ZXR10-T240G-8', 'ZTE', 'ZXR10-T240G槽位-8', '8', '217', 'image', '54', '400', '359', '40', 'red', '1', 'ZXR10-T240G.png', 'ZXR10-T240G', '2013-05-20 16:36:11', '4', '2013-05-20 16:36:11', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('229', 'ZXR10-T240G-9', 'ZTE', 'ZXR10-T240G槽位-9', '9', '217', 'image', '54', '440', '359', '40', 'red', '1', 'ZXR10-T240G.png', 'ZXR10-T240G', '2013-05-20 16:36:11', '4', '2013-05-20 16:36:11', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('230', 'ZXR10-T240G-10', 'ZTE', 'ZXR10-T240G槽位-10', '10', '217', 'image', '54', '480', '359', '40', 'red', '1', 'ZXR10-T240G.png', 'ZXR10-T240G', '2013-05-20 16:36:11', '4', '2013-05-20 16:36:11', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('231', 'ZXR10-T240G-11', 'ZTE', 'ZXR10-T240G槽位-11', '11', '217', 'image', '54', '520', '359', '40', 'red', '1', 'ZXR10-T240G.png', 'ZXR10-T240G', '2013-05-20 16:36:11', '4', '2013-05-20 16:36:11', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('232', 'ZXR10-T240G-12', 'ZTE', 'ZXR10-T240G槽位-12', '12', '217', 'image', '54', '560', '359', '40', 'red', '1', 'ZXR10-T240G.png', 'ZXR10-T240G', '2013-05-20 16:36:11', '4', '2013-05-20 16:36:11', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('233', 'RS-T160G-2XGP-24GE', 'ZTE', 'RS-T160G-2XGP-24GE', '1', '0', 'image', '10', '10', '359', '40', 'red', '1', 'RS-T160G-2XGP-24GE.png', 'RS-T160G-2XGP-24GE', '2013-05-20 16:54:05', '4', '2013-05-20 16:54:05', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('234', 'RS-T160G-2XGP-24GE-25', 'ZTE', 'RS-T160G-2XGP-24GE端口-25', '25', '233', 'image', '135', '8', '14', '10', 'red', '1', 'RS-T160G-2XGP-24GE-POS192.png', 'pos192_[X]/[Y]', '2013-05-20 17:08:09', '4', '2013-05-20 17:08:09', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('235', 'RS-T160G-2XGP-24GE-26', 'ZTE', 'RS-T160G-2XGP-24GE端口-26', '26', '233', 'image', '288', '7', '14', '10', 'red', '1', 'RS-T160G-2XGP-24GE-POS192.png', 'pos192_[X]/[Y]', '2013-05-20 17:08:09', '4', '2013-05-20 17:08:09', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('236', 'RS-T160G-2XGP-24GE-1', 'ZTE', 'RS-T160G-2XGP-24GE端口-1', '1', '233', 'image', '37', '20', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('237', 'RS-T160G-2XGP-24GE-2', 'ZTE', 'RS-T160G-2XGP-24GE端口-2', '2', '233', 'image', '37', '9', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('238', 'RS-T160G-2XGP-24GE-3', 'ZTE', 'RS-T160G-2XGP-24GE端口-3', '3', '233', 'image', '50', '20', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('239', 'RS-T160G-2XGP-24GE-4', 'ZTE', 'RS-T160G-2XGP-24GE端口-4', '4', '233', 'image', '50', '9', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('240', 'RS-T160G-2XGP-24GE-5', 'ZTE', 'RS-T160G-2XGP-24GE端口-5', '5', '233', 'image', '64', '20', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('241', 'RS-T160G-2XGP-24GE-6', 'ZTE', 'RS-T160G-2XGP-24GE端口-6', '6', '233', 'image', '64', '9', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('242', 'RS-T160G-2XGP-24GE-7', 'ZTE', 'RS-T160G-2XGP-24GE端口-7', '7', '233', 'image', '77', '20', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('243', 'RS-T160G-2XGP-24GE-8', 'ZTE', 'RS-T160G-2XGP-24GE端口-8', '8', '233', 'image', '77', '9', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('244', 'RS-T160G-2XGP-24GE-9', 'ZTE', 'RS-T160G-2XGP-24GE端口-9', '9', '233', 'image', '91', '20', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('245', 'RS-T160G-2XGP-24GE-10', 'ZTE', 'RS-T160G-2XGP-24GE端口-10', '10', '233', 'image', '91', '9', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('246', 'RS-T160G-2XGP-24GE-11', 'ZTE', 'RS-T160G-2XGP-24GE端口-11', '11', '233', 'image', '104', '20', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('247', 'RS-T160G-2XGP-24GE-12', 'ZTE', 'RS-T160G-2XGP-24GE端口-12', '12', '233', 'image', '104', '9', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('248', 'RS-T160G-2XGP-24GE-13', 'ZTE', 'RS-T160G-2XGP-24GE端口-13', '13', '233', 'image', '189', '20', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('249', 'RS-T160G-2XGP-24GE-14', 'ZTE', 'RS-T160G-2XGP-24GE端口-14', '14', '233', 'image', '189', '9', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('250', 'RS-T160G-2XGP-24GE-15', 'ZTE', 'RS-T160G-2XGP-24GE端口-15', '15', '233', 'image', '202', '20', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('251', 'RS-T160G-2XGP-24GE-16', 'ZTE', 'RS-T160G-2XGP-24GE端口-16', '16', '233', 'image', '202', '9', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('252', 'RS-T160G-2XGP-24GE-17', 'ZTE', 'RS-T160G-2XGP-24GE端口-17', '17', '233', 'image', '216', '20', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('253', 'RS-T160G-2XGP-24GE-18', 'ZTE', 'RS-T160G-2XGP-24GE端口-18', '18', '233', 'image', '216', '9', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('254', 'RS-T160G-2XGP-24GE-19', 'ZTE', 'RS-T160G-2XGP-24GE端口-19', '19', '233', 'image', '229', '20', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('255', 'RS-T160G-2XGP-24GE-20', 'ZTE', 'RS-T160G-2XGP-24GE端口-20', '20', '233', 'image', '229', '9', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('256', 'RS-T160G-2XGP-24GE-21', 'ZTE', 'RS-T160G-2XGP-24GE端口-21', '21', '233', 'image', '242', '20', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('257', 'RS-T160G-2XGP-24GE-22', 'ZTE', 'RS-T160G-2XGP-24GE端口-22', '22', '233', 'image', '242', '9', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('258', 'RS-T160G-2XGP-24GE-23', 'ZTE', 'RS-T160G-2XGP-24GE端口-23', '23', '233', 'image', '256', '20', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('259', 'RS-T160G-2XGP-24GE-24', 'ZTE', 'RS-T160G-2XGP-24GE端口-24', '24', '233', 'image', '256', '9', '11', '8', 'red', '1', 'RS-T160G-2XGP-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-20 17:10:01', '4', '2013-05-20 17:10:01', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('260', 'RS-T160G-4P48-12GE', 'ZTE', 'RS-T160G-4P48-12GE', '1', '0', 'image', '10', '10', '359', '40', 'red', '1', 'RS-T160G-4P48-12GE.png', 'RS-T160G-4P48-12GE', '2013-05-20 17:41:49', '4', '2013-05-20 17:41:49', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('261', 'RS-T160G-8P48-24GE', 'ZTE', 'RS-T160G-8P48-24GE', '1', '0', 'image', '10', '10', '359', '40', 'red', '1', 'RS-T160G-8P48-24GE.png', 'RS-T160G-8P48-24GE', '2013-05-20 17:46:00', '4', '2013-05-20 17:46:00', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('262', 'RS-T240G-MCSII', 'ZTE', 'RS-T240G-MCSII', '1', '0', 'image', '10', '10', '359', '40', 'red', '1', 'RS-T240G-MCSII.png', 'RS-T240G-MCSII.png', '2013-05-20 17:47:32', '4', '2013-05-20 17:47:32', '4', null, null, null, null, null, '2', '0', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('263', 'RS-XG-4XGESFP+LE', 'ZTE', 'RS-XG-4XGESFP+LE', '1', '0', 'image', '10', '10', '359', '40', 'red', '1', 'RS-XG-4XGESFP+LE.png', 'RS-XG-4XGESFP+LE', '2013-05-20 17:48:07', '4', '2013-05-20 17:48:07', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('264', 'RS-XGTN3-4P192-8XGESFP+', 'ZTE', 'RS-XGTN3-4P192-8XGESFP+', '1', '0', 'image', '10', '10', '359', '40', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+.png', 'RS-XGTN3-4P192-8XGESFP+', '2013-05-20 17:48:47', '4', '2013-05-20 17:48:47', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('265', 'RS-XGTN3-16MPOS12-12GESFP', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP', '1', '0', 'image', '10', '10', '359', '40', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP.png', 'RS-XGTN3-16MPOS12-12GESFP', '2013-05-20 17:49:29', '4', '2013-05-20 17:49:29', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('277', 'RS-XGTN3-4P192-8XGESFP+-1', 'ZTE', 'RS-XGTN3-4P192-8XGESFP+端口-1', '1', '264', 'image', '139', '18', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/1', '2013-05-21 13:23:41', '4', '2013-05-21 13:23:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('278', 'RS-XGTN3-4P192-8XGESFP+-2', 'ZTE', 'RS-XGTN3-4P192-8XGESFP+端口-2', '2', '264', 'image', '139', '7', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/2', '2013-05-21 13:23:41', '4', '2013-05-21 13:23:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('279', 'RS-XGTN3-4P192-8XGESFP+-3', 'ZTE', 'RS-XGTN3-4P192-8XGESFP+端口-3', '3', '264', 'image', '152', '18', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/3', '2013-05-21 13:23:41', '4', '2013-05-21 13:23:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('280', 'RS-XGTN3-4P192-8XGESFP+-4', 'ZTE', 'RS-XGTN3-4P192-8XGESFP+端口-4', '4', '264', 'image', '152', '7', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/4', '2013-05-21 13:23:41', '4', '2013-05-21 13:23:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('281', 'RS-XGTN3-4P192-8XGESFP+-5', 'ZTE', 'RS-XGTN3-4P192-8XGESFP+端口-5', '5', '264', 'image', '165', '18', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/5', '2013-05-21 13:23:41', '4', '2013-05-21 13:23:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('282', 'RS-XGTN3-4P192-8XGESFP+-6', 'ZTE', 'RS-XGTN3-4P192-8XGESFP+端口-6', '6', '264', 'image', '165', '7', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/6', '2013-05-21 13:23:41', '4', '2013-05-21 13:23:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('283', 'RS-XGTN3-4P192-8XGESFP+-7', 'ZTE', 'RS-XGTN3-4P192-8XGESFP+端口-7', '7', '264', 'image', '177', '18', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/7', '2013-05-21 13:23:41', '4', '2013-05-21 13:23:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('284', 'RS-XGTN3-4P192-8XGESFP+-8', 'ZTE', 'RS-XGTN3-4P192-8XGESFP+端口-8', '8', '264', 'image', '177', '7', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/8', '2013-05-21 13:23:41', '4', '2013-05-21 13:23:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('285', 'RS-XGTN3-4P192-8XGESFP+-9', 'ZTE', 'RS-XGTN3-4P192-8XGESFP+端口-9', '9', '264', 'image', '213', '9', '14', '9', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_POS192.png', 'pos192_[X]/9', '2013-05-21 13:37:53', '4', '2013-05-21 13:37:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('286', 'RS-XGTN3-4P192-8XGESFP+-10', 'ZTE', 'RS-XGTN3-4P192-8XGESFP+端口-10', '10', '264', 'image', '246', '9', '14', '9', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_POS192.png', 'pos192_[X]/10', '2013-05-21 13:37:53', '4', '2013-05-21 13:37:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('287', 'RS-XGTN3-4P192-8XGESFP+-11', 'ZTE', 'RS-XGTN3-4P192-8XGESFP+端口-11', '11', '264', 'image', '279', '9', '14', '9', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_POS192.png', 'pos192_[X]/11', '2013-05-21 13:37:53', '4', '2013-05-21 13:37:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('288', 'RS-XGTN3-4P192-8XGESFP+-12', 'ZTE', 'RS-XGTN3-4P192-8XGESFP+端口-12', '12', '264', 'image', '310', '9', '14', '9', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_POS192.png', 'pos192_[X]/12', '2013-05-21 13:37:53', '4', '2013-05-21 13:37:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('289', 'RS-XGTN3-16MPOS12-12GESFP-1', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-1', '1', '265', 'image', '29', '20', '12', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_GEI.png', 'gei_[X]/[Y]', '2013-05-21 14:06:06', '4', '2013-05-21 14:06:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('290', 'RS-XGTN3-16MPOS12-12GESFP-2', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-2', '2', '265', 'image', '29', '7', '12', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_GEI.png', 'gei_[X]/[Y]', '2013-05-21 14:06:06', '4', '2013-05-21 14:06:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('291', 'RS-XGTN3-16MPOS12-12GESFP-3', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-3', '3', '265', 'image', '43', '20', '12', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_GEI.png', 'gei_[X]/[Y]', '2013-05-21 14:06:06', '4', '2013-05-21 14:06:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('292', 'RS-XGTN3-16MPOS12-12GESFP-4', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-4', '4', '265', 'image', '43', '7', '12', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_GEI.png', 'gei_[X]/[Y]', '2013-05-21 14:06:06', '4', '2013-05-21 14:06:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('293', 'RS-XGTN3-16MPOS12-12GESFP-5', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-5', '5', '265', 'image', '56', '20', '12', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_GEI.png', 'gei_[X]/[Y]', '2013-05-21 14:06:06', '4', '2013-05-21 14:06:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('294', 'RS-XGTN3-16MPOS12-12GESFP-6', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-6', '6', '265', 'image', '56', '7', '12', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_GEI.png', 'gei_[X]/[Y]', '2013-05-21 14:06:06', '4', '2013-05-21 14:06:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('295', 'RS-XGTN3-16MPOS12-12GESFP-7', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-7', '7', '265', 'image', '70', '20', '12', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_GEI.png', 'gei_[X]/[Y]', '2013-05-21 14:06:06', '4', '2013-05-21 14:06:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('296', 'RS-XGTN3-16MPOS12-12GESFP-8', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-8', '8', '265', 'image', '70', '7', '12', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_GEI.png', 'gei_[X]/[Y]', '2013-05-21 14:06:06', '4', '2013-05-21 14:06:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('297', 'RS-XGTN3-16MPOS12-12GESFP-9', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-9', '9', '265', 'image', '82', '20', '12', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_GEI.png', 'gei_[X]/[Y]', '2013-05-21 14:06:06', '4', '2013-05-21 14:06:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('298', 'RS-XGTN3-16MPOS12-12GESFP-10', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-10', '10', '265', 'image', '82', '7', '12', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_GEI.png', 'gei_[X]/[Y]', '2013-05-21 14:06:06', '4', '2013-05-21 14:06:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('299', 'RS-XGTN3-16MPOS12-12GESFP-11', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-11', '11', '265', 'image', '95', '20', '12', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_GEI.png', 'gei_[X]/[Y]', '2013-05-21 14:06:06', '4', '2013-05-21 14:06:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('300', 'RS-XGTN3-16MPOS12-12GESFP-12', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-12', '12', '265', 'image', '95', '7', '12', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_GEI.png', 'gei_[X]/[Y]', '2013-05-21 14:06:06', '4', '2013-05-21 14:06:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('301', 'RS-XGTN3-16MPOS12-12GESFP-13', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-13', '13', '265', 'image', '115', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('302', 'RS-XGTN3-16MPOS12-12GESFP-14', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-14', '14', '265', 'image', '128', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('303', 'RS-XGTN3-16MPOS12-12GESFP-15', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-15', '15', '265', 'image', '141', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('304', 'RS-XGTN3-16MPOS12-12GESFP-16', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-16', '16', '265', 'image', '154', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('305', 'RS-XGTN3-16MPOS12-12GESFP-17', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-17', '17', '265', 'image', '171', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('306', 'RS-XGTN3-16MPOS12-12GESFP-18', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-18', '18', '265', 'image', '184', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('307', 'RS-XGTN3-16MPOS12-12GESFP-19', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-19', '19', '265', 'image', '197', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('308', 'RS-XGTN3-16MPOS12-12GESFP-20', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-20', '20', '265', 'image', '210', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('309', 'RS-XGTN3-16MPOS12-12GESFP-21', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-21', '21', '265', 'image', '226', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('310', 'RS-XGTN3-16MPOS12-12GESFP-22', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-22', '22', '265', 'image', '239', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('311', 'RS-XGTN3-16MPOS12-12GESFP-23', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-23', '23', '265', 'image', '252', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('312', 'RS-XGTN3-16MPOS12-12GESFP-24', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-24', '24', '265', 'image', '265', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('313', 'RS-XGTN3-16MPOS12-12GESFP-25', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-25', '25', '265', 'image', '282', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('314', 'RS-XGTN3-16MPOS12-12GESFP-26', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-26', '26', '265', 'image', '295', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('315', 'RS-XGTN3-16MPOS12-12GESFP-27', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-27', '27', '265', 'image', '308', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('316', 'RS-XGTN3-16MPOS12-12GESFP-28', 'ZTE', 'RS-XGTN3-16MPOS12-12GESFP端口-28', '28', '265', 'image', '321', '13', '11', '7', 'red', '1', 'RS-XGTN3-16MPOS12-12GESFP_POS12.png', 'pos12_[X]/[Y]', '2013-05-21 14:08:10', '4', '2013-05-21 14:08:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('317', 'RS-XGTN3-8POS48-24GESFP', 'ZTE', 'RS-XGTN3-8POS48-24GESFP', '1', '0', 'image', '10', '10', '359', '40', 'red', '1', 'RS-XGTN3-8POS48-24GESFP.png', 'RS-XGTN3-8POS48-24GESFP', '2013-05-21 14:38:15', '4', '2013-05-21 14:38:15', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('318', 'RS-T160G-8P48-24GE-1', 'ZTE', 'RS-T160G-8P48-24GE端口-1', '1', '261', 'image', '29', '20', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('319', 'RS-T160G-8P48-24GE-2', 'ZTE', 'RS-T160G-8P48-24GE端口-2', '2', '261', 'image', '29', '9', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('320', 'RS-T160G-8P48-24GE-3', 'ZTE', 'RS-T160G-8P48-24GE端口-3', '3', '261', 'image', '42', '20', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('321', 'RS-T160G-8P48-24GE-4', 'ZTE', 'RS-T160G-8P48-24GE端口-4', '4', '261', 'image', '42', '9', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('322', 'RS-T160G-8P48-24GE-5', 'ZTE', 'RS-T160G-8P48-24GE端口-5', '5', '261', 'image', '55', '20', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('323', 'RS-T160G-8P48-24GE-6', 'ZTE', 'RS-T160G-8P48-24GE端口-6', '6', '261', 'image', '55', '9', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('324', 'RS-T160G-8P48-24GE-7', 'ZTE', 'RS-T160G-8P48-24GE端口-7', '7', '261', 'image', '68', '20', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('325', 'RS-T160G-8P48-24GE-8', 'ZTE', 'RS-T160G-8P48-24GE端口-8', '8', '261', 'image', '68', '9', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('326', 'RS-T160G-8P48-24GE-9', 'ZTE', 'RS-T160G-8P48-24GE端口-9', '9', '261', 'image', '81', '20', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('327', 'RS-T160G-8P48-24GE-10', 'ZTE', 'RS-T160G-8P48-24GE端口-10', '10', '261', 'image', '81', '9', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('328', 'RS-T160G-8P48-24GE-11', 'ZTE', 'RS-T160G-8P48-24GE端口-11', '11', '261', 'image', '94', '20', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('329', 'RS-T160G-8P48-24GE-12', 'ZTE', 'RS-T160G-8P48-24GE端口-12', '12', '261', 'image', '94', '9', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('330', 'RS-T160G-8P48-24GE-13', 'ZTE', 'RS-T160G-8P48-24GE端口-13', '13', '261', 'image', '184', '20', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('331', 'RS-T160G-8P48-24GE-14', 'ZTE', 'RS-T160G-8P48-24GE端口-14', '14', '261', 'image', '184', '8', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('332', 'RS-T160G-8P48-24GE-15', 'ZTE', 'RS-T160G-8P48-24GE端口-15', '15', '261', 'image', '197', '20', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('333', 'RS-T160G-8P48-24GE-16', 'ZTE', 'RS-T160G-8P48-24GE端口-16', '16', '261', 'image', '197', '8', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('334', 'RS-T160G-8P48-24GE-17', 'ZTE', 'RS-T160G-8P48-24GE端口-17', '17', '261', 'image', '210', '20', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('335', 'RS-T160G-8P48-24GE-18', 'ZTE', 'RS-T160G-8P48-24GE端口-18', '18', '261', 'image', '210', '8', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('336', 'RS-T160G-8P48-24GE-19', 'ZTE', 'RS-T160G-8P48-24GE端口-19', '19', '261', 'image', '223', '20', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('337', 'RS-T160G-8P48-24GE-20', 'ZTE', 'RS-T160G-8P48-24GE端口-20', '20', '261', 'image', '223', '8', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('338', 'RS-T160G-8P48-24GE-21', 'ZTE', 'RS-T160G-8P48-24GE端口-21', '21', '261', 'image', '236', '20', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('339', 'RS-T160G-8P48-24GE-22', 'ZTE', 'RS-T160G-8P48-24GE端口-22', '22', '261', 'image', '236', '8', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('340', 'RS-T160G-8P48-24GE-23', 'ZTE', 'RS-T160G-8P48-24GE端口-23', '23', '261', 'image', '249', '20', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('341', 'RS-T160G-8P48-24GE-24', 'ZTE', 'RS-T160G-8P48-24GE端口-24', '24', '261', 'image', '249', '8', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-GEI.png', 'gei_[X]/[Y]', '2013-05-21 15:35:37', '4', '2013-05-21 15:35:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('342', 'RS-T160G-8P48-24GE-25', 'ZTE', 'RS-T160G-8P48-24GE端口-25', '25', '261', 'image', '116', '9', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-POS48.png', 'pos48_[X]/[Y]', '2013-05-21 15:37:33', '4', '2013-05-21 15:37:33', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('343', 'RS-T160G-8P48-24GE-26', 'ZTE', 'RS-T160G-8P48-24GE端口-26', '26', '261', 'image', '129', '9', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-POS48.png', 'pos48_[X]/[Y]', '2013-05-21 15:37:33', '4', '2013-05-21 15:37:33', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('344', 'RS-T160G-8P48-24GE-27', 'ZTE', 'RS-T160G-8P48-24GE端口-27', '27', '261', 'image', '142', '9', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-POS48.png', 'pos48_[X]/[Y]', '2013-05-21 15:37:33', '4', '2013-05-21 15:37:33', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('345', 'RS-T160G-8P48-24GE-28', 'ZTE', 'RS-T160G-8P48-24GE端口-28', '28', '261', 'image', '155', '9', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-POS48.png', 'pos48_[X]/[Y]', '2013-05-21 15:37:33', '4', '2013-05-21 15:37:33', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('346', 'RS-T160G-8P48-24GE-29', 'ZTE', 'RS-T160G-8P48-24GE端口-29', '29', '261', 'image', '273', '9', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-POS48.png', 'pos48_[X]/[Y]', '2013-05-21 15:37:33', '4', '2013-05-21 15:37:33', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('347', 'RS-T160G-8P48-24GE-30', 'ZTE', 'RS-T160G-8P48-24GE端口-30', '30', '261', 'image', '286', '9', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-POS48.png', 'pos48_[X]/[Y]', '2013-05-21 15:37:33', '4', '2013-05-21 15:37:33', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('348', 'RS-T160G-8P48-24GE-31', 'ZTE', 'RS-T160G-8P48-24GE端口-31', '31', '261', 'image', '299', '9', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-POS48.png', 'pos48_[X]/[Y]', '2013-05-21 15:37:33', '4', '2013-05-21 15:37:33', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('349', 'RS-T160G-8P48-24GE-32', 'ZTE', 'RS-T160G-8P48-24GE端口-32', '32', '261', 'image', '312', '9', '12', '8', 'red', '1', 'RS-T160G-8P48-24GE-POS48.png', 'pos48_[X]/[Y]', '2013-05-21 15:37:33', '4', '2013-05-21 15:37:33', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('350', 'RS-XGTN3-8POS48-24GESFP-1', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-1', '1', '317', 'image', '29', '20', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_GEI.png', 'gei_[X]/1', '2013-05-21 16:25:32', '4', '2013-05-21 16:25:32', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('351', 'RS-XGTN3-8POS48-24GESFP-2', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-2', '2', '317', 'image', '29', '8', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_GEI.png', 'gei_[X]/2', '2013-05-21 16:25:32', '4', '2013-05-21 16:25:32', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('352', 'RS-XGTN3-8POS48-24GESFP-3', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-3', '3', '317', 'image', '42', '20', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_GEI.png', 'gei_[X]/3', '2013-05-21 16:25:32', '4', '2013-05-21 16:25:32', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('353', 'RS-XGTN3-8POS48-24GESFP-4', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-4', '4', '317', 'image', '42', '8', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_GEI.png', 'gei_[X]/4', '2013-05-21 16:25:32', '4', '2013-05-21 16:25:32', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('354', 'RS-XGTN3-8POS48-24GESFP-5', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-5', '5', '317', 'image', '55', '20', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_GEI.png', 'gei_[X]/5', '2013-05-21 16:25:32', '4', '2013-05-21 16:25:32', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('355', 'RS-XGTN3-8POS48-24GESFP-6', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-6', '6', '317', 'image', '55', '8', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_GEI.png', 'gei_[X]/6', '2013-05-21 16:25:32', '4', '2013-05-21 16:25:32', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('356', 'RS-XGTN3-8POS48-24GESFP-7', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-7', '7', '317', 'image', '68', '20', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_GEI.png', 'gei_[X]/7', '2013-05-21 16:25:32', '4', '2013-05-21 16:25:32', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('357', 'RS-XGTN3-8POS48-24GESFP-8', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-8', '8', '317', 'image', '68', '8', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_GEI.png', 'gei_[X]/8', '2013-05-21 16:25:32', '4', '2013-05-21 16:25:32', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('358', 'RS-XGTN3-8POS48-24GESFP-9', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-9', '9', '317', 'image', '81', '20', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_GEI.png', 'gei_[X]/9', '2013-05-21 16:25:32', '4', '2013-05-21 16:25:32', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('359', 'RS-XGTN3-8POS48-24GESFP-10', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-10', '10', '317', 'image', '81', '8', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_GEI.png', 'gei_[X]/10', '2013-05-21 16:25:32', '4', '2013-05-21 16:25:32', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('360', 'RS-XGTN3-8POS48-24GESFP-11', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-11', '11', '317', 'image', '94', '20', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_GEI.png', 'gei_[X]/11', '2013-05-21 16:25:32', '4', '2013-05-21 16:25:32', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('361', 'RS-XGTN3-8POS48-24GESFP-12', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-12', '12', '317', 'image', '94', '8', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_GEI.png', 'gei_[X]/12', '2013-05-21 16:25:32', '4', '2013-05-21 16:25:32', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('362', 'RS-XGTN3-8POS48-24GESFP-13', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-13', '13', '317', 'image', '196', '8', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_POS48.png', 'pos48_[X]/13', '2013-05-21 16:26:46', '4', '2013-05-21 16:26:46', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('363', 'RS-XGTN3-8POS48-24GESFP-14', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-14', '14', '317', 'image', '209', '8', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_POS48.png', 'pos48_[X]/14', '2013-05-21 16:26:46', '4', '2013-05-21 16:26:46', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('364', 'RS-XGTN3-8POS48-24GESFP-15', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-15', '15', '317', 'image', '222', '8', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_POS48.png', 'pos48_[X]/15', '2013-05-21 16:26:46', '4', '2013-05-21 16:26:46', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('365', 'RS-XGTN3-8POS48-24GESFP-16', 'ZTE', 'RS-XGTN3-8POS48-24GESFP端口-16', '16', '317', 'image', '235', '8', '12', '8', 'red', '1', 'RS-XGTN3-8POS48-24GESFP_POS48.png', 'pos48_[X]/16', '2013-05-21 16:26:46', '4', '2013-05-21 16:26:46', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('366', 'RS-XG-4XGESFP+LE-1', 'ZTE', 'RS-XG-4XGESFP+LE端口-1', '1', '263', 'image', '130', '17', '13', '9', 'red', '1', 'RS-XG-4XGESFP+LE_XGEI.png', 'xgei_[X]/[Y]', '2013-05-21 16:48:02', '4', '2013-05-21 16:48:02', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('367', 'RS-XG-4XGESFP+LE-2', 'ZTE', 'RS-XG-4XGESFP+LE端口-2', '2', '263', 'image', '130', '6', '13', '9', 'red', '1', 'RS-XG-4XGESFP+LE_XGEI.png', 'xgei_[X]/[Y]', '2013-05-21 16:48:02', '4', '2013-05-21 16:48:02', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('368', 'RS-XG-4XGESFP+LE-3', 'ZTE', 'RS-XG-4XGESFP+LE端口-3', '3', '263', 'image', '145', '17', '13', '9', 'red', '1', 'RS-XG-4XGESFP+LE_XGEI.png', 'xgei_[X]/[Y]', '2013-05-21 16:48:02', '4', '2013-05-21 16:48:02', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('369', 'RS-XG-4XGESFP+LE-4', 'ZTE', 'RS-XG-4XGESFP+LE端口-4', '4', '263', 'image', '145', '6', '13', '9', 'red', '1', 'RS-XG-4XGESFP+LE_XGEI.png', 'xgei_[X]/[Y]', '2013-05-21 16:48:02', '4', '2013-05-21 16:48:02', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('370', 'RS-XG-4XGESFP+LE-5', 'ZTE', 'RS-XG-4XGESFP+LE端口-5', '5', '263', 'image', null, '17', '13', '9', 'red', '1', 'RS-XG-4XGESFP+LE_XGEI.png', 'xgei_[X]/[Y]', '2013-05-21 16:48:02', '4', '2013-05-21 16:48:02', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('371', 'RS-XG-4XGESFP+LE-6', 'ZTE', 'RS-XG-4XGESFP+LE端口-6', '6', '263', 'image', null, '6', '13', '9', 'red', '1', 'RS-XG-4XGESFP+LE_XGEI.png', 'xgei_[X]/[Y]', '2013-05-21 16:48:02', '4', '2013-05-21 16:48:02', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('372', 'RS-XG-4XGESFP+LE-7', 'ZTE', 'RS-XG-4XGESFP+LE端口-7', '7', '263', 'image', null, '17', '13', '9', 'red', '1', 'RS-XG-4XGESFP+LE_XGEI.png', 'xgei_[X]/[Y]', '2013-05-21 16:48:02', '4', '2013-05-21 16:48:02', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('373', 'RS-XG-4XGESFP+LE-8', 'ZTE', 'RS-XG-4XGESFP+LE端口-8', '8', '263', 'image', null, '6', '13', '9', 'red', '1', 'RS-XG-4XGESFP+LE_XGEI.png', 'xgei_[X]/[Y]', '2013-05-21 16:48:02', '4', '2013-05-21 16:48:02', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('374', 'RS-T160G-4P48-12GE-1', 'ZTE', 'RS-T160G-4P48-12GE端口-1', '1', '260', 'image', '30', '20', '12', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('375', 'RS-T160G-4P48-12GE-2', 'ZTE', 'RS-T160G-4P48-12GE端口-2', '2', '260', 'image', '30', '7', '12', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('376', 'RS-T160G-4P48-12GE-3', 'ZTE', 'RS-T160G-4P48-12GE端口-3', '3', '260', 'image', '43', '20', '12', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('377', 'RS-T160G-4P48-12GE-4', 'ZTE', 'RS-T160G-4P48-12GE端口-4', '4', '260', 'image', '43', '7', '12', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('378', 'RS-T160G-4P48-12GE-5', 'ZTE', 'RS-T160G-4P48-12GE端口-5', '5', '260', 'image', '56', '20', '12', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('379', 'RS-T160G-4P48-12GE-6', 'ZTE', 'RS-T160G-4P48-12GE端口-6', '6', '260', 'image', '56', '7', '12', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('380', 'RS-T160G-4P48-12GE-7', 'ZTE', 'RS-T160G-4P48-12GE端口-7', '7', '260', 'image', '69', '20', '12', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('381', 'RS-T160G-4P48-12GE-8', 'ZTE', 'RS-T160G-4P48-12GE端口-8', '8', '260', 'image', '69', '7', '12', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('382', 'RS-T160G-4P48-12GE-9', 'ZTE', 'RS-T160G-4P48-12GE端口-9', '9', '260', 'image', '82', '20', '12', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('383', 'RS-T160G-4P48-12GE-10', 'ZTE', 'RS-T160G-4P48-12GE端口-10', '10', '260', 'image', '82', '7', '12', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('384', 'RS-T160G-4P48-12GE-11', 'ZTE', 'RS-T160G-4P48-12GE端口-11', '11', '260', 'image', '95', '20', '12', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('385', 'RS-T160G-4P48-12GE-12', 'ZTE', 'RS-T160G-4P48-12GE端口-12', '12', '260', 'image', '95', '7', '12', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('386', 'RS-T160G-4P48-12GE-13', 'ZTE', 'RS-T160G-4P48-12GE端口-13', '13', '260', 'image', null, '10', '10', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('387', 'RS-T160G-4P48-12GE-14', 'ZTE', 'RS-T160G-4P48-12GE端口-14', '14', '260', 'image', null, '10', '10', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('388', 'RS-T160G-4P48-12GE-15', 'ZTE', 'RS-T160G-4P48-12GE端口-15', '15', '260', 'image', null, '10', '10', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('389', 'RS-T160G-4P48-12GE-16', 'ZTE', 'RS-T160G-4P48-12GE端口-16', '16', '260', 'image', null, '10', '10', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('390', 'RS-T160G-4P48-12GE-17', 'ZTE', 'RS-T160G-4P48-12GE端口-17', '17', '260', 'image', null, '10', '10', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('391', 'RS-T160G-4P48-12GE-18', 'ZTE', 'RS-T160G-4P48-12GE端口-18', '18', '260', 'image', null, '10', '10', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:37', '4', '2013-05-21 17:20:37', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('392', 'RS-T160G-4P48-12GE-19', 'ZTE', 'RS-T160G-4P48-12GE端口-19', '19', '260', 'image', null, '10', '10', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:38', '4', '2013-05-21 17:20:38', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('393', 'RS-T160G-4P48-12GE-20', 'ZTE', 'RS-T160G-4P48-12GE端口-20', '20', '260', 'image', null, '10', '10', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:38', '4', '2013-05-21 17:20:38', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('394', 'RS-T160G-4P48-12GE-21', 'ZTE', 'RS-T160G-4P48-12GE端口-21', '21', '260', 'image', null, '10', '10', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:38', '4', '2013-05-21 17:20:38', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('395', 'RS-T160G-4P48-12GE-22', 'ZTE', 'RS-T160G-4P48-12GE端口-22', '22', '260', 'image', null, '10', '10', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:38', '4', '2013-05-21 17:20:38', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('396', 'RS-T160G-4P48-12GE-23', 'ZTE', 'RS-T160G-4P48-12GE端口-23', '23', '260', 'image', null, '10', '10', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:38', '4', '2013-05-21 17:20:38', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('397', 'RS-T160G-4P48-12GE-24', 'ZTE', 'RS-T160G-4P48-12GE端口-24', '24', '260', 'image', null, '10', '10', '8', 'red', '1', 'RS-T160G-4P48-12GE_GEI.png', 'gei_[X]/[Y]', '2013-05-21 17:20:38', '4', '2013-05-21 17:20:38', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('398', 'RS-T160G-4P48-12GE-25', 'ZTE', 'RS-T160G-4P48-12GE端口-25', '25', '260', 'image', '117', '7', '11', '8', 'red', '1', 'RS-T160G-4P48-12GE_POS48.png', 'pos48_[X]/[Y]', '2013-05-21 17:22:43', '4', '2013-05-21 17:22:43', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('399', 'RS-T160G-4P48-12GE-26', 'ZTE', 'RS-T160G-4P48-12GE端口-26', '26', '260', 'image', '129', '7', '11', '8', 'red', '1', 'RS-T160G-4P48-12GE_POS48.png', 'pos48_[X]/[Y]', '2013-05-21 17:22:43', '4', '2013-05-21 17:22:43', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('400', 'RS-T160G-4P48-12GE-27', 'ZTE', 'RS-T160G-4P48-12GE端口-27', '27', '260', 'image', '142', '7', '11', '8', 'red', '1', 'RS-T160G-4P48-12GE_POS48.png', 'pos48_[X]/[Y]', '2013-05-21 17:22:43', '4', '2013-05-21 17:22:43', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('401', 'RS-T160G-4P48-12GE-28', 'ZTE', 'RS-T160G-4P48-12GE端口-28', '28', '260', 'image', '156', '7', '11', '8', 'red', '1', 'RS-T160G-4P48-12GE_POS48.png', 'pos48_[X]/[Y]', '2013-05-21 17:22:43', '4', '2013-05-21 17:22:43', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('417', 'ZXR10-8912', 'ZTE', 'ZXR10-8912', '1', '0', 'image', '35', '0', '442', '775', 'red', '1', 'ZXR10-8912.png', 'ZXR10-8912', '2013-05-22 10:31:09', '4', '2013-05-22 10:31:09', '4', 'DI_SYSTEM', null, null, null, null, '1', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('437', 'ZXR10-8912-1', 'ZTE', 'ZXR10-8912槽位-1', '1', '417', 'image', '54', '40', '359', '40', 'red', '1', 'ZXR10-8912.png', 'ZXR10-8912', '2013-05-22 13:20:54', '4', '2013-05-22 13:20:54', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('438', 'ZXR10-8912-2', 'ZTE', 'ZXR10-8912槽位-2', '2', '417', 'image', '54', '80', '359', '40', 'red', '1', 'ZXR10-8912.png', 'ZXR10-8912', '2013-05-22 13:20:54', '4', '2013-05-22 13:20:54', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('439', 'ZXR10-8912-3', 'ZTE', 'ZXR10-8912槽位-3', '3', '417', 'image', '54', '120', '359', '40', 'red', '1', 'ZXR10-8912.png', 'ZXR10-8912', '2013-05-22 13:20:54', '4', '2013-05-22 13:20:54', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('440', 'ZXR10-8912-4', 'ZTE', 'ZXR10-8912槽位-4', '4', '417', 'image', '54', '160', '359', '40', 'red', '1', 'ZXR10-8912.png', 'ZXR10-8912', '2013-05-22 13:20:54', '4', '2013-05-22 13:20:54', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('441', 'ZXR10-8912-5', 'ZTE', 'ZXR10-8912槽位-5', '5', '417', 'image', '54', '200', '359', '40', 'red', '1', 'ZXR10-8912.png', 'ZXR10-8912', '2013-05-22 13:20:54', '4', '2013-05-22 13:20:54', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('442', 'ZXR10-8912-6', 'ZTE', 'ZXR10-8912槽位-6', '6', '417', 'image', '54', '240', '359', '40', 'red', '1', 'ZXR10-8912.png', 'ZXR10-8912', '2013-05-22 13:20:54', '4', '2013-05-22 13:20:54', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('443', 'ZXR10-8912-7', 'ZTE', 'ZXR10-8912槽位-7', '7', '417', 'image', '54', '360', '359', '40', 'red', '1', 'ZXR10-8912.png', 'ZXR10-8912', '2013-05-22 13:20:54', '4', '2013-05-22 13:20:54', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('444', 'ZXR10-8912-8', 'ZTE', 'ZXR10-8912槽位-8', '8', '417', 'image', '54', '400', '359', '40', 'red', '1', 'ZXR10-8912.png', 'ZXR10-8912', '2013-05-22 13:20:54', '4', '2013-05-22 13:20:54', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('445', 'ZXR10-8912-9', 'ZTE', 'ZXR10-8912槽位-9', '9', '417', 'image', '54', '440', '359', '40', 'red', '1', 'ZXR10-8912.png', 'ZXR10-8912', '2013-05-22 13:20:54', '4', '2013-05-22 13:20:54', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('446', 'ZXR10-8912-10', 'ZTE', 'ZXR10-8912槽位-10', '10', '417', 'image', '54', '480', '359', '40', 'red', '1', 'ZXR10-8912.png', 'ZXR10-8912', '2013-05-22 13:20:54', '4', '2013-05-22 13:20:54', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('447', 'ZXR10-8912-11', 'ZTE', 'ZXR10-8912槽位-11', '11', '417', 'image', '54', '520', '359', '40', 'red', '1', 'ZXR10-8912.png', 'ZXR10-8912', '2013-05-22 13:20:54', '4', '2013-05-22 13:20:54', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('448', 'ZXR10-8912-12', 'ZTE', 'ZXR10-8912槽位-12', '12', '417', 'image', '54', '560', '359', '40', 'red', '1', 'ZXR10-8912.png', 'ZXR10-8912', '2013-05-22 13:20:54', '4', '2013-05-22 13:20:54', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('449', 'ZXR10-8912-13', 'ZTE', 'ZXR10-8912槽位-13', '13', '417', 'image', '54', '280', '359', '40', 'red', '1', 'ZXR10-8912.png', 'ZXR10-8912', '2013-05-22 13:20:54', '4', '2013-05-22 13:20:54', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('450', 'ZXR10-8912-14', 'ZTE', 'ZXR10-8912槽位-14', '14', '417', 'image', '54', '320', '359', '40', 'red', '1', 'ZXR10-8912.png', 'ZXR10-8912', '2013-05-22 13:20:54', '4', '2013-05-22 13:20:54', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('452', 'ZXR10-8912-BLANK', 'ZTE', 'ZXR10-8912空白卡', '1', '0', 'image', '10', '10', '359', '40', 'red', '1', 'ZXR10-8912-BLANK.png', 'ZXR10-8912-BLANK', '2013-05-22 13:37:30', '4', '2013-05-22 13:37:30', '4', null, null, null, null, null, '2', '0', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('453', 'RS-8912-MSCII', 'ZTE', 'ZXR10-8912控制卡', '1', '0', 'image', '10', '10', '359', '40', 'red', '1', 'RS-8912-MSCII.png', 'RS-8912-MSCII', '2013-05-22 13:44:26', '4', '2013-05-22 13:44:26', '4', null, null, null, null, null, '2', '0', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('454', 'RS-89S2-48GE-RJ', 'ZTE', 'RS-89-S2-48-GE-RJ板卡，48口', '1', '0', 'image', '10', '10', '359', '40', 'red', '1', 'RS-89-S2-48-GE-RJ.png', 'RS-89-S2-48-GE-RJ', '2013-05-22 13:58:21', '4', '2013-05-22 13:58:21', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('455', 'RS-89H2-24GE-SF', 'ZTE', 'RS-89H2-24GE-SF板卡，24口', '1', '0', 'image', '10', '10', '359', '40', 'red', '1', 'RS-89H2-24GE-SF.png', 'RS-89H2-24GE-SF', '2013-05-22 13:59:50', '4', '2013-05-22 13:59:50', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('456', 'RS-89S2-4XGE-XFP', 'ZTE', 'RS-89S2-4XGE-XFP板卡，4口', '1', '0', 'image', '10', '10', '359', '40', 'red', '1', 'RS-89S2-4XGE-XFP.png', 'RS-89S2-4XGE-XFP', '2013-05-22 14:01:25', '4', '2013-05-22 14:01:25', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('457', 'RS-89-S2-48-GE-RJ-1', 'ZTE', 'RS-89-S2-48-GE-RJ端口-1', '1', '454', 'image', '13', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('458', 'RS-89-S2-48-GE-RJ-2', 'ZTE', 'RS-89-S2-48-GE-RJ端口-2', '2', '454', 'image', '13', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('459', 'RS-89-S2-48-GE-RJ-3', 'ZTE', 'RS-89-S2-48-GE-RJ端口-3', '3', '454', 'image', '26', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('460', 'RS-89-S2-48-GE-RJ-4', 'ZTE', 'RS-89-S2-48-GE-RJ端口-4', '4', '454', 'image', '26', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('461', 'RS-89-S2-48-GE-RJ-5', 'ZTE', 'RS-89-S2-48-GE-RJ端口-5', '5', '454', 'image', '39', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('462', 'RS-89-S2-48-GE-RJ-6', 'ZTE', 'RS-89-S2-48-GE-RJ端口-6', '6', '454', 'image', '39', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('463', 'RS-89-S2-48-GE-RJ-7', 'ZTE', 'RS-89-S2-48-GE-RJ端口-7', '7', '454', 'image', '52', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('464', 'RS-89-S2-48-GE-RJ-8', 'ZTE', 'RS-89-S2-48-GE-RJ端口-8', '8', '454', 'image', '52', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('465', 'RS-89-S2-48-GE-RJ-9', 'ZTE', 'RS-89-S2-48-GE-RJ端口-9', '9', '454', 'image', '65', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('466', 'RS-89-S2-48-GE-RJ-10', 'ZTE', 'RS-89-S2-48-GE-RJ端口-10', '10', '454', 'image', '65', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('467', 'RS-89-S2-48-GE-RJ-11', 'ZTE', 'RS-89-S2-48-GE-RJ端口-11', '11', '454', 'image', '78', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('468', 'RS-89-S2-48-GE-RJ-12', 'ZTE', 'RS-89-S2-48-GE-RJ端口-12', '12', '454', 'image', '78', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('469', 'RS-89-S2-48-GE-RJ-13', 'ZTE', 'RS-89-S2-48-GE-RJ端口-13', '13', '454', 'image', '97', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('470', 'RS-89-S2-48-GE-RJ-14', 'ZTE', 'RS-89-S2-48-GE-RJ端口-14', '14', '454', 'image', '97', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('471', 'RS-89-S2-48-GE-RJ-15', 'ZTE', 'RS-89-S2-48-GE-RJ端口-15', '15', '454', 'image', '110', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('472', 'RS-89-S2-48-GE-RJ-16', 'ZTE', 'RS-89-S2-48-GE-RJ端口-16', '16', '454', 'image', '110', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('473', 'RS-89-S2-48-GE-RJ-17', 'ZTE', 'RS-89-S2-48-GE-RJ端口-17', '17', '454', 'image', '123', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('474', 'RS-89-S2-48-GE-RJ-18', 'ZTE', 'RS-89-S2-48-GE-RJ端口-18', '18', '454', 'image', '123', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('475', 'RS-89-S2-48-GE-RJ-19', 'ZTE', 'RS-89-S2-48-GE-RJ端口-19', '19', '454', 'image', '136', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('476', 'RS-89-S2-48-GE-RJ-20', 'ZTE', 'RS-89-S2-48-GE-RJ端口-20', '20', '454', 'image', '136', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('477', 'RS-89-S2-48-GE-RJ-21', 'ZTE', 'RS-89-S2-48-GE-RJ端口-21', '21', '454', 'image', '149', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('478', 'RS-89-S2-48-GE-RJ-22', 'ZTE', 'RS-89-S2-48-GE-RJ端口-22', '22', '454', 'image', '149', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('479', 'RS-89-S2-48-GE-RJ-23', 'ZTE', 'RS-89-S2-48-GE-RJ端口-23', '23', '454', 'image', '162', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('480', 'RS-89-S2-48-GE-RJ-24', 'ZTE', 'RS-89-S2-48-GE-RJ端口-24', '24', '454', 'image', '162', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('481', 'RS-89-S2-48-GE-RJ-25', 'ZTE', 'RS-89-S2-48-GE-RJ端口-25', '25', '454', 'image', '181', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('482', 'RS-89-S2-48-GE-RJ-26', 'ZTE', 'RS-89-S2-48-GE-RJ端口-26', '26', '454', 'image', '181', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('483', 'RS-89-S2-48-GE-RJ-27', 'ZTE', 'RS-89-S2-48-GE-RJ端口-27', '27', '454', 'image', '194', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('484', 'RS-89-S2-48-GE-RJ-28', 'ZTE', 'RS-89-S2-48-GE-RJ端口-28', '28', '454', 'image', '194', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('485', 'RS-89-S2-48-GE-RJ-29', 'ZTE', 'RS-89-S2-48-GE-RJ端口-29', '29', '454', 'image', '207', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('486', 'RS-89-S2-48-GE-RJ-30', 'ZTE', 'RS-89-S2-48-GE-RJ端口-30', '30', '454', 'image', '207', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('487', 'RS-89-S2-48-GE-RJ-31', 'ZTE', 'RS-89-S2-48-GE-RJ端口-31', '31', '454', 'image', '220', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('488', 'RS-89-S2-48-GE-RJ-32', 'ZTE', 'RS-89-S2-48-GE-RJ端口-32', '32', '454', 'image', '220', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('489', 'RS-89-S2-48-GE-RJ-33', 'ZTE', 'RS-89-S2-48-GE-RJ端口-33', '33', '454', 'image', '233', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('490', 'RS-89-S2-48-GE-RJ-34', 'ZTE', 'RS-89-S2-48-GE-RJ端口-34', '34', '454', 'image', '233', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('491', 'RS-89-S2-48-GE-RJ-35', 'ZTE', 'RS-89-S2-48-GE-RJ端口-35', '35', '454', 'image', '246', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('492', 'RS-89-S2-48-GE-RJ-36', 'ZTE', 'RS-89-S2-48-GE-RJ端口-36', '36', '454', 'image', '246', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('493', 'RS-89-S2-48-GE-RJ-37', 'ZTE', 'RS-89-S2-48-GE-RJ端口-37', '37', '454', 'image', '265', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('494', 'RS-89-S2-48-GE-RJ-38', 'ZTE', 'RS-89-S2-48-GE-RJ端口-38', '38', '454', 'image', '265', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('495', 'RS-89-S2-48-GE-RJ-39', 'ZTE', 'RS-89-S2-48-GE-RJ端口-39', '39', '454', 'image', '278', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('496', 'RS-89-S2-48-GE-RJ-40', 'ZTE', 'RS-89-S2-48-GE-RJ端口-40', '40', '454', 'image', '278', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('497', 'RS-89-S2-48-GE-RJ-41', 'ZTE', 'RS-89-S2-48-GE-RJ端口-41', '41', '454', 'image', '291', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('498', 'RS-89-S2-48-GE-RJ-42', 'ZTE', 'RS-89-S2-48-GE-RJ端口-42', '42', '454', 'image', '291', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('499', 'RS-89-S2-48-GE-RJ-43', 'ZTE', 'RS-89-S2-48-GE-RJ端口-43', '43', '454', 'image', '304', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('500', 'RS-89-S2-48-GE-RJ-44', 'ZTE', 'RS-89-S2-48-GE-RJ端口-44', '44', '454', 'image', '304', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('501', 'RS-89-S2-48-GE-RJ-45', 'ZTE', 'RS-89-S2-48-GE-RJ端口-45', '45', '454', 'image', '317', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('502', 'RS-89-S2-48-GE-RJ-46', 'ZTE', 'RS-89-S2-48-GE-RJ端口-46', '46', '454', 'image', '317', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('503', 'RS-89-S2-48-GE-RJ-47', 'ZTE', 'RS-89-S2-48-GE-RJ端口-47', '47', '454', 'image', '330', '18', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ1.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('504', 'RS-89-S2-48-GE-RJ-48', 'ZTE', 'RS-89-S2-48-GE-RJ端口-48', '48', '454', 'image', '330', '5', '12', '8', 'red', '1', 'RS-89-S2-48-GE-RJ2.png', 'gei_[X]/[Y]', '2013-05-22 14:37:00', '4', '2013-05-22 14:37:00', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('505', 'RS-89H2-24GE-SF-1', 'ZTE', 'RS-89H2-24GE-SF端口-1', '1', '455', 'image', '171', '21', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('506', 'RS-89H2-24GE-SF-2', 'ZTE', 'RS-89H2-24GE-SF端口-2', '2', '455', 'image', '171', '7', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('507', 'RS-89H2-24GE-SF-3', 'ZTE', 'RS-89H2-24GE-SF端口-3', '3', '455', 'image', '185', '21', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('508', 'RS-89H2-24GE-SF-4', 'ZTE', 'RS-89H2-24GE-SF端口-4', '4', '455', 'image', '185', '7', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('509', 'RS-89H2-24GE-SF-5', 'ZTE', 'RS-89H2-24GE-SF端口-5', '5', '455', 'image', '199', '21', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('510', 'RS-89H2-24GE-SF-6', 'ZTE', 'RS-89H2-24GE-SF端口-6', '6', '455', 'image', '199', '7', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('511', 'RS-89H2-24GE-SF-7', 'ZTE', 'RS-89H2-24GE-SF端口-7', '7', '455', 'image', '213', '21', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('512', 'RS-89H2-24GE-SF-8', 'ZTE', 'RS-89H2-24GE-SF端口-8', '8', '455', 'image', '213', '7', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('513', 'RS-89H2-24GE-SF-9', 'ZTE', 'RS-89H2-24GE-SF端口-9', '9', '455', 'image', '227', '21', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('514', 'RS-89H2-24GE-SF-10', 'ZTE', 'RS-89H2-24GE-SF端口-10', '10', '455', 'image', '227', '7', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('515', 'RS-89H2-24GE-SF-11', 'ZTE', 'RS-89H2-24GE-SF端口-11', '11', '455', 'image', '241', '21', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('516', 'RS-89H2-24GE-SF-12', 'ZTE', 'RS-89H2-24GE-SF端口-12', '12', '455', 'image', '241', '7', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('517', 'RS-89H2-24GE-SF-13', 'ZTE', 'RS-89H2-24GE-SF端口-13', '13', '455', 'image', '259', '21', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('518', 'RS-89H2-24GE-SF-14', 'ZTE', 'RS-89H2-24GE-SF端口-14', '14', '455', 'image', '259', '7', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('519', 'RS-89H2-24GE-SF-15', 'ZTE', 'RS-89H2-24GE-SF端口-15', '15', '455', 'image', '273', '21', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('520', 'RS-89H2-24GE-SF-16', 'ZTE', 'RS-89H2-24GE-SF端口-16', '16', '455', 'image', '273', '7', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:16', '4', '2013-05-22 15:23:16', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('521', 'RS-89H2-24GE-SF-17', 'ZTE', 'RS-89H2-24GE-SF端口-17', '17', '455', 'image', '287', '21', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:17', '4', '2013-05-22 15:23:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('522', 'RS-89H2-24GE-SF-18', 'ZTE', 'RS-89H2-24GE-SF端口-18', '18', '455', 'image', '287', '7', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:17', '4', '2013-05-22 15:23:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('523', 'RS-89H2-24GE-SF-19', 'ZTE', 'RS-89H2-24GE-SF端口-19', '19', '455', 'image', '301', '21', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:17', '4', '2013-05-22 15:23:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('524', 'RS-89H2-24GE-SF-20', 'ZTE', 'RS-89H2-24GE-SF端口-20', '20', '455', 'image', '301', '7', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:17', '4', '2013-05-22 15:23:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('525', 'RS-89H2-24GE-SF-21', 'ZTE', 'RS-89H2-24GE-SF端口-21', '21', '455', 'image', '315', '21', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:17', '4', '2013-05-22 15:23:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('526', 'RS-89H2-24GE-SF-22', 'ZTE', 'RS-89H2-24GE-SF端口-22', '22', '455', 'image', '315', '7', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:17', '4', '2013-05-22 15:23:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('527', 'RS-89H2-24GE-SF-23', 'ZTE', 'RS-89H2-24GE-SF端口-23', '23', '455', 'image', '329', '21', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:17', '4', '2013-05-22 15:23:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('528', 'RS-89H2-24GE-SF-24', 'ZTE', 'RS-89H2-24GE-SF端口-24', '24', '455', 'image', '329', '7', '12', '8', 'red', '1', 'RS-89H2-24GE-SF_GEI.png', 'gei_[X]/[Y]', '2013-05-22 15:23:17', '4', '2013-05-22 15:23:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('529', 'RS-89S2-4XGE-XFP-1', 'ZTE', 'RS-89S2-4XGE-XFP端口-1', '1', '456', 'image', '80', '17', '13', '8', 'red', '1', 'RS-89S2-4XGE-XFP_XGEI.png', 'xgei_[X]/3', '2013-05-22 15:49:57', '4', '2013-05-22 15:49:57', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('530', 'RS-89S2-4XGE-XFP-2', 'ZTE', 'RS-89S2-4XGE-XFP端口-2', '2', '456', 'image', '142', '17', '13', '8', 'red', '1', 'RS-89S2-4XGE-XFP_XGEI.png', 'xgei_[X]/4', '2013-05-22 15:49:57', '4', '2013-05-22 15:49:57', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('531', 'RS-89S2-4XGE-XFP-3', 'ZTE', 'RS-89S2-4XGE-XFP端口-3', '3', '456', 'image', '209', '17', '13', '8', 'red', '1', 'RS-89S2-4XGE-XFP_XGEI.png', 'xgei_[X]/1', '2013-05-22 15:49:57', '4', '2013-05-22 15:49:57', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('532', 'RS-89S2-4XGE-XFP-4', 'ZTE', 'RS-89S2-4XGE-XFP端口-4', '4', '456', 'image', '273', '17', '13', '8', 'red', '1', 'RS-89S2-4XGE-XFP_XGEI.png', 'xgei_[X]/2', '2013-05-22 15:49:57', '4', '2013-05-22 15:49:57', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('533', 'HUAWEI-9312', 'HUAWEI', 'HUAWEI-9312', '1', '0', 'image', '35', '0', '442', '734', 'red', '1', 'HUAWEI-9312.png', 'HUAWEI-9312', '2013-05-23 10:50:31', '4', '2013-05-23 10:50:31', '4', 'DI_SYSTEM', null, null, null, null, '1', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('534', 'HUAWEI-9312-1', 'HUAWEI', 'HUAWEI-9312槽位-1', '1', '533', 'image', '25', '555', '373', '41', 'red', '1', 'HUAWEI-9312.png', 'HUAWEI-9312', '2013-05-23 10:57:40', '4', '2013-05-23 10:57:40', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('535', 'HUAWEI-9312-2', 'HUAWEI', 'HUAWEI-9312槽位-2', '2', '533', 'image', '25', '515', '373', '41', 'red', '1', 'HUAWEI-9312.png', 'HUAWEI-9312', '2013-05-23 10:57:40', '4', '2013-05-23 10:57:40', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('536', 'HUAWEI-9312-3', 'HUAWEI', 'HUAWEI-9312槽位-3', '3', '533', 'image', '25', '474', '373', '41', 'red', '1', 'HUAWEI-9312.png', 'HUAWEI-9312', '2013-05-23 10:57:40', '4', '2013-05-23 10:57:40', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('537', 'HUAWEI-9312-4', 'HUAWEI', 'HUAWEI-9312槽位-4', '4', '533', 'image', '25', '434', '373', '41', 'red', '1', 'HUAWEI-9312.png', 'HUAWEI-9312', '2013-05-23 10:57:40', '4', '2013-05-23 10:57:40', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('538', 'HUAWEI-9312-5', 'HUAWEI', 'HUAWEI-9312槽位-5', '5', '533', 'image', '25', '394', '373', '41', 'red', '1', 'HUAWEI-9312.png', 'HUAWEI-9312', '2013-05-23 10:57:40', '4', '2013-05-23 10:57:40', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('539', 'HUAWEI-9312-6', 'HUAWEI', 'HUAWEI-9312槽位-6', '6', '533', 'image', '25', '354', '373', '41', 'red', '1', 'HUAWEI-9312.png', 'HUAWEI-9312', '2013-05-23 10:57:40', '4', '2013-05-23 10:57:40', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('540', 'HUAWEI-9312-7', 'HUAWEI', 'HUAWEI-9312槽位-7', '7', '533', 'image', '25', '233', '373', '41', 'red', '1', 'HUAWEI-9312.png', 'HUAWEI-9312', '2013-05-23 10:57:40', '4', '2013-05-23 10:57:40', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('541', 'HUAWEI-9312-8', 'HUAWEI', 'HUAWEI-9312槽位-8', '8', '533', 'image', '25', '192', '373', '41', 'red', '1', 'HUAWEI-9312.png', 'HUAWEI-9312', '2013-05-23 10:57:40', '4', '2013-05-23 10:57:40', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('542', 'HUAWEI-9312-9', 'HUAWEI', 'HUAWEI-9312槽位-9', '9', '533', 'image', '25', '152', '373', '41', 'red', '1', 'HUAWEI-9312.png', 'HUAWEI-9312', '2013-05-23 10:57:40', '4', '2013-05-23 10:57:40', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('543', 'HUAWEI-9312-10', 'HUAWEI', 'HUAWEI-9312槽位-10', '10', '533', 'image', '25', '112', '373', '41', 'red', '1', 'HUAWEI-9312.png', 'HUAWEI-9312', '2013-05-23 10:57:40', '4', '2013-05-23 10:57:40', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('544', 'HUAWEI-9312-11', 'HUAWEI', 'HUAWEI-9312槽位-11', '11', '533', 'image', '25', '71', '373', '41', 'red', '1', 'HUAWEI-9312.png', 'HUAWEI-9312', '2013-05-23 10:57:40', '4', '2013-05-23 10:57:40', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('545', 'HUAWEI-9312-12', 'HUAWEI', 'HUAWEI-9312槽位-12', '12', '533', 'image', '25', '31', '373', '41', 'red', '1', 'HUAWEI-9312.png', 'HUAWEI-9312', '2013-05-23 10:57:40', '4', '2013-05-23 10:57:40', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('546', 'HUAWEI-9312-13', 'HUAWEI', 'HUAWEI-9312槽位-13', '13', '533', 'image', '25', '313', '373', '41', 'red', '1', 'HUAWEI-9312.png', 'HUAWEI-9312', '2013-05-23 10:57:40', '4', '2013-05-23 10:57:40', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('547', 'HUAWEI-9312-14', 'HUAWEI', 'HUAWEI-9312槽位-14', '14', '533', 'image', '25', '273', '373', '41', 'red', '1', 'HUAWEI-9312.png', 'HUAWEI-9312', '2013-05-23 10:57:40', '4', '2013-05-23 10:57:40', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('548', 'HUAWEI-9312-BLANK', 'HUAWEI', 'HUAWEI-9312-BLANK', '1', '0', 'image', '10', '10', '373', '41', 'red', '1', 'HUAWEI-9312-BLANK.png', 'HUAWEI-9312-BLANK', '2013-05-23 11:05:17', '4', '2013-05-23 11:05:17', '4', null, null, null, null, null, '2', '0', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('549', 'SRUA', 'HUAWEI', 'SRUA板卡', '1', '0', 'image', '10', '10', '373', '41', 'red', '1', 'SRUA.png', 'SRUA', '2013-05-23 11:11:39', '4', '2013-05-23 11:11:39', '4', null, null, null, null, null, '2', '0', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('550', 'X2UXC', 'HUAWEI', 'X2UXC板卡', '1', '0', 'image', '10', '10', '373', '41', 'red', '1', 'X2UXC.png', 'X2UXC', '2013-05-23 11:12:49', '4', '2013-05-23 11:12:49', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('551', 'X4UXC', 'HUAWEI', 'X4UXC板卡', '1', '0', 'image', '10', '10', '373', '41', 'red', '1', 'X4UXC.png', 'X4UXC', '2013-05-23 11:13:58', '4', '2013-05-23 11:13:58', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('552', 'G24SC', 'HUAWEI', 'G24SC板卡', '1', '0', 'image', '10', '10', '373', '41', 'red', '1', 'G24SC.png', 'G24SC', '2013-05-23 11:14:45', '4', '2013-05-23 11:14:45', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('553', 'G24SD', 'HUAWEI', 'G24SD板卡', '1', '0', 'image', '10', '10', '373', '41', 'red', '1', 'G24SD.png', 'G24SD', '2013-05-23 11:15:08', '4', '2013-05-23 11:15:08', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('554', 'F48TC', 'HUAWEI', 'F48TC板卡', '1', '0', 'image', '10', '10', '373', '41', 'red', '1', 'F48TC.png', 'F48TC', '2013-05-23 11:15:39', '4', '2013-05-23 11:15:39', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('555', 'G48TD', 'HUAWEI', 'G48TD', '1', '0', 'image', '10', '10', '373', '41', 'red', '1', 'G48TD.png', 'G48TD', '2013-05-23 11:15:57', '4', '2013-05-23 11:15:57', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('556', 'G48TD-0', 'HUAWEI', 'G48TD端口-0', '0', '555', 'image', '20', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:21:26', '4', '2013-05-23 11:21:26', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('557', 'G48TD-1', 'HUAWEI', 'G48TD端口-1', '1', '555', 'image', '20', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('558', 'G48TD-2', 'HUAWEI', 'G48TD端口-2', '2', '555', 'image', '33', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('559', 'G48TD-3', 'HUAWEI', 'G48TD端口-3', '3', '555', 'image', '33', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('560', 'G48TD-4', 'HUAWEI', 'G48TD端口-4', '4', '555', 'image', '46', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('561', 'G48TD-5', 'HUAWEI', 'G48TD端口-5', '5', '555', 'image', '46', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('562', 'G48TD-6', 'HUAWEI', 'G48TD端口-6', '6', '555', 'image', '59', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('563', 'G48TD-7', 'HUAWEI', 'G48TD端口-7', '7', '555', 'image', '59', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('564', 'G48TD-8', 'HUAWEI', 'G48TD端口-8', '8', '555', 'image', '72', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('565', 'G48TD-9', 'HUAWEI', 'G48TD端口-9', '9', '555', 'image', '72', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('566', 'G48TD-10', 'HUAWEI', 'G48TD端口-10', '10', '555', 'image', '85', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('567', 'G48TD-11', 'HUAWEI', 'G48TD端口-11', '11', '555', 'image', '85', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('568', 'G48TD-12', 'HUAWEI', 'G48TD端口-12', '12', '555', 'image', '104', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('569', 'G48TD-13', 'HUAWEI', 'G48TD端口-13', '13', '555', 'image', '104', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('570', 'G48TD-14', 'HUAWEI', 'G48TD端口-14', '14', '555', 'image', '117', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('571', 'G48TD-15', 'HUAWEI', 'G48TD端口-15', '15', '555', 'image', '117', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('572', 'G48TD-16', 'HUAWEI', 'G48TD端口-16', '16', '555', 'image', '130', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('573', 'G48TD-17', 'HUAWEI', 'G48TD端口-17', '17', '555', 'image', '130', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('574', 'G48TD-18', 'HUAWEI', 'G48TD端口-18', '18', '555', 'image', '143', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('575', 'G48TD-19', 'HUAWEI', 'G48TD端口-19', '19', '555', 'image', '143', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('576', 'G48TD-20', 'HUAWEI', 'G48TD端口-20', '20', '555', 'image', '156', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('577', 'G48TD-21', 'HUAWEI', 'G48TD端口-21', '21', '555', 'image', '156', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('578', 'G48TD-22', 'HUAWEI', 'G48TD端口-22', '22', '555', 'image', '169', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('579', 'G48TD-23', 'HUAWEI', 'G48TD端口-23', '23', '555', 'image', '169', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('580', 'G48TD-24', 'HUAWEI', 'G48TD端口-24', '24', '555', 'image', '188', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('581', 'G48TD-25', 'HUAWEI', 'G48TD端口-25', '25', '555', 'image', '188', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('582', 'G48TD-26', 'HUAWEI', 'G48TD端口-26', '26', '555', 'image', '201', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('583', 'G48TD-27', 'HUAWEI', 'G48TD端口-27', '27', '555', 'image', '201', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('584', 'G48TD-28', 'HUAWEI', 'G48TD端口-28', '28', '555', 'image', '214', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('585', 'G48TD-29', 'HUAWEI', 'G48TD端口-29', '29', '555', 'image', '214', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('586', 'G48TD-30', 'HUAWEI', 'G48TD端口-30', '30', '555', 'image', '227', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('587', 'G48TD-31', 'HUAWEI', 'G48TD端口-31', '31', '555', 'image', '227', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('588', 'G48TD-32', 'HUAWEI', 'G48TD端口-32', '32', '555', 'image', '240', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('589', 'G48TD-33', 'HUAWEI', 'G48TD端口-33', '33', '555', 'image', '240', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('590', 'G48TD-34', 'HUAWEI', 'G48TD端口-34', '34', '555', 'image', '253', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('591', 'G48TD-35', 'HUAWEI', 'G48TD端口-35', '35', '555', 'image', '253', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('592', 'G48TD-36', 'HUAWEI', 'G48TD端口-36', '36', '555', 'image', '272', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('593', 'G48TD-37', 'HUAWEI', 'G48TD端口-37', '37', '555', 'image', '272', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('594', 'G48TD-38', 'HUAWEI', 'G48TD端口-38', '38', '555', 'image', '285', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('595', 'G48TD-39', 'HUAWEI', 'G48TD端口-39', '39', '555', 'image', '285', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('596', 'G48TD-40', 'HUAWEI', 'G48TD端口-40', '40', '555', 'image', '298', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('597', 'G48TD-41', 'HUAWEI', 'G48TD端口-41', '41', '555', 'image', '298', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('598', 'G48TD-42', 'HUAWEI', 'G48TD端口-42', '42', '555', 'image', '311', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('599', 'G48TD-43', 'HUAWEI', 'G48TD端口-43', '43', '555', 'image', '311', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('600', 'G48TD-44', 'HUAWEI', 'G48TD端口-44', '44', '555', 'image', '324', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('601', 'G48TD-45', 'HUAWEI', 'G48TD端口-45', '45', '555', 'image', '324', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('602', 'G48TD-46', 'HUAWEI', 'G48TD端口-46', '46', '555', 'image', '337', '4', '12', '8', 'red', '1', 'G48TD0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('603', 'G48TD-47', 'HUAWEI', 'G48TD端口-47', '47', '555', 'image', '337', '18', '12', '8', 'red', '1', 'G48TD1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 11:22:51', '4', '2013-05-23 11:22:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('604', 'F48TC-0', 'HUAWEI', 'F48TC端口-0', '0', '554', 'image', '20', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('605', 'F48TC-1', 'HUAWEI', 'F48TC端口-1', '1', '554', 'image', '20', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('606', 'F48TC-2', 'HUAWEI', 'F48TC端口-2', '2', '554', 'image', '33', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('607', 'F48TC-3', 'HUAWEI', 'F48TC端口-3', '3', '554', 'image', '33', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('608', 'F48TC-4', 'HUAWEI', 'F48TC端口-4', '4', '554', 'image', '46', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('609', 'F48TC-5', 'HUAWEI', 'F48TC端口-5', '5', '554', 'image', '46', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('610', 'F48TC-6', 'HUAWEI', 'F48TC端口-6', '6', '554', 'image', '59', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('611', 'F48TC-7', 'HUAWEI', 'F48TC端口-7', '7', '554', 'image', '59', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('612', 'F48TC-8', 'HUAWEI', 'F48TC端口-8', '8', '554', 'image', '72', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('613', 'F48TC-9', 'HUAWEI', 'F48TC端口-9', '9', '554', 'image', '72', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('614', 'F48TC-10', 'HUAWEI', 'F48TC端口-10', '10', '554', 'image', '85', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('615', 'F48TC-11', 'HUAWEI', 'F48TC端口-11', '11', '554', 'image', '85', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('616', 'F48TC-12', 'HUAWEI', 'F48TC端口-12', '12', '554', 'image', '104', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('617', 'F48TC-13', 'HUAWEI', 'F48TC端口-13', '13', '554', 'image', '104', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('618', 'F48TC-14', 'HUAWEI', 'F48TC端口-14', '14', '554', 'image', '117', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('619', 'F48TC-15', 'HUAWEI', 'F48TC端口-15', '15', '554', 'image', '117', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('620', 'F48TC-16', 'HUAWEI', 'F48TC端口-16', '16', '554', 'image', '130', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('621', 'F48TC-17', 'HUAWEI', 'F48TC端口-17', '17', '554', 'image', '130', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('622', 'F48TC-18', 'HUAWEI', 'F48TC端口-18', '18', '554', 'image', '143', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('623', 'F48TC-19', 'HUAWEI', 'F48TC端口-19', '19', '554', 'image', '143', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('624', 'F48TC-20', 'HUAWEI', 'F48TC端口-20', '20', '554', 'image', '156', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('625', 'F48TC-21', 'HUAWEI', 'F48TC端口-21', '21', '554', 'image', '156', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('626', 'F48TC-22', 'HUAWEI', 'F48TC端口-22', '22', '554', 'image', '169', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('627', 'F48TC-23', 'HUAWEI', 'F48TC端口-23', '23', '554', 'image', '169', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('628', 'F48TC-24', 'HUAWEI', 'F48TC端口-24', '24', '554', 'image', '188', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('629', 'F48TC-25', 'HUAWEI', 'F48TC端口-25', '25', '554', 'image', '188', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('630', 'F48TC-26', 'HUAWEI', 'F48TC端口-26', '26', '554', 'image', '201', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('631', 'F48TC-27', 'HUAWEI', 'F48TC端口-27', '27', '554', 'image', '201', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('632', 'F48TC-28', 'HUAWEI', 'F48TC端口-28', '28', '554', 'image', '214', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('633', 'F48TC-29', 'HUAWEI', 'F48TC端口-29', '29', '554', 'image', '214', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('634', 'F48TC-30', 'HUAWEI', 'F48TC端口-30', '30', '554', 'image', '227', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('635', 'F48TC-31', 'HUAWEI', 'F48TC端口-31', '31', '554', 'image', '227', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('636', 'F48TC-32', 'HUAWEI', 'F48TC端口-32', '32', '554', 'image', '240', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('637', 'F48TC-33', 'HUAWEI', 'F48TC端口-33', '33', '554', 'image', '240', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('638', 'F48TC-34', 'HUAWEI', 'F48TC端口-34', '34', '554', 'image', '253', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('639', 'F48TC-35', 'HUAWEI', 'F48TC端口-35', '35', '554', 'image', '253', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('640', 'F48TC-36', 'HUAWEI', 'F48TC端口-36', '36', '554', 'image', '272', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('641', 'F48TC-37', 'HUAWEI', 'F48TC端口-37', '37', '554', 'image', '272', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('642', 'F48TC-38', 'HUAWEI', 'F48TC端口-38', '38', '554', 'image', '285', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('643', 'F48TC-39', 'HUAWEI', 'F48TC端口-39', '39', '554', 'image', '285', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('644', 'F48TC-40', 'HUAWEI', 'F48TC端口-40', '40', '554', 'image', '298', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('645', 'F48TC-41', 'HUAWEI', 'F48TC端口-41', '41', '554', 'image', '298', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('646', 'F48TC-42', 'HUAWEI', 'F48TC端口-42', '42', '554', 'image', '311', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('647', 'F48TC-43', 'HUAWEI', 'F48TC端口-43', '43', '554', 'image', '311', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('648', 'F48TC-44', 'HUAWEI', 'F48TC端口-44', '44', '554', 'image', '324', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('649', 'F48TC-45', 'HUAWEI', 'F48TC端口-45', '45', '554', 'image', '324', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('650', 'F48TC-46', 'HUAWEI', 'F48TC端口-46', '46', '554', 'image', '337', '4', '12', '8', 'red', '1', 'F48TC0.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('651', 'F48TC-47', 'HUAWEI', 'F48TC端口-47', '47', '554', 'image', '337', '18', '12', '8', 'red', '1', 'F48TC1.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:15:24', '4', '2013-05-23 14:15:24', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('677', 'G24SD-0', 'HUAWEI', 'G24SD端口-0', '0', '553', 'image', '99', '5', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('678', 'G24SD-1', 'HUAWEI', 'G24SD端口-1', '1', '553', 'image', '99', '20', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('679', 'G24SD-2', 'HUAWEI', 'G24SD端口-2', '2', '553', 'image', '114', '5', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('680', 'G24SD-3', 'HUAWEI', 'G24SD端口-3', '3', '553', 'image', '114', '20', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('681', 'G24SD-4', 'HUAWEI', 'G24SD端口-4', '4', '553', 'image', '129', '5', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('682', 'G24SD-5', 'HUAWEI', 'G24SD端口-5', '5', '553', 'image', '129', '20', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('683', 'G24SD-6', 'HUAWEI', 'G24SD端口-6', '6', '553', 'image', '144', '5', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('684', 'G24SD-7', 'HUAWEI', 'G24SD端口-7', '7', '553', 'image', '144', '20', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('685', 'G24SD-8', 'HUAWEI', 'G24SD端口-8', '8', '553', 'image', '159', '5', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('686', 'G24SD-9', 'HUAWEI', 'G24SD端口-9', '9', '553', 'image', '159', '20', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('687', 'G24SD-10', 'HUAWEI', 'G24SD端口-10', '10', '553', 'image', '174', '5', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('688', 'G24SD-11', 'HUAWEI', 'G24SD端口-11', '11', '553', 'image', '174', '20', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('689', 'G24SD-12', 'HUAWEI', 'G24SD端口-12', '12', '553', 'image', '188', '5', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('690', 'G24SD-13', 'HUAWEI', 'G24SD端口-13', '13', '553', 'image', '188', '20', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('691', 'G24SD-14', 'HUAWEI', 'G24SD端口-14', '14', '553', 'image', '203', '5', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('692', 'G24SD-15', 'HUAWEI', 'G24SD端口-15', '15', '553', 'image', '203', '20', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('693', 'G24SD-16', 'HUAWEI', 'G24SD端口-16', '16', '553', 'image', '218', '5', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('694', 'G24SD-17', 'HUAWEI', 'G24SD端口-17', '17', '553', 'image', '218', '20', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('695', 'G24SD-18', 'HUAWEI', 'G24SD端口-18', '18', '553', 'image', '233', '5', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('696', 'G24SD-19', 'HUAWEI', 'G24SD端口-19', '19', '553', 'image', '233', '20', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('697', 'G24SD-20', 'HUAWEI', 'G24SD端口-20', '20', '553', 'image', '248', '5', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('698', 'G24SD-21', 'HUAWEI', 'G24SD端口-21', '21', '553', 'image', '248', '20', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('699', 'G24SD-22', 'HUAWEI', 'G24SD端口-22', '22', '553', 'image', '263', '5', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('700', 'G24SD-23', 'HUAWEI', 'G24SD端口-23', '23', '553', 'image', '263', '20', '13', '8', 'red', '1', 'G24SD_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 14:47:53', '4', '2013-05-23 14:47:53', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('701', 'G24SC-0', 'HUAWEI', 'G24SC端口-0', '0', '552', 'image', '99', '5', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('702', 'G24SC-1', 'HUAWEI', 'G24SC端口-1', '1', '552', 'image', '99', '20', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('703', 'G24SC-2', 'HUAWEI', 'G24SC端口-2', '2', '552', 'image', '114', '5', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('704', 'G24SC-3', 'HUAWEI', 'G24SC端口-3', '3', '552', 'image', '114', '20', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('705', 'G24SC-4', 'HUAWEI', 'G24SC端口-4', '4', '552', 'image', '129', '5', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('706', 'G24SC-5', 'HUAWEI', 'G24SC端口-5', '5', '552', 'image', '129', '20', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('707', 'G24SC-6', 'HUAWEI', 'G24SC端口-6', '6', '552', 'image', '144', '5', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('708', 'G24SC-7', 'HUAWEI', 'G24SC端口-7', '7', '552', 'image', '144', '20', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('709', 'G24SC-8', 'HUAWEI', 'G24SC端口-8', '8', '552', 'image', '159', '5', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('710', 'G24SC-9', 'HUAWEI', 'G24SC端口-9', '9', '552', 'image', '159', '20', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('711', 'G24SC-10', 'HUAWEI', 'G24SC端口-10', '10', '552', 'image', '174', '5', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('712', 'G24SC-11', 'HUAWEI', 'G24SC端口-11', '11', '552', 'image', '174', '20', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('713', 'G24SC-12', 'HUAWEI', 'G24SC端口-12', '12', '552', 'image', '188', '5', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('714', 'G24SC-13', 'HUAWEI', 'G24SC端口-13', '13', '552', 'image', '188', '20', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('715', 'G24SC-14', 'HUAWEI', 'G24SC端口-14', '14', '552', 'image', '203', '5', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('716', 'G24SC-15', 'HUAWEI', 'G24SC端口-15', '15', '552', 'image', '203', '20', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('717', 'G24SC-16', 'HUAWEI', 'G24SC端口-16', '16', '552', 'image', '218', '5', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('718', 'G24SC-17', 'HUAWEI', 'G24SC端口-17', '17', '552', 'image', '218', '20', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('719', 'G24SC-18', 'HUAWEI', 'G24SC端口-18', '18', '552', 'image', '233', '5', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('720', 'G24SC-19', 'HUAWEI', 'G24SC端口-19', '19', '552', 'image', '233', '20', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('721', 'G24SC-20', 'HUAWEI', 'G24SC端口-20', '20', '552', 'image', '248', '5', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('722', 'G24SC-21', 'HUAWEI', 'G24SC端口-21', '21', '552', 'image', '248', '20', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('723', 'G24SC-22', 'HUAWEI', 'G24SC端口-22', '22', '552', 'image', '263', '5', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('724', 'G24SC-23', 'HUAWEI', 'G24SC端口-23', '23', '552', 'image', '263', '20', '13', '8', 'red', '1', 'G24SC_GE.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-23 15:26:21', '4', '2013-05-23 15:26:21', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('725', 'X4UXC-0', 'HUAWEI', 'X4UXC端口-0', '0', '551', 'image', '90', '22', '12', '8', 'red', '1', 'X4UXC_XGE.png', 'XGigabitEthernet[X]/0/[Y]', '2013-05-23 15:31:51', '4', '2013-05-23 15:31:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('726', 'X4UXC-1', 'HUAWEI', 'X4UXC端口-1', '1', '551', 'image', '150', '22', '12', '8', 'red', '1', 'X4UXC_XGE.png', 'XGigabitEthernet[X]/0/[Y]', '2013-05-23 15:31:51', '4', '2013-05-23 15:31:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('727', 'X4UXC-2', 'HUAWEI', 'X4UXC端口-2', '2', '551', 'image', '209', '22', '12', '8', 'red', '1', 'X4UXC_XGE.png', 'XGigabitEthernet[X]/0/[Y]', '2013-05-23 15:31:51', '4', '2013-05-23 15:31:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('728', 'X4UXC-3', 'HUAWEI', 'X4UXC端口-3', '3', '551', 'image', '269', '22', '12', '8', 'red', '1', 'X4UXC_XGE.png', 'XGigabitEthernet[X]/0/[Y]', '2013-05-23 15:31:51', '4', '2013-05-23 15:31:51', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('729', 'X2UXC-0', 'HUAWEI', 'X2UXC端口-0', '0', '550', 'image', '153', '22', '12', '8', 'red', '1', 'X2UXC_XGE.png', 'XGigabitEthernet[X]/0/[Y]', '2013-05-23 15:33:45', '4', '2013-05-23 15:33:45', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('730', 'X2UXC-1', 'HUAWEI', 'X2UXC端口-1', '1', '550', 'image', '212', '21', '12', '8', 'red', '1', 'X2UXC_XGE.png', 'XGigabitEthernet[X]/0/[Y]', '2013-05-23 15:33:45', '4', '2013-05-23 15:33:45', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('737', 'HUAWEI-SSP3000', 'HUAWEI', 'HUAWEI-SSP3000机框', '1', '0', 'image', '35', '0', '442', '1337', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 15:57:17', '4', '2013-05-24 15:57:17', '4', 'DI_SYSTEM', null, null, null, null, '1', '0', '0', '2', '0', '1');
INSERT INTO `device_type_info` VALUES ('738', 'HUAWEI-SSP3000-1', 'HUAWEI', 'HUAWEI-SSP3000槽位-1', '1', '737', 'image', '27', '232', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('739', 'HUAWEI-SSP3000-2', 'HUAWEI', 'HUAWEI-SSP3000槽位-2', '2', '737', 'image', '62', '232', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('740', 'HUAWEI-SSP3000-3', 'HUAWEI', 'HUAWEI-SSP3000槽位-3', '3', '737', 'image', '97', '232', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('741', 'HUAWEI-SSP3000-4', 'HUAWEI', 'HUAWEI-SSP3000槽位-4', '4', '737', 'image', '132', '232', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('742', 'HUAWEI-SSP3000-5', 'HUAWEI', 'HUAWEI-SSP3000槽位-5', '5', '737', 'image', '237', '232', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('743', 'HUAWEI-SSP3000-6', 'HUAWEI', 'HUAWEI-SSP3000槽位-6', '6', '737', 'image', '272', '232', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('744', 'HUAWEI-SSP3000-7', 'HUAWEI', 'HUAWEI-SSP3000槽位-7', '7', '737', 'image', '307', '232', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('745', 'HUAWEI-SSP3000-8', 'HUAWEI', 'HUAWEI-SSP3000槽位-8', '8', '737', 'image', '342', '232', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('746', 'HUAWEI-SSP3000-9', 'HUAWEI', 'HUAWEI-SSP3000槽位-9', '9', '737', 'image', '377', '232', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('747', 'HUAWEI-SSP3000-10', 'HUAWEI', 'HUAWEI-SSP3000槽位-10', '10', '737', 'image', '27', '667', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('748', 'HUAWEI-SSP3000-11', 'HUAWEI', 'HUAWEI-SSP3000槽位-11', '11', '737', 'image', '62', '667', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('749', 'HUAWEI-SSP3000-12', 'HUAWEI', 'HUAWEI-SSP3000槽位-12', '12', '737', 'image', '97', '667', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('750', 'HUAWEI-SSP3000-13', 'HUAWEI', 'HUAWEI-SSP3000槽位-13', '13', '737', 'image', '132', '667', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('751', 'HUAWEI-SSP3000-14', 'HUAWEI', 'HUAWEI-SSP3000槽位-14', '14', '737', 'image', '307', '667', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('752', 'HUAWEI-SSP3000-15', 'HUAWEI', 'HUAWEI-SSP3000槽位-15', '15', '737', 'image', '342', '667', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('753', 'HUAWEI-SSP3000-16', 'HUAWEI', 'HUAWEI-SSP3000槽位-16', '16', '737', 'image', '377', '667', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('754', 'HUAWEI-SSP3000-17', 'HUAWEI', 'HUAWEI-SSP3000槽位-17', '-1', '737', 'image', '167', '232', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('755', 'HUAWEI-SSP3000-18', 'HUAWEI', 'HUAWEI-SSP3000槽位-18', '-1', '737', 'image', '202', '232', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('756', 'HUAWEI-SSP3000-19', 'HUAWEI', 'HUAWEI-SSP3000槽位-19', '-1', '737', 'image', '167', '667', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('757', 'HUAWEI-SSP3000-20', 'HUAWEI', 'HUAWEI-SSP3000槽位-20', '-1', '737', 'image', '202', '667', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('758', 'HUAWEI-SSP3000-21', 'HUAWEI', 'HUAWEI-SSP3000槽位-21', '-1', '737', 'image', '237', '667', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('759', 'HUAWEI-SSP3000-22', 'HUAWEI', 'HUAWEI-SSP3000槽位-22', '-1', '737', 'image', '272', '667', '35', '382', 'red', '1', 'HUAWEI-SSP3000.png', 'HUAWEI-SSP3000', '2013-05-24 16:48:08', '4', '2013-05-24 16:48:08', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '1');
INSERT INTO `device_type_info` VALUES ('760', 'HUAWEI-SSP3000-BLANK', 'HUAWEI', 'HUAWEI-SSP3000-BLANK板卡', '1', '0', 'image', '10', '10', '35', '382', 'red', '1', 'HUAWEI-SSP3000-BLANK.png', 'HUAWEI-SSP3000-BLANK', '2013-05-24 17:00:13', '4', '2013-05-24 17:00:13', '4', null, null, null, null, null, '2', '0', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('761', 'SX11MPUB0', 'HUAWEI', 'SX11MPUB0板卡', '1', '0', 'image', '10', '10', '35', '382', 'red', '1', 'SX11MPUB0.png', 'SX11MPUB0', '2013-05-24 17:06:25', '4', '2013-05-24 17:06:25', '4', null, null, null, null, null, '2', '0', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('762', 'SX11E2XXD0', 'HUAWEI', 'SX11E2XXD0板卡', '1', '0', 'image', '10', '10', '35', '382', 'red', '1', 'SX11E2XXD0.png', 'SX11E2XXD0', '2013-05-24 17:10:42', '4', '2013-05-24 17:10:42', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('763', 'SX11P2XXD0', 'HUAWEI', 'SX11P2XXD0板卡', '1', '0', 'image', '10', '10', '35', '382', 'red', '1', 'SX11P2XXD0.png', 'SX11P2XXD0', '2013-05-24 17:11:20', '4', '2013-05-24 17:11:20', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('764', 'SX11P8UFD0', 'HUAWEI', 'SX11P8UFD0板卡', '1', '0', 'image', '10', '10', '35', '382', 'red', '1', 'SX11P8UFD0.png', 'SX11P8UFD0', '2013-05-24 17:11:52', '4', '2013-05-24 17:11:52', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('765', 'CONTROL19-22', 'HUAWEI', 'CONTROL19-22板卡', '1', '0', 'image', '10', '10', '35', '382', 'red', '1', 'CONTROL19-22.png', 'CONTROL19-22', '2013-05-24 17:12:22', '4', '2013-05-24 17:12:22', '4', null, null, null, null, null, '2', '0', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('777', 'SX11P8CFB0', 'HUAWEI', 'SX11P8CFB0板卡', '1', '0', 'image', '10', '10', '35', '382', 'red', '1', 'SX11P8CFB0.png', 'SX11P8CFB0', '2013-05-27 13:16:24', '4', '2013-05-27 13:16:24', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('778', 'SX11P8UFD0-0', 'HUAWEI', 'SX11P8UFD0端口-0', '0', '764', 'image', '13', '63', '8', '12', 'red', '1', 'SX11P8UFD0_POS.png', 'Pos[X]/0/0', '2013-05-27 13:52:57', '4', '2013-05-27 13:52:57', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('779', 'SX11P8UFD0-1', 'HUAWEI', 'SX11P8UFD0端口-1', '1', '764', 'image', '13', '77', '8', '12', 'red', '1', 'SX11P8UFD0_POS.png', 'Pos[X]/0/1', '2013-05-27 13:52:57', '4', '2013-05-27 13:52:57', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('780', 'SX11P8UFD0-2', 'HUAWEI', 'SX11P8UFD0端口-2', '2', '764', 'image', '13', '91', '8', '12', 'red', '1', 'SX11P8UFD0_POS.png', 'Pos[X]/0/2', '2013-05-27 13:52:57', '4', '2013-05-27 13:52:57', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('781', 'SX11P8UFD0-3', 'HUAWEI', 'SX11P8UFD0端口-3', '3', '764', 'image', '13', '105', '8', '12', 'red', '1', 'SX11P8UFD0_POS.png', 'Pos[X]/0/3', '2013-05-27 13:52:57', '4', '2013-05-27 13:52:57', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('782', 'SX11P8UFD0-4', 'HUAWEI', 'SX11P8UFD0端口-4', '4', '764', 'image', '13', '226', '8', '12', 'red', '1', 'SX11P8UFD0_POS.png', 'Pos[X]/1/0', '2013-05-27 13:54:03', '4', '2013-05-27 13:54:03', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('783', 'SX11P8UFD0-5', 'HUAWEI', 'SX11P8UFD0端口-5', '5', '764', 'image', '13', '240', '8', '12', 'red', '1', 'SX11P8UFD0_POS.png', 'Pos[X]/1/1', '2013-05-27 13:54:03', '4', '2013-05-27 13:54:03', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('784', 'SX11P8UFD0-6', 'HUAWEI', 'SX11P8UFD0端口-6', '6', '764', 'image', '13', '254', '8', '12', 'red', '1', 'SX11P8UFD0_POS.png', 'Pos[X]/1/2', '2013-05-27 13:54:03', '4', '2013-05-27 13:54:03', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('785', 'SX11P8UFD0-7', 'HUAWEI', 'SX11P8UFD0端口-7', '7', '764', 'image', '13', '268', '8', '12', 'red', '1', 'SX11P8UFD0_POS.png', 'Pos[X]/1/3', '2013-05-27 13:54:03', '4', '2013-05-27 13:54:03', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('786', 'SX11P8CFB0-0', 'HUAWEI', 'SX11P8CFB0端口-0', '0', '777', 'image', '13', '76', '8', '12', 'red', '1', 'SX11P8CFB0_POS.png', 'Pos[X]/0/0', '2013-05-27 14:02:41', '4', '2013-05-27 14:02:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('787', 'SX11P8CFB0-1', 'HUAWEI', 'SX11P8CFB0端口-1', '1', '777', 'image', '13', '91', '8', '12', 'red', '1', 'SX11P8CFB0_POS.png', 'Pos[X]/0/1', '2013-05-27 14:02:41', '4', '2013-05-27 14:02:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('788', 'SX11P8CFB0-2', 'HUAWEI', 'SX11P8CFB0端口-2', '2', '777', 'image', '13', '105', '8', '12', 'red', '1', 'SX11P8CFB0_POS.png', 'Pos[X]/0/2', '2013-05-27 14:02:41', '4', '2013-05-27 14:02:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('789', 'SX11P8CFB0-3', 'HUAWEI', 'SX11P8CFB0端口-3', '3', '777', 'image', '13', '119', '8', '12', 'red', '1', 'SX11P8CFB0_POS.png', 'Pos[X]/0/3', '2013-05-27 14:02:41', '4', '2013-05-27 14:02:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('790', 'SX11P8CFB0-4', 'HUAWEI', 'SX11P8CFB0端口-4', '4', '777', 'image', '13', '141', '8', '12', 'red', '1', 'SX11P8CFB0_POS.png', 'Pos[X]/0/4', '2013-05-27 14:02:41', '4', '2013-05-27 14:02:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('791', 'SX11P8CFB0-5', 'HUAWEI', 'SX11P8CFB0端口-5', '5', '777', 'image', '13', '156', '8', '12', 'red', '1', 'SX11P8CFB0_POS.png', 'Pos[X]/0/5', '2013-05-27 14:02:41', '4', '2013-05-27 14:02:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('792', 'SX11P8CFB0-6', 'HUAWEI', 'SX11P8CFB0端口-6', '6', '777', 'image', '13', '171', '8', '12', 'red', '1', 'SX11P8CFB0_POS.png', 'Pos[X]/0/6', '2013-05-27 14:02:41', '4', '2013-05-27 14:02:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('793', 'SX11P8CFB0-7', 'HUAWEI', 'SX11P8CFB0端口-7', '7', '777', 'image', '13', '185', '8', '12', 'red', '1', 'SX11P8CFB0_POS.png', 'Pos[X]/0/7', '2013-05-27 14:02:41', '4', '2013-05-27 14:02:41', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('794', 'SX11E2XXD0-0', 'HUAWEI', 'SX11E2XXD0端口-0', '0', '762', 'image', '10', '123', '8', '12', 'red', '1', 'SX11E2XXD0_GEI.png', 'GigabitEthernet[X]/0/0', '2013-05-27 14:05:04', '4', '2013-05-27 14:05:04', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('795', 'SX11E2XXD0-1', 'HUAWEI', 'SX11E2XXD0端口-1', '1', '762', 'image', '10', '300', '8', '12', 'red', '1', 'SX11E2XXD0_GEI.png', 'GigabitEthernet[X]/1/0', '2013-05-27 14:05:04', '4', '2013-05-27 14:05:04', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('796', 'SX11P2XXD0-0', 'HUAWEI', 'SX11P2XXD0端口-0', '0', '763', 'image', '10', '123', '8', '12', 'red', '1', 'SX11P2XXD0_POS.png', 'Pos[X]/0/0', '2013-05-27 14:07:20', '4', '2013-05-27 14:07:20', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('797', 'SX11P2XXD0-1', 'HUAWEI', 'SX11P2XXD0端口-1', '1', '763', 'image', '10', '300', '8', '12', 'red', '1', 'SX11P2XXD0_POS.png', 'Pos[X]/1/0', '2013-05-27 14:07:20', '4', '2013-05-27 14:07:20', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('837', 'H3C-S12518', 'H3C', 'H3C-S12518机框', '1', '0', 'image', '10', '10', '442', '1700', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:53:15', '4', '2013-05-29 10:53:15', '4', 'DI_SYSTEM', null, null, null, null, '1', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('838', 'H3C-S12518-0', 'H3C', 'H3C-S12518槽位-0', '0', '837', 'image', '15', '524', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('839', 'H3C-S12518-1', 'H3C', 'H3C-S12518槽位-1', '1', '837', 'image', '56', '524', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('840', 'H3C-S12518-2', 'H3C', 'H3C-S12518槽位-2', '2', '837', 'image', '97', '524', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('841', 'H3C-S12518-3', 'H3C', 'H3C-S12518槽位-3', '3', '837', 'image', '138', '524', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('842', 'H3C-S12518-4', 'H3C', 'H3C-S12518槽位-4', '4', '837', 'image', '179', '524', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('843', 'H3C-S12518-5', 'H3C', 'H3C-S12518槽位-5', '5', '837', 'image', '220', '524', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('844', 'H3C-S12518-6', 'H3C', 'H3C-S12518槽位-6', '6', '837', 'image', '261', '524', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('845', 'H3C-S12518-7', 'H3C', 'H3C-S12518槽位-7', '7', '837', 'image', '302', '524', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('846', 'H3C-S12518-8', 'H3C', 'H3C-S12518槽位-8', '8', '837', 'image', '343', '524', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('847', 'H3C-S12518-9', 'H3C', 'H3C-S12518槽位-9', '9', '837', 'image', '384', '524', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('848', 'H3C-S12518-10', 'H3C', 'H3C-S12518槽位-10', '10', '837', 'image', '15', '973', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('849', 'H3C-S12518-11', 'H3C', 'H3C-S12518槽位-11', '11', '837', 'image', '56', '973', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('850', 'H3C-S12518-12', 'H3C', 'H3C-S12518槽位-12', '12', '837', 'image', '97', '973', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('851', 'H3C-S12518-13', 'H3C', 'H3C-S12518槽位-13', '13', '837', 'image', '138', '973', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('852', 'H3C-S12518-14', 'H3C', 'H3C-S12518槽位-14', '14', '837', 'image', '179', '973', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('853', 'H3C-S12518-15', 'H3C', 'H3C-S12518槽位-15', '15', '837', 'image', '220', '973', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('854', 'H3C-S12518-16', 'H3C', 'H3C-S12518槽位-16', '16', '837', 'image', '261', '973', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('855', 'H3C-S12518-17', 'H3C', 'H3C-S12518槽位-17', '17', '837', 'image', '302', '973', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('856', 'H3C-S12518-18', 'H3C', 'H3C-S12518槽位-18', '18', '837', 'image', '343', '973', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('857', 'H3C-S12518-19', 'H3C', 'H3C-S12518槽位-19', '19', '837', 'image', '384', '973', '41', '427', 'red', '1', 'H3C-S12518.png', 'H3C-S12518', '2013-05-29 10:57:04', '4', '2013-05-29 10:57:04', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('858', 'H3C-S12518-BLANK', 'H3C', 'H3C-S12518-BLANK板卡', '1', '0', 'image', '10', '10', '41', '427', 'red', '1', 'H3C-S12518-BLANK.png', 'H3C-S12518-BLANK', '2013-05-29 11:05:40', '4', '2013-05-29 11:05:40', '4', null, null, null, null, null, '2', '0', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('859', 'LST1MRPNC1', 'H3C', 'LST1MRPNC1控制板卡', '1', '0', 'image', '10', '10', '41', '427', 'red', '1', 'LST1MRPNC1.png', 'LST1MRPNC1', '2013-05-29 11:07:16', '4', '2013-05-29 11:07:16', '4', null, null, null, null, null, '2', '0', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('860', 'LST1XP16LEY1', 'H3C', 'LST1XP16LEY1板卡', '1', '0', 'image', '10', '10', '41', '427', 'red', '1', 'LST1XP16LEY1.png', 'LST1XP16LEY1', '2013-05-29 11:08:15', '4', '2013-05-29 11:08:15', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('861', '10GBASE-R-SFP+', 'H3C', '10GBASE-R-SFP+板卡', '1', '0', 'image', '10', '10', '41', '427', 'red', '1', '10GBASE-R-SFP+.png', '10GBASE-R-SFP+', '2013-05-29 11:08:45', '4', '2013-05-29 11:08:45', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('862', 'LST1XP16LEY1-1', 'H3C', 'LST1XP16LEY1端口-1', '1', '860', 'image', '11', '232', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/1', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('863', 'LST1XP16LEY1-2', 'H3C', 'LST1XP16LEY1端口-2', '2', '860', 'image', '23', '232', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/2', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('864', 'LST1XP16LEY1-3', 'H3C', 'LST1XP16LEY1端口-3', '3', '860', 'image', '11', '218', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/3', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('865', 'LST1XP16LEY1-4', 'H3C', 'LST1XP16LEY1端口-4', '4', '860', 'image', '23', '218', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/4', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('866', 'LST1XP16LEY1-5', 'H3C', 'LST1XP16LEY1端口-5', '5', '860', 'image', '11', '204', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/5', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('867', 'LST1XP16LEY1-6', 'H3C', 'LST1XP16LEY1端口-6', '6', '860', 'image', '23', '204', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/6', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('868', 'LST1XP16LEY1-7', 'H3C', 'LST1XP16LEY1端口-7', '7', '860', 'image', '11', '190', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/7', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('869', 'LST1XP16LEY1-8', 'H3C', 'LST1XP16LEY1端口-8', '8', '860', 'image', '23', '190', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/8', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('870', 'LST1XP16LEY1-9', 'H3C', 'LST1XP16LEY1端口-9', '9', '860', 'image', '11', '132', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/9', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('871', 'LST1XP16LEY1-10', 'H3C', 'LST1XP16LEY1端口-10', '10', '860', 'image', '23', '132', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/10', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('872', 'LST1XP16LEY1-11', 'H3C', 'LST1XP16LEY1端口-11', '11', '860', 'image', '11', '118', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/11', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('873', 'LST1XP16LEY1-12', 'H3C', 'LST1XP16LEY1端口-12', '12', '860', 'image', '23', '118', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/12', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('874', 'LST1XP16LEY1-13', 'H3C', 'LST1XP16LEY1端口-13', '13', '860', 'image', '11', '104', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/13', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('875', 'LST1XP16LEY1-14', 'H3C', 'LST1XP16LEY1端口-14', '14', '860', 'image', '23', '104', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/14', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('876', 'LST1XP16LEY1-15', 'H3C', 'LST1XP16LEY1端口-15', '15', '860', 'image', '11', '90', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/15', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('877', 'LST1XP16LEY1-16', 'H3C', 'LST1XP16LEY1端口-16', '16', '860', 'image', '23', '90', '10', '13', 'red', '1', 'LST1XP16LEY1_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/16', '2013-05-29 11:31:52', '4', '2013-05-29 11:31:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('878', '10GBASE-R-SFP+-1', 'H3C', '10GBASE-R-SFP+端口-1', '1', '861', 'image', '11', '232', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/1', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('879', '10GBASE-R-SFP+-2', 'H3C', '10GBASE-R-SFP+端口-2', '2', '861', 'image', '23', '232', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/2', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('880', '10GBASE-R-SFP+-3', 'H3C', '10GBASE-R-SFP+端口-3', '3', '861', 'image', '11', '218', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/3', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('881', '10GBASE-R-SFP+-4', 'H3C', '10GBASE-R-SFP+端口-4', '4', '861', 'image', '23', '218', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/4', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('882', '10GBASE-R-SFP+-5', 'H3C', '10GBASE-R-SFP+端口-5', '5', '861', 'image', '11', '204', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/5', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('883', '10GBASE-R-SFP+-6', 'H3C', '10GBASE-R-SFP+端口-6', '6', '861', 'image', '23', '204', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/6', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('884', '10GBASE-R-SFP+-7', 'H3C', '10GBASE-R-SFP+端口-7', '7', '861', 'image', '11', '190', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/7', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('885', '10GBASE-R-SFP+-8', 'H3C', '10GBASE-R-SFP+端口-8', '8', '861', 'image', '23', '190', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/8', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('886', '10GBASE-R-SFP+-9', 'H3C', '10GBASE-R-SFP+端口-9', '9', '861', 'image', '11', '132', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/9', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('887', '10GBASE-R-SFP+-10', 'H3C', '10GBASE-R-SFP+端口-10', '10', '861', 'image', '23', '132', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/10', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('888', '10GBASE-R-SFP+-11', 'H3C', '10GBASE-R-SFP+端口-11', '11', '861', 'image', '11', '118', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/11', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('889', '10GBASE-R-SFP+-12', 'H3C', '10GBASE-R-SFP+端口-12', '12', '861', 'image', '23', '118', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/12', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('890', '10GBASE-R-SFP+-13', 'H3C', '10GBASE-R-SFP+端口-13', '13', '861', 'image', '11', '104', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/13', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('891', '10GBASE-R-SFP+-14', 'H3C', '10GBASE-R-SFP+端口-14', '14', '861', 'image', '23', '104', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/14', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('892', '10GBASE-R-SFP+-15', 'H3C', '10GBASE-R-SFP+端口-15', '15', '861', 'image', '11', '90', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/15', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('893', '10GBASE-R-SFP+-16', 'H3C', '10GBASE-R-SFP+端口-16', '16', '861', 'image', '23', '90', '10', '13', 'red', '1', '10GBASE-R-SFP+_TEN-GEI.png', 'Ten-GigabitEthernet[X]/0/16', '2013-05-29 11:34:59', '4', '2013-05-29 11:34:59', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('894', 'LST1GP48LEY1', 'H3C', 'LST1GP48LEY1板卡', '1', '0', 'image', '10', '10', '41', '427', 'red', '1', 'LST1GP48LEY1.png', 'LST1GP48LEY1', '2013-05-29 14:02:00', '4', '2013-05-29 14:02:00', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('895', '1000BASE-X-SFP', 'H3C', '1000BASE-X-SFP板卡', '1', '0', 'image', '10', '10', '41', '427', 'red', '1', '1000BASE-X-SFP.png', '1000BASE-X-SFP', '2013-05-29 14:02:32', '4', '2013-05-29 14:02:32', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('896', 'LST1GP48LEY1-1', 'H3C', 'LST1GP48LEY1端口-1', '1', '894', 'image', '9', '385', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('897', 'LST1GP48LEY1-2', 'H3C', 'LST1GP48LEY1端口-2', '2', '894', 'image', '20', '385', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('898', 'LST1GP48LEY1-3', 'H3C', 'LST1GP48LEY1端口-3', '3', '894', 'image', '9', '371', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('899', 'LST1GP48LEY1-4', 'H3C', 'LST1GP48LEY1端口-4', '4', '894', 'image', '20', '371', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('900', 'LST1GP48LEY1-5', 'H3C', 'LST1GP48LEY1端口-5', '5', '894', 'image', '9', '357', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('901', 'LST1GP48LEY1-6', 'H3C', 'LST1GP48LEY1端口-6', '6', '894', 'image', '20', '357', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('902', 'LST1GP48LEY1-7', 'H3C', 'LST1GP48LEY1端口-7', '7', '894', 'image', '9', '343', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('903', 'LST1GP48LEY1-8', 'H3C', 'LST1GP48LEY1端口-8', '8', '894', 'image', '20', '343', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('904', 'LST1GP48LEY1-9', 'H3C', 'LST1GP48LEY1端口-9', '9', '894', 'image', '9', '329', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('905', 'LST1GP48LEY1-10', 'H3C', 'LST1GP48LEY1端口-10', '10', '894', 'image', '20', '329', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('906', 'LST1GP48LEY1-11', 'H3C', 'LST1GP48LEY1端口-11', '11', '894', 'image', '9', '315', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('907', 'LST1GP48LEY1-12', 'H3C', 'LST1GP48LEY1端口-12', '12', '894', 'image', '20', '315', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('908', 'LST1GP48LEY1-13', 'H3C', 'LST1GP48LEY1端口-13', '13', '894', 'image', '9', '289', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('909', 'LST1GP48LEY1-14', 'H3C', 'LST1GP48LEY1端口-14', '14', '894', 'image', '20', '289', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('910', 'LST1GP48LEY1-15', 'H3C', 'LST1GP48LEY1端口-15', '15', '894', 'image', '9', '275', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('911', 'LST1GP48LEY1-16', 'H3C', 'LST1GP48LEY1端口-16', '16', '894', 'image', '20', '275', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('912', 'LST1GP48LEY1-17', 'H3C', 'LST1GP48LEY1端口-17', '17', '894', 'image', '9', '261', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('913', 'LST1GP48LEY1-18', 'H3C', 'LST1GP48LEY1端口-18', '18', '894', 'image', '20', '261', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('914', 'LST1GP48LEY1-19', 'H3C', 'LST1GP48LEY1端口-19', '19', '894', 'image', '9', '247', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('915', 'LST1GP48LEY1-20', 'H3C', 'LST1GP48LEY1端口-20', '20', '894', 'image', '20', '247', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('916', 'LST1GP48LEY1-21', 'H3C', 'LST1GP48LEY1端口-21', '21', '894', 'image', '9', '233', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('917', 'LST1GP48LEY1-22', 'H3C', 'LST1GP48LEY1端口-22', '22', '894', 'image', '20', '233', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('918', 'LST1GP48LEY1-23', 'H3C', 'LST1GP48LEY1端口-23', '23', '894', 'image', '9', '219', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('919', 'LST1GP48LEY1-24', 'H3C', 'LST1GP48LEY1端口-24', '24', '894', 'image', '20', '219', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('920', 'LST1GP48LEY1-25', 'H3C', 'LST1GP48LEY1端口-25', '25', '894', 'image', '9', '193', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('921', 'LST1GP48LEY1-26', 'H3C', 'LST1GP48LEY1端口-26', '26', '894', 'image', '20', '193', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('922', 'LST1GP48LEY1-27', 'H3C', 'LST1GP48LEY1端口-27', '27', '894', 'image', '9', '179', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('923', 'LST1GP48LEY1-28', 'H3C', 'LST1GP48LEY1端口-28', '28', '894', 'image', '20', '179', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('924', 'LST1GP48LEY1-29', 'H3C', 'LST1GP48LEY1端口-29', '29', '894', 'image', '9', '165', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('925', 'LST1GP48LEY1-30', 'H3C', 'LST1GP48LEY1端口-30', '30', '894', 'image', '20', '165', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('926', 'LST1GP48LEY1-31', 'H3C', 'LST1GP48LEY1端口-31', '31', '894', 'image', '9', '151', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('927', 'LST1GP48LEY1-32', 'H3C', 'LST1GP48LEY1端口-32', '32', '894', 'image', '20', '151', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('928', 'LST1GP48LEY1-33', 'H3C', 'LST1GP48LEY1端口-33', '33', '894', 'image', '9', '137', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('929', 'LST1GP48LEY1-34', 'H3C', 'LST1GP48LEY1端口-34', '34', '894', 'image', '20', '137', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('930', 'LST1GP48LEY1-35', 'H3C', 'LST1GP48LEY1端口-35', '35', '894', 'image', '9', '123', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('931', 'LST1GP48LEY1-36', 'H3C', 'LST1GP48LEY1端口-36', '36', '894', 'image', '20', '123', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('932', 'LST1GP48LEY1-37', 'H3C', 'LST1GP48LEY1端口-37', '37', '894', 'image', '9', '97', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('933', 'LST1GP48LEY1-38', 'H3C', 'LST1GP48LEY1端口-38', '38', '894', 'image', '20', '97', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('934', 'LST1GP48LEY1-39', 'H3C', 'LST1GP48LEY1端口-39', '39', '894', 'image', '9', '83', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('935', 'LST1GP48LEY1-40', 'H3C', 'LST1GP48LEY1端口-40', '40', '894', 'image', '20', '83', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('936', 'LST1GP48LEY1-41', 'H3C', 'LST1GP48LEY1端口-41', '41', '894', 'image', '9', '69', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('937', 'LST1GP48LEY1-42', 'H3C', 'LST1GP48LEY1端口-42', '42', '894', 'image', '20', '69', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('938', 'LST1GP48LEY1-43', 'H3C', 'LST1GP48LEY1端口-43', '43', '894', 'image', '9', '55', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('939', 'LST1GP48LEY1-44', 'H3C', 'LST1GP48LEY1端口-44', '44', '894', 'image', '20', '55', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('940', 'LST1GP48LEY1-45', 'H3C', 'LST1GP48LEY1端口-45', '45', '894', 'image', '9', '41', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('941', 'LST1GP48LEY1-46', 'H3C', 'LST1GP48LEY1端口-46', '46', '894', 'image', '20', '41', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('942', 'LST1GP48LEY1-47', 'H3C', 'LST1GP48LEY1端口-47', '47', '894', 'image', '9', '27', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('943', 'LST1GP48LEY1-48', 'H3C', 'LST1GP48LEY1端口-48', '48', '894', 'image', '20', '27', '10', '13', 'red', '1', 'LST1GP48LEY1-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:05:52', '4', '2013-05-29 14:05:52', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('944', '1000BASE-X-SFP-1', 'H3C', '1000BASE-X-SFP端口-1', '1', '895', 'image', '9', '385', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('945', '1000BASE-X-SFP-2', 'H3C', '1000BASE-X-SFP端口-2', '2', '895', 'image', '20', '385', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('946', '1000BASE-X-SFP-3', 'H3C', '1000BASE-X-SFP端口-3', '3', '895', 'image', '9', '371', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('947', '1000BASE-X-SFP-4', 'H3C', '1000BASE-X-SFP端口-4', '4', '895', 'image', '20', '371', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('948', '1000BASE-X-SFP-5', 'H3C', '1000BASE-X-SFP端口-5', '5', '895', 'image', '9', '357', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('949', '1000BASE-X-SFP-6', 'H3C', '1000BASE-X-SFP端口-6', '6', '895', 'image', '20', '357', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('950', '1000BASE-X-SFP-7', 'H3C', '1000BASE-X-SFP端口-7', '7', '895', 'image', '9', '343', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('951', '1000BASE-X-SFP-8', 'H3C', '1000BASE-X-SFP端口-8', '8', '895', 'image', '20', '343', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('952', '1000BASE-X-SFP-9', 'H3C', '1000BASE-X-SFP端口-9', '9', '895', 'image', '9', '329', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('953', '1000BASE-X-SFP-10', 'H3C', '1000BASE-X-SFP端口-10', '10', '895', 'image', '20', '329', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('954', '1000BASE-X-SFP-11', 'H3C', '1000BASE-X-SFP端口-11', '11', '895', 'image', '9', '315', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('955', '1000BASE-X-SFP-12', 'H3C', '1000BASE-X-SFP端口-12', '12', '895', 'image', '20', '315', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('956', '1000BASE-X-SFP-13', 'H3C', '1000BASE-X-SFP端口-13', '13', '895', 'image', '9', '289', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('957', '1000BASE-X-SFP-14', 'H3C', '1000BASE-X-SFP端口-14', '14', '895', 'image', '20', '289', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('958', '1000BASE-X-SFP-15', 'H3C', '1000BASE-X-SFP端口-15', '15', '895', 'image', '9', '275', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('959', '1000BASE-X-SFP-16', 'H3C', '1000BASE-X-SFP端口-16', '16', '895', 'image', '20', '275', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('960', '1000BASE-X-SFP-17', 'H3C', '1000BASE-X-SFP端口-17', '17', '895', 'image', '9', '261', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('961', '1000BASE-X-SFP-18', 'H3C', '1000BASE-X-SFP端口-18', '18', '895', 'image', '20', '261', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('962', '1000BASE-X-SFP-19', 'H3C', '1000BASE-X-SFP端口-19', '19', '895', 'image', '9', '247', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('963', '1000BASE-X-SFP-20', 'H3C', '1000BASE-X-SFP端口-20', '20', '895', 'image', '20', '247', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('964', '1000BASE-X-SFP-21', 'H3C', '1000BASE-X-SFP端口-21', '21', '895', 'image', '9', '233', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('965', '1000BASE-X-SFP-22', 'H3C', '1000BASE-X-SFP端口-22', '22', '895', 'image', '20', '233', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('966', '1000BASE-X-SFP-23', 'H3C', '1000BASE-X-SFP端口-23', '23', '895', 'image', '9', '219', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('967', '1000BASE-X-SFP-24', 'H3C', '1000BASE-X-SFP端口-24', '24', '895', 'image', '20', '219', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('968', '1000BASE-X-SFP-25', 'H3C', '1000BASE-X-SFP端口-25', '25', '895', 'image', '9', '193', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('969', '1000BASE-X-SFP-26', 'H3C', '1000BASE-X-SFP端口-26', '26', '895', 'image', '20', '193', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('970', '1000BASE-X-SFP-27', 'H3C', '1000BASE-X-SFP端口-27', '27', '895', 'image', '9', '179', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('971', '1000BASE-X-SFP-28', 'H3C', '1000BASE-X-SFP端口-28', '28', '895', 'image', '20', '179', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('972', '1000BASE-X-SFP-29', 'H3C', '1000BASE-X-SFP端口-29', '29', '895', 'image', '9', '165', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('973', '1000BASE-X-SFP-30', 'H3C', '1000BASE-X-SFP端口-30', '30', '895', 'image', '20', '165', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('974', '1000BASE-X-SFP-31', 'H3C', '1000BASE-X-SFP端口-31', '31', '895', 'image', '9', '151', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('975', '1000BASE-X-SFP-32', 'H3C', '1000BASE-X-SFP端口-32', '32', '895', 'image', '20', '151', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('976', '1000BASE-X-SFP-33', 'H3C', '1000BASE-X-SFP端口-33', '33', '895', 'image', '9', '137', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('977', '1000BASE-X-SFP-34', 'H3C', '1000BASE-X-SFP端口-34', '34', '895', 'image', '20', '137', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('978', '1000BASE-X-SFP-35', 'H3C', '1000BASE-X-SFP端口-35', '35', '895', 'image', '9', '123', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('979', '1000BASE-X-SFP-36', 'H3C', '1000BASE-X-SFP端口-36', '36', '895', 'image', '20', '123', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('980', '1000BASE-X-SFP-37', 'H3C', '1000BASE-X-SFP端口-37', '37', '895', 'image', '9', '97', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('981', '1000BASE-X-SFP-38', 'H3C', '1000BASE-X-SFP端口-38', '38', '895', 'image', '20', '97', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('982', '1000BASE-X-SFP-39', 'H3C', '1000BASE-X-SFP端口-39', '39', '895', 'image', '9', '83', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('983', '1000BASE-X-SFP-40', 'H3C', '1000BASE-X-SFP端口-40', '40', '895', 'image', '20', '83', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('984', '1000BASE-X-SFP-41', 'H3C', '1000BASE-X-SFP端口-41', '41', '895', 'image', '9', '69', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('985', '1000BASE-X-SFP-42', 'H3C', '1000BASE-X-SFP端口-42', '42', '895', 'image', '20', '69', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('986', '1000BASE-X-SFP-43', 'H3C', '1000BASE-X-SFP端口-43', '43', '895', 'image', '9', '55', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('987', '1000BASE-X-SFP-44', 'H3C', '1000BASE-X-SFP端口-44', '44', '895', 'image', '20', '55', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('988', '1000BASE-X-SFP-45', 'H3C', '1000BASE-X-SFP端口-45', '45', '895', 'image', '9', '41', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('989', '1000BASE-X-SFP-46', 'H3C', '1000BASE-X-SFP端口-46', '46', '895', 'image', '20', '41', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('990', '1000BASE-X-SFP-47', 'H3C', '1000BASE-X-SFP端口-47', '47', '895', 'image', '9', '27', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('991', '1000BASE-X-SFP-48', 'H3C', '1000BASE-X-SFP端口-48', '48', '895', 'image', '20', '27', '10', '13', 'red', '1', '1000BASE-X-SFP-GEI.png', 'GigabitEthernet[X]/0/[Y]', '2013-05-29 14:08:06', '4', '2013-05-29 14:08:06', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('1358', 'LEOMX4UXC', 'HUAWEI', 'LEOMX4UXC板卡（4口）', '1', '0', 'image', '35', '35', '373', '41', 'red', '1', 'LEOMX4UXC.png', 'LEOMX4UXC', '2013-08-16 11:28:24', '4', '2013-08-16 11:28:24', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1359', 'LEOMX4UXC-0', 'HUAWEI', 'LEOMX4UXC端口-0', '0', '1358', 'image', '90', '21', '12', '8', 'red', '1', 'LEOMX4UXC_XGE.png', 'GigabitEthernet[X]/0/[Y]', '2013-08-16 11:31:45', '4', '2013-08-16 11:31:45', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1360', 'LEOMX4UXC-1', 'HUAWEI', 'LEOMX4UXC端口-1', '1', '1358', 'image', '149', '20', '12', '8', 'red', '1', 'LEOMX4UXC_XGE.png', 'GigabitEthernet[X]/0/[Y]', '2013-08-16 11:31:45', '4', '2013-08-16 11:31:45', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1361', 'LEOMX4UXC-2', 'HUAWEI', 'LEOMX4UXC端口-2', '2', '1358', 'image', '208', '20', '12', '8', 'red', '1', 'LEOMX4UXC_XGE.png', 'GigabitEthernet[X]/0/[Y]', '2013-08-16 11:31:45', '4', '2013-08-16 11:31:45', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1362', 'LEOMX4UXC-3', 'HUAWEI', 'LEOMX4UXC端口-3', '3', '1358', 'image', '268', '21', '12', '8', 'red', '1', 'LEOMX4UXC_XGE.png', 'GigabitEthernet[X]/0/[Y]', '2013-08-16 11:31:45', '4', '2013-08-16 11:31:45', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1363', 'RS-XGTN4-4POS192-8XGE', 'ZTE', 'RS-XGTN4-4POS192-8XGE板卡', '1', '0', 'image', '35', '35', '359', '40', 'red', '1', 'RS-XGTN4-4POS192-8XGE.png', 'RS-XGTN4-4POS192-8XGE', '2013-08-16 13:17:58', '4', '2013-08-16 13:17:58', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1364', 'RS-XGTN4-4POS192-8XGE-1', 'ZTE', 'RS-XGTN4-4POS192-8XGE端口-1', '1', '1363', 'image', '153', '16', '10', '9', 'red', '1', 'RS-XGTN4-4POS192-8XGE_XGE.png', 'xgei_[X]/[Y]', '2013-08-16 13:23:09', '4', '2013-08-16 13:23:09', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1365', 'RS-XGTN4-4POS192-8XGE-2', 'ZTE', 'RS-XGTN4-4POS192-8XGE端口-2', '2', '1363', 'image', '166', '16', '10', '9', 'red', '1', 'RS-XGTN4-4POS192-8XGE_XGE.png', 'xgei_[X]/[Y]', '2013-08-16 13:23:09', '4', '2013-08-16 13:23:09', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1366', 'RS-XGTN4-4POS192-8XGE-3', 'ZTE', 'RS-XGTN4-4POS192-8XGE端口-3', '3', '1363', 'image', '179', '16', '10', '9', 'red', '1', 'RS-XGTN4-4POS192-8XGE_XGE.png', 'xgei_[X]/[Y]', '2013-08-16 13:23:09', '4', '2013-08-16 13:23:09', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1367', 'RS-XGTN4-4POS192-8XGE-4', 'ZTE', 'RS-XGTN4-4POS192-8XGE端口-4', '4', '1363', 'image', '192', '16', '10', '9', 'red', '1', 'RS-XGTN4-4POS192-8XGE_XGE.png', 'xgei_[X]/[Y]', '2013-08-16 13:23:09', '4', '2013-08-16 13:23:09', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1368', 'RS-XGTN4-4POS192-8XGE-5', 'ZTE', 'RS-XGTN4-4POS192-8XGE端口-5', '5', '1363', 'image', '25', '12', '14', '10', 'red', '1', 'RS-XGTN4-4POS192-8XGE_XGE.png', 'xgei_[X]/[Y]', '2013-08-16 13:23:09', '4', '2013-08-16 13:23:09', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1369', 'RS-XGTN4-4POS192-8XGE-6', 'ZTE', 'RS-XGTN4-4POS192-8XGE端口-6', '6', '1363', 'image', '50', '12', '14', '10', 'red', '1', 'RS-XGTN4-4POS192-8XGE_XGE.png', 'xgei_[X]/[Y]', '2013-08-16 13:23:09', '4', '2013-08-16 13:23:09', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1370', 'RS-XGTN4-4POS192-8XGE-7', 'ZTE', 'RS-XGTN4-4POS192-8XGE端口-7', '7', '1363', 'image', '246', '12', '14', '10', 'red', '1', 'RS-XGTN4-4POS192-8XGE_XGE.png', 'xgei_[X]/[Y]', '2013-08-16 13:23:09', '4', '2013-08-16 13:23:09', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1371', 'RS-XGTN4-4POS192-8XGE-8', 'ZTE', 'RS-XGTN4-4POS192-8XGE端口-8', '8', '1363', 'image', '270', '12', '14', '10', 'red', '1', 'RS-XGTN4-4POS192-8XGE_XGE.png', 'xgei_[X]/[Y]', '2013-08-16 13:23:09', '4', '2013-08-16 13:23:09', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1372', 'RS-XGTN4-4POS192-8XGE-9', 'ZTE', 'RS-XGTN4-4POS192-8XGE端口-9', '9', '1363', 'image', '74', '12', '14', '10', 'red', '1', 'RS-XGTN4-4POS192-8XGE_POS192.png', 'pos192_[X]/[Y]', '2013-08-16 13:25:34', '4', '2013-08-16 13:25:34', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1373', 'RS-XGTN4-4POS192-8XGE-10', 'ZTE', 'RS-XGTN4-4POS192-8XGE端口-10', '10', '1363', 'image', '99', '12', '14', '10', 'red', '1', 'RS-XGTN4-4POS192-8XGE_POS192.png', 'pos192_[X]/[Y]', '2013-08-16 13:25:34', '4', '2013-08-16 13:25:34', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1374', 'RS-XGTN4-4POS192-8XGE-11', 'ZTE', 'RS-XGTN4-4POS192-8XGE端口-11', '11', '1363', 'image', '294', '12', '14', '10', 'red', '1', 'RS-XGTN4-4POS192-8XGE_POS192.png', 'pos192_[X]/[Y]', '2013-08-16 13:25:34', '4', '2013-08-16 13:25:34', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1375', 'RS-XGTN4-4POS192-8XGE-12', 'ZTE', 'RS-XGTN4-4POS192-8XGE端口-12', '12', '1363', 'image', '319', '12', '14', '10', 'red', '1', 'RS-XGTN4-4POS192-8XGE_POS192.png', 'pos192_[X]/[Y]', '2013-08-16 13:25:34', '4', '2013-08-16 13:25:34', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1376', 'RS-4XGP-10GE', 'ZTE', 'RS-4XGP-10GE板卡', '1', '0', 'image', '35', '35', '359', '40', 'red', '1', 'RS-4XGP-10GE.png', 'RS-4XGP-10GE', '2013-08-16 13:44:40', '4', '2013-08-16 13:44:40', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1377', 'RS-4XGP-10GE-1', 'ZTE', 'RS-4XGP-10GE端口-1', '1', '1376', 'image', '66', '11', '14', '11', 'red', '1', 'RS-4XGP-10GE_XGEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:46:47', '4', '2013-08-16 13:46:47', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1378', 'RS-4XGP-10GE-2', 'ZTE', 'RS-4XGP-10GE端口-2', '2', '1376', 'image', '139', '11', '14', '11', 'red', '1', 'RS-4XGP-10GE_XGEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:46:47', '4', '2013-08-16 13:46:47', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1379', 'RS-4XGP-10GE-3', 'ZTE', 'RS-4XGP-10GE端口-3', '3', '1376', 'image', '208', '11', '14', '11', 'red', '1', 'RS-4XGP-10GE_XGEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:46:47', '4', '2013-08-16 13:46:47', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1380', 'RS-4XGP-10GE-4', 'ZTE', 'RS-4XGP-10GE端口-4', '4', '1376', 'image', '274', '11', '14', '11', 'red', '1', 'RS-4XGP-10GE_XGEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:46:47', '4', '2013-08-16 13:46:47', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1381', 'RS-4XGP-10GE-5', 'ZTE', 'RS-4XGP-10GE端口-5', '5', '1376', 'image', null, null, null, null, 'red', '1', 'RS-4XGP-10GE_XGEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:46:47', '4', '2013-08-16 13:46:47', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1382', 'RS-4XGP-10GE-6', 'ZTE', 'RS-4XGP-10GE端口-6', '6', '1376', 'image', null, null, null, null, 'red', '1', 'RS-4XGP-10GE_XGEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:46:47', '4', '2013-08-16 13:46:47', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1383', 'RS-4XGP-10GE-7', 'ZTE', 'RS-4XGP-10GE端口-7', '7', '1376', 'image', null, null, null, null, 'red', '1', 'RS-4XGP-10GE_XGEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:46:47', '4', '2013-08-16 13:46:47', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1384', 'RS-4XGP-10GE-8', 'ZTE', 'RS-4XGP-10GE端口-8', '8', '1376', 'image', null, null, null, null, 'red', '1', 'RS-4XGP-10GE_XGEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:46:47', '4', '2013-08-16 13:46:47', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1385', 'RS-4POS192-8GE', 'ZTE', 'RS-4POS192-8GE板卡', '1', '0', 'image', '35', '35', '359', '40', 'red', '1', 'RS-4POS192-8GE.png', 'RS-4POS192-8GE', '2013-08-16 13:57:42', '4', '2013-08-16 13:57:42', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1386', 'RS-4POS192-8GE-1', 'ZTE', 'RS-4POS192-8GE端口-1', '1', '1385', 'image', '70', '12', '11', '9', 'red', '1', 'RS-4POS192-8GE_GEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:59:34', '4', '2013-08-16 13:59:34', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1387', 'RS-4POS192-8GE-2', 'ZTE', 'RS-4POS192-8GE端口-2', '2', '1385', 'image', '86', '12', '11', '9', 'red', '1', 'RS-4POS192-8GE_GEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:59:34', '4', '2013-08-16 13:59:34', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1388', 'RS-4POS192-8GE-3', 'ZTE', 'RS-4POS192-8GE端口-3', '3', '1385', 'image', '103', '12', '11', '9', 'red', '1', 'RS-4POS192-8GE_GEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:59:34', '4', '2013-08-16 13:59:34', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1389', 'RS-4POS192-8GE-4', 'ZTE', 'RS-4POS192-8GE端口-4', '4', '1385', 'image', '119', '12', '11', '9', 'red', '1', 'RS-4POS192-8GE_GEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:59:34', '4', '2013-08-16 13:59:34', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1390', 'RS-4POS192-8GE-5', 'ZTE', 'RS-4POS192-8GE端口-5', '5', '1385', 'image', '135', '12', '11', '9', 'red', '1', 'RS-4POS192-8GE_GEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:59:34', '4', '2013-08-16 13:59:34', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1391', 'RS-4POS192-8GE-6', 'ZTE', 'RS-4POS192-8GE端口-6', '6', '1385', 'image', '151', '12', '11', '9', 'red', '1', 'RS-4POS192-8GE_GEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:59:34', '4', '2013-08-16 13:59:34', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1392', 'RS-4POS192-8GE-7', 'ZTE', 'RS-4POS192-8GE端口-7', '7', '1385', 'image', '167', '12', '11', '9', 'red', '1', 'RS-4POS192-8GE_GEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:59:34', '4', '2013-08-16 13:59:34', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1393', 'RS-4POS192-8GE-8', 'ZTE', 'RS-4POS192-8GE端口-8', '8', '1385', 'image', '184', '12', '11', '9', 'red', '1', 'RS-4POS192-8GE_GEI.png', 'xgei_[X]/[Y]', '2013-08-16 13:59:34', '4', '2013-08-16 13:59:34', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1394', 'RS-4POS192-8GE-9', 'ZTE', 'RS-4POS192-8GE端口-9', '9', '1385', 'image', '269', '11', '11', '10', 'red', '1', 'RS-4POS192-8GE_POS192.png', 'pos192_[X]/[Y]', '2013-08-16 14:02:25', '4', '2013-08-16 14:02:25', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1395', 'RS-4POS192-8GE-10', 'ZTE', 'RS-4POS192-8GE端口-10', '10', '1385', 'image', '285', '11', '11', '10', 'red', '1', 'RS-4POS192-8GE_POS192.png', 'pos192_[X]/[Y]', '2013-08-16 14:02:25', '4', '2013-08-16 14:02:25', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1396', 'RS-4POS192-8GE-11', 'ZTE', 'RS-4POS192-8GE端口-11', '11', '1385', 'image', '301', '11', '11', '10', 'red', '1', 'RS-4POS192-8GE_POS192.png', 'pos192_[X]/[Y]', '2013-08-16 14:02:25', '4', '2013-08-16 14:02:25', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1397', 'RS-4POS192-8GE-12', 'ZTE', 'RS-4POS192-8GE端口-12', '12', '1385', 'image', '317', '11', '11', '10', 'red', '1', 'RS-4POS192-8GE_POS192.png', 'pos192_[X]/[Y]', '2013-08-16 14:02:25', '4', '2013-08-16 14:02:25', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1398', 'RS-4POS192-24GE', 'ZTE', 'RS-4POS192-24GE板卡', '1', '0', 'image', '35', '35', '359', '40', 'red', '1', 'RS-4POS192-24GE.png', 'RS-4POS192-24GE', '2013-08-16 14:17:04', '4', '2013-08-16 14:17:04', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1399', 'RS-4POS192-24GE-1', 'ZTE', 'RS-4POS192-24GE端口-1', '1', '1398', 'image', '27', '18', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:11', '4', '2013-08-16 14:18:11', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1400', 'RS-4POS192-24GE-2', 'ZTE', 'RS-4POS192-24GE端口-2', '2', '1398', 'image', '27', '6', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:11', '4', '2013-08-16 14:18:11', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1401', 'RS-4POS192-24GE-3', 'ZTE', 'RS-4POS192-24GE端口-3', '3', '1398', 'image', '45', '18', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:11', '4', '2013-08-16 14:18:11', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1402', 'RS-4POS192-24GE-4', 'ZTE', 'RS-4POS192-24GE端口-4', '4', '1398', 'image', '45', '6', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:11', '4', '2013-08-16 14:18:11', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1403', 'RS-4POS192-24GE-5', 'ZTE', 'RS-4POS192-24GE端口-5', '5', '1398', 'image', '63', '18', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:11', '4', '2013-08-16 14:18:11', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1404', 'RS-4POS192-24GE-6', 'ZTE', 'RS-4POS192-24GE端口-6', '6', '1398', 'image', '63', '6', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1405', 'RS-4POS192-24GE-7', 'ZTE', 'RS-4POS192-24GE端口-7', '7', '1398', 'image', '81', '18', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1406', 'RS-4POS192-24GE-8', 'ZTE', 'RS-4POS192-24GE端口-8', '8', '1398', 'image', '81', '6', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1407', 'RS-4POS192-24GE-9', 'ZTE', 'RS-4POS192-24GE端口-9', '9', '1398', 'image', '99', '18', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1408', 'RS-4POS192-24GE-10', 'ZTE', 'RS-4POS192-24GE端口-10', '10', '1398', 'image', '99', '6', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1409', 'RS-4POS192-24GE-11', 'ZTE', 'RS-4POS192-24GE端口-11', '11', '1398', 'image', '117', '18', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1410', 'RS-4POS192-24GE-12', 'ZTE', 'RS-4POS192-24GE端口-12', '12', '1398', 'image', '117', '6', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1411', 'RS-4POS192-24GE-13', 'ZTE', 'RS-4POS192-24GE端口-13', '13', '1398', 'image', '143', '18', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1412', 'RS-4POS192-24GE-14', 'ZTE', 'RS-4POS192-24GE端口-14', '14', '1398', 'image', '143', '6', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1413', 'RS-4POS192-24GE-15', 'ZTE', 'RS-4POS192-24GE端口-15', '15', '1398', 'image', '161', '18', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1414', 'RS-4POS192-24GE-16', 'ZTE', 'RS-4POS192-24GE端口-16', '16', '1398', 'image', '161', '6', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1415', 'RS-4POS192-24GE-17', 'ZTE', 'RS-4POS192-24GE端口-17', '17', '1398', 'image', '179', '18', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1416', 'RS-4POS192-24GE-18', 'ZTE', 'RS-4POS192-24GE端口-18', '18', '1398', 'image', '179', '6', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1417', 'RS-4POS192-24GE-19', 'ZTE', 'RS-4POS192-24GE端口-19', '19', '1398', 'image', '197', '18', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1418', 'RS-4POS192-24GE-20', 'ZTE', 'RS-4POS192-24GE端口-20', '20', '1398', 'image', '197', '6', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1419', 'RS-4POS192-24GE-21', 'ZTE', 'RS-4POS192-24GE端口-21', '21', '1398', 'image', '215', '18', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1420', 'RS-4POS192-24GE-22', 'ZTE', 'RS-4POS192-24GE端口-22', '22', '1398', 'image', '214', '6', '12', '8', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1421', 'RS-4POS192-24GE-23', 'ZTE', 'RS-4POS192-24GE端口-23', '23', '1398', 'image', '234', '19', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1422', 'RS-4POS192-24GE-24', 'ZTE', 'RS-4POS192-24GE端口-24', '24', '1398', 'image', '234', '6', '12', '9', 'red', '1', 'RS-4POS192-24GE_GEI.png', 'gei_[X]/[Y]', '2013-08-16 14:18:12', '4', '2013-08-16 14:18:12', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1423', 'RS-4POS192-24GE-25', 'ZTE', 'RS-4POS192-24GE端口-25', '25', '1398', 'image', '269', '10', '11', '8', 'red', '1', 'RS-4POS192-24GE_POS192.png', 'pos192_[X]/[Y]', '2013-08-16 14:19:10', '4', '2013-08-16 14:19:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1424', 'RS-4POS192-24GE-26', 'ZTE', 'RS-4POS192-24GE端口-26', '26', '1398', 'image', '284', '10', '11', '8', 'red', '1', 'RS-4POS192-24GE_POS192.png', 'pos192_[X]/[Y]', '2013-08-16 14:19:10', '4', '2013-08-16 14:19:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1425', 'RS-4POS192-24GE-27', 'ZTE', 'RS-4POS192-24GE端口-27', '27', '1398', 'image', '300', '10', '11', '8', 'red', '1', 'RS-4POS192-24GE_POS192.png', 'pos192_[X]/[Y]', '2013-08-16 14:19:10', '4', '2013-08-16 14:19:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1426', 'RS-4POS192-24GE-28', 'ZTE', 'RS-4POS192-24GE端口-28', '28', '1398', 'image', '317', '10', '11', '8', 'red', '1', 'RS-4POS192-24GE_POS192.png', 'pos192_[X]/[Y]', '2013-08-16 14:19:10', '4', '2013-08-16 14:19:10', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1464', 'RS-89S2A-24GE-SFP4RJ', 'ZTE', 'RS-89S2A-24GE-SFP4RJ', '1', '0', 'image', '35', '35', '359', '40', 'red', '1', 'RS-89S2A-24GE-SFP4RJ.png', 'RS-89S2A-24GE-SFP4RJ', '2013-09-06 17:04:50', '4', '2013-09-06 17:04:50', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1465', 'RS-89S2A-24GE-SFP4RJ-1', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-1', '1', '1464', 'image', '25', '18', '10', '7', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1466', 'RS-89S2A-24GE-SFP4RJ-2', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-2', '2', '1464', 'image', '25', '9', '10', '7', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1467', 'RS-89S2A-24GE-SFP4RJ-3', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-3', '3', '1464', 'image', '45', '18', '10', '7', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1468', 'RS-89S2A-24GE-SFP4RJ-4', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-4', '4', '1464', 'image', '45', '8', '10', '7', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1469', 'RS-89S2A-24GE-SFP4RJ-5', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-5', '5', '1464', 'image', '65', '19', '10', '6', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1470', 'RS-89S2A-24GE-SFP4RJ-6', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-6', '6', '1464', 'image', '65', '9', '10', '6', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1471', 'RS-89S2A-24GE-SFP4RJ-7', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-7', '7', '1464', 'image', '85', '19', '10', '6', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1472', 'RS-89S2A-24GE-SFP4RJ-8', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-8', '8', '1464', 'image', '85', '9', '10', '6', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1473', 'RS-89S2A-24GE-SFP4RJ-9', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-9', '9', '1464', 'image', '105', '19', '10', '6', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1474', 'RS-89S2A-24GE-SFP4RJ-10', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-10', '10', '1464', 'image', '105', '8', '11', '7', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1475', 'RS-89S2A-24GE-SFP4RJ-11', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-11', '11', '1464', 'image', '125', '19', '10', '6', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1476', 'RS-89S2A-24GE-SFP4RJ-12', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-12', '12', '1464', 'image', '125', '9', '10', '6', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1477', 'RS-89S2A-24GE-SFP4RJ-13', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-13', '13', '1464', 'image', '145', '19', '11', '6', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1478', 'RS-89S2A-24GE-SFP4RJ-14', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-14', '14', '1464', 'image', '145', '9', '10', '7', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1479', 'RS-89S2A-24GE-SFP4RJ-15', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-15', '15', '1464', 'image', '165', '19', '11', '7', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1480', 'RS-89S2A-24GE-SFP4RJ-16', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-16', '16', '1464', 'image', '164', '8', '11', '7', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1481', 'RS-89S2A-24GE-SFP4RJ-17', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-17', '17', '1464', 'image', '185', '19', '10', '6', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1482', 'RS-89S2A-24GE-SFP4RJ-18', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-18', '18', '1464', 'image', '185', '9', '10', '6', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1483', 'RS-89S2A-24GE-SFP4RJ-19', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-19', '19', '1464', 'image', '205', '19', '10', '6', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1484', 'RS-89S2A-24GE-SFP4RJ-20', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-20', '20', '1464', 'image', '205', '9', '10', '6', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1485', 'RS-89S2A-24GE-SFP4RJ-21', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-21', '21', '1464', 'image', '225', '19', '10', '6', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1486', 'RS-89S2A-24GE-SFP4RJ-22', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-22', '22', '1464', 'image', '225', '8', '10', '7', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1487', 'RS-89S2A-24GE-SFP4RJ-23', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-23', '23', '1464', 'image', '245', '18', '10', '7', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1488', 'RS-89S2A-24GE-SFP4RJ-24', 'ZTE', 'RS-89S2A-24GE-SFP4RJ端口-24', '24', '1464', 'image', '245', '9', '10', '6', 'red', '1', 'RS-89S2A-24GE-SFP4RJ_GEI.png', 'gei_[X]/[Y]', '2013-09-06 17:08:17', '4', '2013-09-06 17:08:17', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1498', 'SR6602', 'H3C', 'H3C SR6602封堵路由器', '1', '0', 'image', '35', '35', '442', '51', 'red', '1', 'SR6602.png', 'SR6602', '2013-09-09 09:22:30', '4', '2013-09-09 09:22:30', '4', null, null, null, null, null, '1', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1499', 'SR6602-0', 'H3C', 'SR6602端口-0', '0', '1498', 'image', '25', '12', '14', '10', 'red', '1', 'SR6602_GE.png', 'GigabitEthernet0/0', '2013-09-09 09:27:13', '4', '2013-09-09 09:27:13', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '2', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1500', 'SR6602-1', 'H3C', 'SR6602端口-1', '1', '1498', 'image', '44', '31', '14', '10', 'red', '1', 'SR6602_GE.png', 'GigabitEthernet0/1', '2013-09-09 09:27:13', '4', '2013-09-09 09:27:13', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '2', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1501', 'SR6602-2', 'H3C', 'SR6602端口-2', '2', '1498', 'image', '73', '12', '15', '10', 'red', '1', 'SR6602_GE.png', 'GigabitEthernet0/2', '2013-09-09 09:27:13', '4', '2013-09-09 09:27:13', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '2', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1502', 'SR6602-3', 'H3C', 'SR6602端口-3', '3', '1498', 'image', '93', '31', '14', '10', 'red', '1', 'SR6602_GE.png', 'GigabitEthernet0/3', '2013-09-09 09:27:13', '4', '2013-09-09 09:27:13', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '2', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1503', 'PF4XPS12XGES', 'DPtech', 'PF4XPS12XGES板卡，16个GE口', '1', '0', 'image', '35', '35', '354', '34', 'red', '1', 'PF4XPS12XGES.png', 'PF4XPS12XGES', '2014-05-27 15:37:38', '1', '2014-05-27 16:48:20', '1', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('1504', 'PF4XPS12XGES-15', 'DPtech', 'PF4XPS12XGES的端口：15', '15', '1503', 'image', '316', '19', '14', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:49:49', '1', '2014-05-27 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1505', 'PF4XPS12XGES-14', 'DPtech', 'PF4XPS12XGES的端口：14', '14', '1503', 'image', '316', '4', '14', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:49:49', '1', '2014-05-27 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1506', 'PF4XPS12XGES-13', 'DPtech', 'PF4XPS12XGES的端口：13', '13', '1503', 'image', '304', '19', '14', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:49:49', '1', '2014-05-27 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1507', 'PF4XPS12XGES-12', 'DPtech', 'PF4XPS12XGES的端口：12', '12', '1503', 'image', '304', '4', '14', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:49:49', '1', '2014-05-27 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1508', 'PF4XPS12XGES-11', 'DPtech', 'PF4XPS12XGES的端口：11', '11', '1503', 'image', '292', '19', '14', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:49:49', '1', '2014-05-27 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1509', 'PF4XPS12XGES-10', 'DPtech', 'PF4XPS12XGES的端口：10', '10', '1503', 'image', '292', '4', '14', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:49:49', '1', '2014-05-27 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1510', 'PF4XPS12XGES-9', 'DPtech', 'PF4XPS12XGES的端口：9', '9', '1503', 'image', '279', '19', '14', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:49:49', '1', '2014-05-27 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1511', 'PF4XPS12XGES-8', 'DPtech', 'PF4XPS12XGES的端口：8', '8', '1503', 'image', '279', '4', '14', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:49:49', '1', '2014-05-27 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1512', 'PF4XPS12XGES-7', 'DPtech', 'PF4XPS12XGES的端口：7', '7', '1503', 'image', '265', '19', '14', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:49:49', '1', '2014-05-27 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1513', 'PF4XPS12XGES-6', 'DPtech', 'PF4XPS12XGES的端口：6', '6', '1503', 'image', '265', '4', '14', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:49:49', '1', '2014-05-27 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1514', 'PF4XPS12XGES-5', 'DPtech', 'PF4XPS12XGES的端口：5', '5', '1503', 'image', '252', '19', '14', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:49:49', '1', '2014-05-27 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1515', 'PF4XPS12XGES-4', 'DPtech', 'PF4XPS12XGES的端口：4', '4', '1503', 'image', '252', '4', '14', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:49:49', '1', '2014-05-27 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1516', 'PF4XPS12XGES-3', 'DPtech', 'PF4XPS12XGES的端口：3', '3', '1503', 'image', '192', '19', '18', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:48:53', '1', '2014-05-27 15:48:53', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1517', 'PF4XPS12XGES-2', 'DPtech', 'PF4XPS12XGES的端口：2', '2', '1503', 'image', '139', '19', '18', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:48:53', '1', '2014-05-27 15:48:53', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1518', 'PF4XPS12XGES-1', 'DPtech', 'PF4XPS12XGES的端口：1', '1', '1503', 'image', '86', '19', '18', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:48:53', '1', '2014-05-27 15:48:53', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1519', 'PF4XPS12XGES-0', 'DPtech', 'PF4XPS12XGES的端口：0', '0', '1503', 'image', '35', '19', '18', '8', 'red', '1', 'PF4XPS12XGES-Eth.png', 'eth[X]_[Y]', '2014-05-27 15:48:53', '1', '2014-05-27 15:48:53', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1522', 'RS-XGTN3-4XGE-8XGESFP+', 'ZTE', 'RS-XGTN3-4XGE-8XGESFP+', '1', '0', 'image', '10', '10', '359', '40', 'red', '1', 'RS-XGTN3-4XGE-8XGESFP+.png', 'RS-XGTN3-4XGE-8XGESFP+', null, null, '2014-11-05 11:06:37', '1', null, null, null, null, null, '2', '0', '0', '1', '0', '1');
INSERT INTO `device_type_info` VALUES ('1523', 'RS-XGTN3-4XGE-8XGESFP+-9', 'ZTE', 'RS-XGTN3-4XGE-8XGESFP+端口-9', '9', '1522', 'image', '213', '9', '14', '9', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/9', '2014-11-05 11:06:37', '1', '2014-11-05 11:06:37', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1524', 'RS-XGTN3-4XGE-8XGESFP+-10', 'ZTE', 'RS-XGTN3-4XGE-8XGESFP+端口-10', '10', '1522', 'image', '246', '9', '14', '9', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/10', '2014-11-05 11:06:37', '1', '2014-11-05 11:06:37', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1525', 'RS-XGTN3-4XGE-8XGESFP+-12', 'ZTE', 'RS-XGTN3-4XGE-8XGESFP+端口-12', '12', '1522', 'image', '310', '9', '14', '9', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/12', '2014-11-05 11:06:37', '1', '2014-11-05 11:06:37', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1526', 'RS-XGTN3-4XGE-8XGESFP+-2', 'ZTE', 'RS-XGTN3-4XGE-8XGESFP+端口-2', '2', '1522', 'image', '139', '7', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/2', '2014-11-05 11:06:37', '1', '2014-11-05 11:06:37', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1527', 'RS-XGTN3-4XGE-8XGESFP+-3', 'ZTE', 'RS-XGTN3-4XGE-8XGESFP+端口-3', '3', '1522', 'image', '152', '18', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/3', '2014-11-05 11:06:37', '1', '2014-11-05 11:06:37', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1528', 'RS-XGTN3-4XGE-8XGESFP+-4', 'ZTE', 'RS-XGTN3-4XGE-8XGESFP+端口-4', '4', '1522', 'image', '152', '7', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/4', '2014-11-05 11:06:37', '1', '2014-11-05 11:06:37', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1529', 'RS-XGTN3-4XGE-8XGESFP+-5', 'ZTE', 'RS-XGTN3-4XGE-8XGESFP+端口-5', '5', '1522', 'image', '165', '18', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/5', '2014-11-05 11:06:37', '1', '2014-11-05 11:06:37', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1530', 'RS-XGTN3-4XGE-8XGESFP+-6', 'ZTE', 'RS-XGTN3-4XGE-8XGESFP+端口-6', '6', '1522', 'image', '165', '7', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/6', '2014-11-05 11:06:37', '1', '2014-11-05 11:06:37', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1531', 'RS-XGTN3-4XGE-8XGESFP+-11', 'ZTE', 'RS-XGTN3-4XGE-8XGESFP+端口-11', '11', '1522', 'image', '279', '9', '14', '9', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/11', '2014-11-05 11:06:37', '1', '2014-11-05 11:06:37', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1532', 'RS-XGTN3-4XGE-8XGESFP+-7', 'ZTE', 'RS-XGTN3-4XGE-8XGESFP+端口-7', '7', '1522', 'image', '177', '18', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/7', '2014-11-05 11:06:37', '1', '2014-11-05 11:06:37', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1533', 'RS-XGTN3-4XGE-8XGESFP+-1', 'ZTE', 'RS-XGTN3-4XGE-8XGESFP+端口-1', '1', '1522', 'image', '139', '18', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/1', '2014-11-05 11:06:37', '1', '2014-11-05 11:06:37', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1534', 'RS-XGTN3-4XGE-8XGESFP+-8', 'ZTE', 'RS-XGTN3-4XGE-8XGESFP+端口-8', '8', '1522', 'image', '177', '7', '11', '7', 'red', '1', 'RS-XGTN3-4P192-8XGESFP+_XGEI.png', 'xgei_[X]/8', '2014-11-05 11:06:37', '1', '2014-11-05 11:06:37', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1542', 'PF4XPS12XGES-4P12E', 'DPtech', '迪普可配板卡，4个POS口，12个GE口', '1', '0', 'image', '35', '35', '354', '34', 'red', '1', 'PF4XPS12XGES-4P12E.png', ' PF4XPS12XGES-4P12E', '2015-02-12 15:37:38', '1', '2015-02-12 16:48:20', '1', null, null, null, null, null, '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1543', 'PF4XPS12XGES-4P12E-0', 'DPtech', 'PF4XPS12XGES-4P12E的端口：0', '0', '1542', 'image', '35', '19', '18', '8', 'red', '1', 'PF4XPS12XGES-4P12E-POS.png', 'pos[X]_[Y]', '2015-02-12 15:48:53', '1', '2015-02-12 15:48:53', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1544', 'PF4XPS12XGES-4P12E-1', 'DPtech', 'PF4XPS12XGES-4P12E的端口：1', '1', '1542', 'image', '86', '19', '18', '8', 'red', '1', 'PF4XPS12XGES-4P12E-POS.png', 'pos[X]_[Y]', '2015-02-12 15:48:53', '1', '2015-02-12 15:48:53', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1545', 'PF4XPS12XGES-4P12E-10', 'DPtech', 'PF4XPS12XGES-4P12E的端口：10', '10', '1542', 'image', '292', '4', '14', '8', 'red', '1', 'PF4XPS12XGES-4P12E-Eth.png', 'eth[X]_[Y]', '2015-02-12 15:49:49', '1', '2015-02-12 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1546', 'PF4XPS12XGES-4P12E-11', 'DPtech', 'PF4XPS12XGES-4P12E的端口：11', '11', '1542', 'image', '292', '19', '14', '8', 'red', '1', 'PF4XPS12XGES-4P12E-Eth.png', 'eth[X]_[Y]', '2015-02-12 15:49:49', '1', '2015-02-12 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1547', 'PF4XPS12XGES-4P12E-12', 'DPtech', 'PF4XPS12XGES-4P12E的端口：12', '12', '1542', 'image', '304', '4', '14', '8', 'red', '1', 'PF4XPS12XGES-4P12E-Eth.png', 'eth[X]_[Y]', '2015-02-12 15:49:49', '1', '2015-02-12 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1548', 'PF4XPS12XGES-4P12E-13', 'DPtech', 'PF4XPS12XGES-4P12E的端口：13', '13', '1542', 'image', '304', '19', '14', '8', 'red', '1', 'PF4XPS12XGES-4P12E-Eth.png', 'eth[X]_[Y]', '2015-02-12 15:49:49', '1', '2015-02-12 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1549', 'PF4XPS12XGES-4P12E-14', 'DPtech', 'PF4XPS12XGES-4P12E的端口：14', '14', '1542', 'image', '316', '4', '14', '8', 'red', '1', 'PF4XPS12XGES-4P12E-Eth.png', 'eth[X]_[Y]', '2015-02-12 15:49:49', '1', '2015-02-12 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1550', 'PF4XPS12XGES-4P12E-15', 'DPtech', 'PF4XPS12XGES-4P12E的端口：15', '15', '1542', 'image', '316', '19', '14', '8', 'red', '1', 'PF4XPS12XGES-4P12E-Eth.png', 'eth[X]_[Y]', '2015-02-12 15:49:49', '1', '2015-02-12 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1551', 'PF4XPS12XGES-4P12E-2', 'DPtech', 'PF4XPS12XGES-4P12E的端口：2', '2', '1542', 'image', '139', '19', '18', '8', 'red', '1', 'PF4XPS12XGES-4P12E-POS.png', 'pos[X]_[Y]', '2015-02-12 15:48:53', '1', '2015-02-12 15:48:53', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1552', 'PF4XPS12XGES-4P12E-3', 'DPtech', 'PF4XPS12XGES-4P12E的端口：3', '3', '1542', 'image', '192', '19', '18', '8', 'red', '1', 'PF4XPS12XGES-4P12E-POS.png', 'pos[X]_[Y]', '2015-02-12 15:48:53', '1', '2015-02-12 15:48:53', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1553', 'PF4XPS12XGES-4P12E-4', 'DPtech', 'PF4XPS12XGES-4P12E的端口：4', '4', '1542', 'image', '252', '4', '14', '8', 'red', '1', 'PF4XPS12XGES-4P12E-Eth.png', 'eth[X]_[Y]', '2015-02-12 15:49:49', '1', '2015-02-12 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1554', 'PF4XPS12XGES-4P12E-5', 'DPtech', 'PF4XPS12XGES-4P12E的端口：5', '5', '1542', 'image', '252', '19', '14', '8', 'red', '1', 'PF4XPS12XGES-4P12E-Eth.png', 'eth[X]_[Y]', '2015-02-12 15:49:49', '1', '2015-02-12 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1555', 'PF4XPS12XGES-4P12E-6', 'DPtech', 'PF4XPS12XGES-4P12E的端口：6', '6', '1542', 'image', '265', '4', '14', '8', 'red', '1', 'PF4XPS12XGES-4P12E-Eth.png', 'eth[X]_[Y]', '2015-02-12 15:49:49', '1', '2015-02-12 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1556', 'PF4XPS12XGES-4P12E-7', 'DPtech', 'PF4XPS12XGES-4P12E的端口：7', '7', '1542', 'image', '265', '19', '14', '8', 'red', '1', 'PF4XPS12XGES-4P12E-Eth.png', 'eth[X]_[Y]', '2015-02-12 15:49:49', '1', '2015-02-12 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1557', 'PF4XPS12XGES-4P12E-8', 'DPtech', 'PF4XPS12XGES-4P12E的端口：8', '8', '1542', 'image', '279', '4', '14', '8', 'red', '1', 'PF4XPS12XGES-4P12E-Eth.png', 'eth[X]_[Y]', '2015-02-12 15:49:49', '1', '2015-02-12 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1558', 'PF4XPS12XGES-4P12E-9', 'DPtech', 'PF4XPS12XGES-4P12E的端口：9', '9', '1542', 'image', '279', '19', '14', '8', 'red', '1', 'PF4XPS12XGES-4P12E-Eth.png', 'eth[X]_[Y]', '2015-02-12 15:49:49', '1', '2015-02-12 15:49:49', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1562', 'DPX19000-A18', 'DPtech', 'DPtech DPX19000-A18 分流设备', '1', '0', 'image', '35', '0', '350', '755', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 10:24:46', '201', 'DI_SYSTEM', null, null, null, null, '1', '0', '0', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1563', 'DPX19000-A18-EightNine-2', 'DPtech', 'DPX19000-A18主板槽位89-2', '19', '1562', 'image', '164', '394', '141', '43', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1564', 'DPX19000-A18-One', 'DPtech', 'DPX19000-A18默认槽位1', '1', '1562', 'image', '20', '122', '287', '34', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 09:23:51', '81', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1565', 'DPX19000-A18-Two', 'DPtech', 'DPX19000-A18默认槽位2', '2', '1562', 'image', '19', '156', '286', '33', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 17:37:17', '201', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1566', 'DPX19000-A18-Three', 'DPtech', 'DPX19000-A18默认槽位3', '3', '1562', 'image', '19', '191', '286', '33', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 17:37:17', '201', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1567', 'DPX19000-A18-Four', 'DPtech', 'DPX19000-A18默认槽位4', '4', '1562', 'image', '20', '224', '285', '34', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 16:41:11', '201', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1568', 'DPX19000-A18-Five', 'DPtech', 'DPX19000-A18默认槽位5', '5', '1562', 'image', '20', '259', '285', '34', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 16:41:11', '201', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1569', 'DPX19000-A18-Six', 'DPtech', 'DPX19000-A18默认槽位6', '6', '1562', 'image', '19', '294', '287', '32', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 16:41:11', '201', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1570', 'DPX19000-A18-Seven', 'DPtech', 'DPX19000-A18默认槽位7', '7', '1562', 'image', '20', '328', '286', '32', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1571', 'DPX19000-A18-Eight', 'DPtech', 'DPX19000-A18默认槽位8', '8', '1562', 'image', '19', '360', '287', '34', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1572', 'DPX19000-A18-Nine', 'DPtech', 'DPX19000-A18默认槽位9', '10', '1562', 'image', '20', '437', '285', '33', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1573', 'DPX19000-A18-Ten', 'DPtech', 'DPX19000-A18默认槽位10', '11', '1562', 'image', '20', '471', '286', '33', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1574', 'DPX19000-A18-Eleven', 'DPtech', 'DPX19000-A18默认槽位11', '12', '1562', 'image', '19', '505', '287', '33', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1575', 'DPX19000-A18-Twelve', 'DPtech', 'DPX19000-A18默认槽位12', '13', '1562', 'image', '19', '538', '286', '33', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1576', 'DPX19000-A18-Thirteen', 'DPtech', 'DPX19000-A18默认槽位13', '14', '1562', 'image', '19', '573', '286', '34', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1577', 'DPX19000-A18-Fourteen', 'DPtech', 'DPX19000-A18默认槽位14', '15', '1562', 'image', '19', '605', '287', '34', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1578', 'DPX19000-A18-Fifteen', 'DPtech', 'DPX19000-A18默认槽位15', '16', '1562', 'image', '20', '640', '286', '34', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1579', 'DPX19000-A18-Sixteen', 'DPtech', 'DPX19000-A18默认槽位16', '17', '1562', 'image', '19', '675', '287', '33', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1580', 'DPX19000-A18-Seventeen', 'DPtech', 'DPX19000-A18默认槽位17', '18', '1562', 'image', '19', '709', '287', '32', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1581', 'DPX19000-A18-EightNine-1', 'DPtech', 'DPX19000-A18主板槽位89-1', '9', '1562', 'image', '20', '395', '143', '42', 'red', '1', 'DPX19000-A18.png', 'DPX19000-A18', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', null, null, null, null, null, '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1582', '10GBASE-R', 'DPtech', '分流业务板（10GBASE-R），插在业务槽位，提供48个tengige接口', '1', '0', 'image', '35', '35', '287', '35', 'red', '1', '10GBASE-R.png', '10GBASE-R', '2015-04-29 15:37:38', '1', '2014-05-27 16:48:20', '1', null, null, null, null, null, '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1583', '10GBASE-R-Zero', 'DPtech', '10GBASE-R端口0', '0', '1582', 'image', '24', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1584', '10GBASE-R-One', 'DPtech', '10GBASE-R端口1', '1', '1582', 'image', '24', '19', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1585', '10GBASE-R-Two', 'DPtech', '10GBASE-R端口2', '2', '1582', 'image', '34', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1586', '10GBASE-R-Three', 'DPtech', '10GBASE-R端口3', '3', '1582', 'image', '34', '18', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1587', '10GBASE-R-Four', 'DPtech', '10GBASE-R端口4', '4', '1582', 'image', '44', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1588', '10GBASE-R-Five', 'DPtech', '10GBASE-R端口5', '5', '1582', 'image', '44', '18', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1589', '10GBASE-R-Six', 'DPtech', '10GBASE-R端口6', '6', '1582', 'image', '54', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1590', '10GBASE-R-Seven', 'DPtech', '10GBASE-R端口7', '7', '1582', 'image', '54', '18', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1591', '10GBASE-R-Eight', 'DPtech', '10GBASE-R端口8', '8', '1582', 'image', '64', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1592', '10GBASE-R-Nine', 'DPtech', '10GBASE-R端口9', '9', '1582', 'image', '64', '18', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1593', '10GBASE-R-Ten', 'DPtech', '10GBASE-R端口10', '10', '1582', 'image', '74', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1594', '10GBASE-R-Eleven', 'DPtech', '10GBASE-R端口11', '11', '1582', 'image', '74', '18', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1595', '10GBASE-R-Twelve', 'DPtech', '10GBASE-R端口12', '12', '1582', 'image', '84', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1596', '10GBASE-R-Thirteen', 'DPtech', '10GBASE-R端口13', '13', '1582', 'image', '84', '18', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1597', '10GBASE-R-Fourteen', 'DPtech', '10GBASE-R端口14', '14', '1582', 'image', '94', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1598', '10GBASE-R-Fifteen', 'DPtech', '10GBASE-R端口15', '15', '1582', 'image', '94', '18', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1599', '10GBASE-R-Sixteen', 'DPtech', '10GBASE-R端口16', '16', '1582', 'image', '105', '8', '8', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1600', '10GBASE-R-Seventeen', 'DPtech', '10GBASE-R端口17', '17', '1582', 'image', '105', '18', '8', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1601', '10GBASE-R-Eighteen', 'DPtech', '10GBASE-R端口18', '18', '1582', 'image', '114', '8', '8', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1602', '10GBASE-R-Nineteen', 'DPtech', '10GBASE-R端口19', '19', '1582', 'image', '114', '18', '8', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1603', '10GBASE-R-Twenty', 'DPtech', '10GBASE-R端口20', '20', '1582', 'image', '123', '8', '8', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1604', '10GBASE-R-Twentyone', 'DPtech', '10GBASE-R端口21', '21', '1582', 'image', '123', '18', '8', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1605', '10GBASE-R-Twentytwo', 'DPtech', '10GBASE-R端口22', '22', '1582', 'image', '132', '8', '8', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1606', '10GBASE-R-Twentythree', 'DPtech', '10GBASE-R端口23', '23', '1582', 'image', '132', '18', '8', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1607', '10GBASE-R-Twentyfour', 'DPtech', '10GBASE-R端口24', '24', '1582', 'image', '142', '8', '8', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1608', '10GBASE-R-Twentyfive', 'DPtech', '10GBASE-R端口25', '25', '1582', 'image', '142', '18', '8', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1609', '10GBASE-R-Twentysix', 'DPtech', '10GBASE-R端口26', '26', '1582', 'image', '151', '8', '8', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1610', '10GBASE-R-Twentyseven', 'DPtech', '10GBASE-R端口27', '27', '1582', 'image', '151', '18', '8', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1611', '10GBASE-R-Twentyeight', 'DPtech', '10GBASE-R端口28', '28', '1582', 'image', '161', '8', '8', '8', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1612', '10GBASE-R-Twentynine', 'DPtech', '10GBASE-R端口29', '29', '1582', 'image', '161', '18', '8', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1613', '10GBASE-R-Thirty', 'DPtech', '10GBASE-R端口30', '30', '1582', 'image', '171', '8', '8', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1614', '10GBASE-R-Thirtyone', 'DPtech', '10GBASE-R端口31', '31', '1582', 'image', '171', '18', '8', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1615', '10GBASE-R-Thirtytwo', 'DPtech', '10GBASE-R端口32', '32', '1582', 'image', '183', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1616', '10GBASE-R-Thirtythree', 'DPtech', '10GBASE-R端口33', '33', '1582', 'image', '183', '18', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1617', '10GBASE-R-Thirtyfour', 'DPtech', '10GBASE-R端口34', '34', '1582', 'image', '193', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1618', '10GBASE-R-Thirtyfive', 'DPtech', '10GBASE-R端口35', '35', '1582', 'image', '193', '18', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1619', '10GBASE-R-Thirtysix', 'DPtech', '10GBASE-R端口36', '36', '1582', 'image', '203', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1620', '10GBASE-R-Thirtyseven', 'DPtech', '10GBASE-R端口37', '37', '1582', 'image', '203', '18', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1621', '10GBASE-R-Thirtyeight', 'DPtech', '10GBASE-R端口38', '38', '1582', 'image', '213', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1622', '10GBASE-R-Thirtynine', 'DPtech', '10GBASE-R端口39', '39', '1582', 'image', '213', '18', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1623', '10GBASE-R-Forty', 'DPtech', '10GBASE-R端口40', '40', '1582', 'image', '222', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1624', '10GBASE-R-Fortyone', 'DPtech', '10GBASE-R端口41', '41', '1582', 'image', '222', '18', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1625', '10GBASE-R-Fortytwo', 'DPtech', '10GBASE-R端口42', '42', '1582', 'image', '233', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1626', '10GBASE-R-Fortythree', 'DPtech', '10GBASE-R端口43', '43', '1582', 'image', '232', '18', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1627', '10GBASE-R-Fortyfour', 'DPtech', '10GBASE-R端口44', '44', '1582', 'image', '241', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1628', '10GBASE-R-Fortyfive', 'DPtech', '10GBASE-R端口45', '45', '1582', 'image', '241', '18', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 17:09:46', '201', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1629', '10GBASE-R-Fortysix', 'DPtech', '10GBASE-R端口46', '46', '1582', 'image', '250', '8', '9', '7', 'red', '1', '10GBASE-R2.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1630', '10GBASE-R-FortySeven', 'DPtech', '10GBASE-R端口47', '47', '1582', 'image', '250', '18', '9', '7', 'red', '1', '10GBASE-R1.png', 'tengige[X]_[Y]', '2015-04-29 00:00:00', '4', '2015-04-29 00:00:00', '4', 'DI_SWITCHPORT', 'IFDESCR', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1631', 'N-MPUA', 'DPtech', 'N-MPUA主控板在DPX19000系列产品中起主导作用，实现系统的初始化配置、管理以及控制报文的处理等。', '1', '0', 'image', '10', '10', '144', '35', 'red', '1', 'N-MPUA.png', 'N-MPUA', '2015-04-29 00:00:00', '4', '2015-04-29 09:23:51', '4', null, null, null, null, null, '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1632', 'N-MPUA-0', 'DPtech', 'N_MPUA端口-0', '0', '1631', 'image', '22', '16', '9', '6', 'red', '1', 'N-MPUA.png', 'meth0_[Y]', '2015-05-05 16:58:14', '4', '2015-05-05 16:58:14', '4', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('1642', 'LE02G48TA', 'HUAWEI', 'LE02G48TA', '1', '0', 'image', '16', '83', '373', '41', 'red', '1', 'LE02G48TA.png', null, '2015-06-29 17:33:08', '1', '2015-06-29 17:33:08', '1', null, null, null, null, null, '2', '0', '0', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1643', 'LE02X40SFC', 'HUAWEI', 'LE02X40SFC', '1', '0', 'image', '16', '83', '373', '41', 'red', '1', 'LE02X40SFC.png', null, '2015-06-29 17:33:08', '1', '2015-06-29 17:33:08', '1', null, null, null, null, null, '2', '0', '0', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1644', 'LE02G24SA', 'HUAWEI', 'LE02G24SA', '1', '0', 'image', '16', '83', '373', '41', 'red', '1', 'LE02G24SA.png', null, '2015-06-29 17:33:08', '1', '2015-06-29 17:33:08', '1', null, null, null, null, null, '2', '0', '0', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1645', 'LE02G48TC', 'HUAWEI', 'LE02G48TC', '1', '0', 'image', '16', '83', '373', '41', 'red', '1', 'LE02G48TC.png', null, '2015-06-29 17:33:08', '1', '2015-06-29 17:33:08', '1', null, null, null, null, null, '2', '0', '0', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1646', 'LE02G48TD', 'HUAWEI', 'LE02G48TD', '1', '0', 'image', '16', '83', '373', '41', 'red', '1', 'LE02G48TD.png', null, '2015-06-29 17:33:08', '1', '2015-06-29 17:33:08', '1', null, null, null, null, null, '2', '0', '0', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1647', 'LE02G48TFA', 'HUAWEI', 'LE02G48TFA', '1', '0', 'image', '16', '83', '373', '41', 'red', '1', 'LE02G48TFA.png', null, '2015-06-29 17:33:08', '1', '2015-06-29 17:33:08', '1', null, null, null, null, null, '2', '0', '0', '1', null, null);
INSERT INTO `device_type_info` VALUES ('1648', 'LE02G24SA-0', 'HUAWEI', 'GigabitEthernet-0', '0', '1644', 'image', '107', '9', '12', '9', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:38:22', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1649', 'LE02G24SA-1', 'HUAWEI', 'GigabitEthernet-1', '1', '1644', 'image', '107', '20', '12', '10', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1650', 'LE02G24SA-2', 'HUAWEI', 'GigabitEthernet-2', '2', '1644', 'image', '120', '10', '12', '9', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1651', 'LE02G24SA-3', 'HUAWEI', 'GigabitEthernet-3', '3', '1644', 'image', '121', '20', '11', '9', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1652', 'LE02G24SA-5', 'HUAWEI', 'GigabitEthernet-5', '5', '1644', 'image', '135', '20', '11', '9', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1653', 'LE02G24SA-6', 'HUAWEI', 'GigabitEthernet-6', '6', '1644', 'image', '148', '9', '11', '10', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1654', 'LE02G24SA-7', 'HUAWEI', 'GigabitEthernet-7', '7', '1644', 'image', '148', '20', '11', '10', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1655', 'LE02G24SA-8', 'HUAWEI', 'GigabitEthernet-8', '8', '1644', 'image', '161', '9', '11', '9', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1656', 'LE02G24SA-9', 'HUAWEI', 'GigabitEthernet-9', '9', '1644', 'image', '161', '21', '12', '8', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1657', 'LE02G24SA-10', 'HUAWEI', 'GigabitEthernet-10', '10', '1644', 'image', '174', '9', '12', '9', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1658', 'LE02G24SA-11', 'HUAWEI', 'GigabitEthernet-11', '11', '1644', 'image', '175', '20', '11', '8', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1659', 'LE02G24SA-12', 'HUAWEI', 'GigabitEthernet-12', '12', '1644', 'image', '195', '9', '11', '9', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1660', 'LE02G24SA-13', 'HUAWEI', 'GigabitEthernet-13', '13', '1644', 'image', '194', '20', '11', '9', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1661', 'LE02G24SA-14', 'HUAWEI', 'GigabitEthernet-14', '14', '1644', 'image', '208', '9', '11', '9', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1662', 'LE02G24SA-16', 'HUAWEI', 'GigabitEthernet-16', '16', '1644', 'image', '221', '9', '11', '10', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1663', 'LE02G24SA-17', 'HUAWEI', 'GigabitEthernet-17', '17', '1644', 'image', '221', '20', '12', '10', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1664', 'LE02G48TC-0', 'HUAWEI', 'GigabitEthernet-0', '0', '1645', 'image', '21', '9', '12', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:59:39', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1665', 'LE02G48TC-1', 'HUAWEI', 'GigabitEthernet-1', '1', '1645', 'image', '21', '20', '12', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1666', 'LE02G48TC-2', 'HUAWEI', 'GigabitEthernet-2', '2', '1645', 'image', '33', '8', '11', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1667', 'LE02G48TC-3', 'HUAWEI', 'GigabitEthernet-3', '3', '1645', 'image', '33', '19', '11', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1668', 'LE02G48TC-4', 'HUAWEI', 'GigabitEthernet-4', '4', '1645', 'image', '45', '9', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1669', 'LE02G48TC-5', 'HUAWEI', 'GigabitEthernet-5', '5', '1645', 'image', '46', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1670', 'LE02G48TC-6', 'HUAWEI', 'GigabitEthernet-6', '6', '1645', 'image', '57', '9', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1671', 'LE02G48TC-7', 'HUAWEI', 'GigabitEthernet-7', '7', '1645', 'image', '57', '19', '10', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1672', 'LE02G24SA-18', 'HUAWEI', 'GigabitEthernet-18', '18', '1644', 'image', '233', '10', '13', '8', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1673', 'LE02G24SA-19', 'HUAWEI', 'GigabitEthernet-19', '19', '1644', 'image', '235', '20', '12', '10', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1674', 'LE02G24SA-20', 'HUAWEI', 'GigabitEthernet-20', '20', '1644', 'image', '248', '10', '12', '9', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1675', 'LE02G24SA-21', 'HUAWEI', 'GigabitEthernet-21', '21', '1644', 'image', '248', '20', '12', '8', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1676', 'LE02G24SA-22', 'HUAWEI', 'GigabitEthernet-22', '22', '1644', 'image', '262', '10', '11', '9', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1677', 'LE02G24SA-23', 'HUAWEI', 'GigabitEthernet-23', '23', '1644', 'image', '262', '19', '11', '10', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1678', 'LE02G24SA-15', 'HUAWEI', 'GigabitEthernet-15', '15', '1644', 'image', '208', '21', '11', '7', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1679', 'LE02G48TC-8', 'HUAWEI', 'GigabitEthernet-8', '8', '1645', 'image', '69', '9', '9', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1680', 'LE02G48TC-9', 'HUAWEI', 'GigabitEthernet-9', '9', '1645', 'image', '69', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1681', 'LE02G48TC-10', 'HUAWEI', 'GigabitEthernet-10', '10', '1645', 'image', '81', '8', '9', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1682', 'LE02G48TC-12', 'HUAWEI', 'GigabitEthernet-12', '12', '1645', 'image', '91', '8', '11', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1683', 'LE02G48TC-13', 'HUAWEI', 'GigabitEthernet-13', '13', '1645', 'image', '92', '19', '10', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1684', 'LE02G48TC-14', 'HUAWEI', 'GigabitEthernet-14', '14', '1645', 'image', '104', '9', '10', '7', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1685', 'LE02G48TC-15', 'HUAWEI', 'GigabitEthernet-15', '15', '1645', 'image', '104', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1686', 'LE02G48TC-16', 'HUAWEI', 'GigabitEthernet-16', '16', '1645', 'image', '120', '8', '11', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1687', 'LE02G48TC-17', 'HUAWEI', 'GigabitEthernet-17', '17', '1645', 'image', '119', '20', '12', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1688', 'LE02G48TC-18', 'HUAWEI', 'GigabitEthernet-18', '18', '1645', 'image', '132', '9', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1689', 'LE02G48TC-19', 'HUAWEI', 'GigabitEthernet-19', '19', '1645', 'image', '132', '20', '10', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1690', 'LE02G48TC-20', 'HUAWEI', 'GigabitEthernet-20', '20', '1645', 'image', '144', '9', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1691', 'LE02G48TC-21', 'HUAWEI', 'GigabitEthernet-21', '21', '1645', 'image', '144', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1692', 'LE02G48TC-22', 'HUAWEI', 'GigabitEthernet-22', '22', '1645', 'image', '155', '8', '11', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1693', 'LE02G48TC-23', 'HUAWEI', 'GigabitEthernet-23', '23', '1645', 'image', '156', '19', '9', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1694', 'LE02G48TC-24', 'HUAWEI', 'GigabitEthernet-24', '24', '1645', 'image', '167', '8', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1695', 'LE02G48TC-25', 'HUAWEI', 'GigabitEthernet-25', '25', '1645', 'image', '167', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1696', 'LE02G48TC-26', 'HUAWEI', 'GigabitEthernet-26', '26', '1645', 'image', '178', '8', '11', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1697', 'LE02G48TC-27', 'HUAWEI', 'GigabitEthernet-27', '27', '1645', 'image', '178', '20', '11', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1698', 'LE02G48TC-28', 'HUAWEI', 'GigabitEthernet-28', '28', '1645', 'image', '191', '8', '9', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1699', 'LE02G48TC-29', 'HUAWEI', 'GigabitEthernet-29', '29', '1645', 'image', '191', '20', '9', '7', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1700', 'LE02G48TC-31', 'HUAWEI', 'GigabitEthernet-31', '31', '1645', 'image', '202', '20', '10', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1701', 'LE02G48TC-32', 'HUAWEI', 'GigabitEthernet-32', '32', '1645', 'image', '217', '7', '12', '10', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1702', 'LE02G48TC-33', 'HUAWEI', 'GigabitEthernet-33', '33', '1645', 'image', '218', '20', '11', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1703', 'LE02G48TC-34', 'HUAWEI', 'GigabitEthernet-34', '34', '1645', 'image', '230', '8', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1704', 'LE02G48TC-35', 'HUAWEI', 'GigabitEthernet-35', '35', '1645', 'image', '231', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1705', 'LE02G48TC-37', 'HUAWEI', 'GigabitEthernet-37', '37', '1645', 'image', '241', '19', '12', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1706', 'LE02G48TC-38', 'HUAWEI', 'GigabitEthernet-38', '38', '1645', 'image', '254', '8', '9', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1707', 'LE02G48TC-36', 'HUAWEI', 'GigabitEthernet-36', '36', '1645', 'image', '242', '8', '9', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1708', 'LE02G48TC-39', 'HUAWEI', 'GigabitEthernet-39', '39', '1645', 'image', '254', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1709', 'LE02G48TD-0', 'HUAWEI', 'GigabitEthernet-0', '0', '1646', 'image', '21', '9', '11', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:13:21', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1710', 'LE02G48TD-1', 'HUAWEI', 'GigabitEthernet-1', '1', '1646', 'image', '21', '20', '12', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1711', 'LE02G48TD-2', 'HUAWEI', 'GigabitEthernet-2', '2', '1646', 'image', '34', '9', '9', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1712', 'LE02G48TD-3', 'HUAWEI', 'GigabitEthernet-3', '3', '1646', 'image', '34', '20', '10', '7', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1713', 'LE02G48TD-4', 'HUAWEI', 'GigabitEthernet-4', '4', '1646', 'image', '46', '9', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1714', 'LE02G48TD-5', 'HUAWEI', 'GigabitEthernet-5', '5', '1646', 'image', '46', '19', '9', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1715', 'LE02G48TD-6', 'HUAWEI', 'GigabitEthernet-6', '6', '1646', 'image', '56', '8', '11', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1716', 'LE02G48TD-7', 'HUAWEI', 'GigabitEthernet-7', '7', '1646', 'image', '58', '19', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1717', 'LE02G48TD-8', 'HUAWEI', 'GigabitEthernet-8', '8', '1646', 'image', '69', '8', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1718', 'LE02G48TD-9', 'HUAWEI', 'GigabitEthernet-9', '9', '1646', 'image', '69', '20', '10', '7', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1719', 'LE02G48TD-10', 'HUAWEI', 'GigabitEthernet-10', '10', '1646', 'image', '80', '8', '9', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1720', 'LE02G48TD-11', 'HUAWEI', 'GigabitEthernet-11', '11', '1646', 'image', '81', '20', '10', '7', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1721', 'LE02G48TD-12', 'HUAWEI', 'GigabitEthernet-12', '12', '1646', 'image', '92', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1722', 'LE02G48TD-13', 'HUAWEI', 'GigabitEthernet-13', '13', '1646', 'image', '93', '19', '10', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1723', 'LE02G48TD-14', 'HUAWEI', 'GigabitEthernet-14', '14', '1646', 'image', '104', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1724', 'LE02G48TD-15', 'HUAWEI', 'GigabitEthernet-15', '15', '1646', 'image', '103', '20', '12', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1725', 'LE02G48TD-16', 'HUAWEI', 'GigabitEthernet-16', '16', '1646', 'image', '120', '8', '9', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1726', 'LE02G48TD-18', 'HUAWEI', 'GigabitEthernet-18', '18', '1646', 'image', '132', '7', '10', '10', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1727', 'LE02G48TD-19', 'HUAWEI', 'GigabitEthernet-19', '19', '1646', 'image', '132', '19', '11', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1728', 'LE02G48TD-21', 'HUAWEI', 'GigabitEthernet-21', '21', '1646', 'image', '144', '19', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1729', 'LE02G48TD-22', 'HUAWEI', 'GigabitEthernet-22', '22', '1646', 'image', '155', '9', '11', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1730', 'LE02G48TD-24', 'HUAWEI', 'GigabitEthernet-24', '24', '1646', 'image', '167', '8', '11', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1731', 'LE02G48TD-26', 'HUAWEI', 'GigabitEthernet-26', '26', '1646', 'image', '179', '8', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1732', 'LE02G48TD-27', 'HUAWEI', 'GigabitEthernet-27', '27', '1646', 'image', '179', '19', '11', '10', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1733', 'LE02G48TD-29', 'HUAWEI', 'GigabitEthernet-29', '29', '1646', 'image', '191', '20', '9', '7', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1734', 'LE02G48TD-30', 'HUAWEI', 'GigabitEthernet-30', '30', '1646', 'image', '202', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1735', 'LE02G48TD-32', 'HUAWEI', 'GigabitEthernet-32', '32', '1646', 'image', '219', '8', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1736', 'LE02G48TD-33', 'HUAWEI', 'GigabitEthernet-33', '33', '1646', 'image', '217', '18', '11', '10', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1737', 'LE02G48TD-35', 'HUAWEI', 'GigabitEthernet-35', '35', '1646', 'image', '230', '20', '11', '7', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1738', 'LE02G48TD-36', 'HUAWEI', 'GigabitEthernet-36', '36', '1646', 'image', '242', '8', '9', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1739', 'LE02G48TD-38', 'HUAWEI', 'GigabitEthernet-38', '38', '1646', 'image', '253', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1740', 'LE02G48TD-20', 'HUAWEI', 'GigabitEthernet-20', '20', '1646', 'image', '143', '7', '11', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1741', 'LE02G48TD-23', 'HUAWEI', 'GigabitEthernet-23', '23', '1646', 'image', '155', '19', '11', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1742', 'LE02G48TD-25', 'HUAWEI', 'GigabitEthernet-25', '25', '1646', 'image', '167', '20', '12', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1743', 'LE02G24SA-4', 'HUAWEI', 'GigabitEthernet-4', '4', '1644', 'image', '135', '10', '11', '8', 'red', '1', '24port.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:37:34', '1', '2015-06-30 11:37:34', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1744', 'LE02G48TD-28', 'HUAWEI', 'GigabitEthernet-28', '28', '1646', 'image', '191', '7', '8', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1745', 'LE02G48TD-31', 'HUAWEI', 'GigabitEthernet-31', '31', '1646', 'image', '202', '20', '12', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1746', 'LE02G48TD-34', 'HUAWEI', 'GigabitEthernet-34', '34', '1646', 'image', '230', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1747', 'LE02G48TD-37', 'HUAWEI', 'GigabitEthernet-37', '37', '1646', 'image', '242', '20', '10', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1748', 'LE02G48TD-39', 'HUAWEI', 'GigabitEthernet-39', '39', '1646', 'image', '254', '19', '10', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1749', 'LE02G48TC-11', 'HUAWEI', 'GigabitEthernet-11', '11', '1645', 'image', '80', '20', '9', '7', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1750', 'LE02G48TC-30', 'HUAWEI', 'GigabitEthernet-30', '30', '1645', 'image', '202', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 13:58:27', '1', '2015-06-30 13:58:27', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1751', 'LE02G48TD-17', 'HUAWEI', 'GigabitEthernet-17', '17', '1646', 'image', '121', '19', '11', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:12:23', '1', '2015-06-30 14:12:23', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1752', 'LE02G48TD-40', 'HUAWEI', 'GigabitEthernet-40', '40', '1646', 'image', '265', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:15:17', '1', '2015-06-30 17:15:17', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1753', 'LE02G48TD-41', 'HUAWEI', 'GigabitEthernet-41', '41', '1646', 'image', '265', '19', '10', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:15:17', '1', '2015-06-30 17:15:17', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1754', 'LE02G48TD-42', 'HUAWEI', 'GigabitEthernet-42', '42', '1646', 'image', '276', '8', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:15:17', '1', '2015-06-30 17:15:17', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1755', 'LE02G48TD-43', 'HUAWEI', 'GigabitEthernet-43', '43', '1646', 'image', '276', '19', '11', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:15:17', '1', '2015-06-30 17:15:17', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1756', 'LE02G48TD-44', 'HUAWEI', 'GigabitEthernet-44', '44', '1646', 'image', '289', '8', '8', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:15:17', '1', '2015-06-30 17:15:17', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1757', 'LE02G48TD-45', 'HUAWEI', 'GigabitEthernet-45', '45', '1646', 'image', '288', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:15:17', '1', '2015-06-30 17:15:17', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1758', 'LE02G48TD-46', 'HUAWEI', 'GigabitEthernet-46', '46', '1646', 'image', '301', '9', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:15:17', '1', '2015-06-30 17:15:17', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1759', 'LE02G48TD-47', 'HUAWEI', 'GigabitEthernet-47', '47', '1646', 'image', '300', '19', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:15:17', '1', '2015-06-30 17:15:17', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1760', 'LE02G48TFA-40', 'HUAWEI', 'GigabitEthernet-40', '40', '1647', 'image', '264', '8', '11', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:18:42', '1', '2015-06-30 17:18:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1761', 'LE02G48TFA-41', 'HUAWEI', 'GigabitEthernet-41', '41', '1647', 'image', '266', '20', '10', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:18:42', '1', '2015-06-30 17:18:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1762', 'LE02G48TFA-42', 'HUAWEI', 'GigabitEthernet-42', '42', '1647', 'image', '277', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:18:42', '1', '2015-06-30 17:18:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1763', 'LE02G48TFA-43', 'HUAWEI', 'GigabitEthernet-43', '43', '1647', 'image', '277', '19', '10', '10', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:18:42', '1', '2015-06-30 17:18:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1764', 'LE02G48TFA-44', 'HUAWEI', 'GigabitEthernet-44', '44', '1647', 'image', '288', '8', '11', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:18:42', '1', '2015-06-30 17:18:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1765', 'LE02G48TFA-45', 'HUAWEI', 'GigabitEthernet-45', '45', '1647', 'image', '288', '20', '11', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:18:42', '1', '2015-06-30 17:18:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1766', 'LE02G48TFA-46', 'HUAWEI', 'GigabitEthernet-46', '46', '1647', 'image', '301', '8', '9', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:18:42', '1', '2015-06-30 17:18:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1767', 'LE02G48TFA-47', 'HUAWEI', 'GigabitEthernet-47', '47', '1647', 'image', '301', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:18:42', '1', '2015-06-30 17:18:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1768', 'LE02G48TA-0', 'HUAWEI', 'GigabitEthernet-0', '0', '1642', 'image', '21', '8', '11', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:48:54', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1769', 'LE02G48TA-1', 'HUAWEI', 'GigabitEthernet-1', '1', '1642', 'image', '22', '20', '11', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1770', 'LE02G48TA-2', 'HUAWEI', 'GigabitEthernet-2', '2', '1642', 'image', '34', '9', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1771', 'LE02G48TA-3', 'HUAWEI', 'GigabitEthernet-3', '3', '1642', 'image', '34', '21', '11', '7', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1772', 'LE02G48TA-4', 'HUAWEI', 'GigabitEthernet-4', '4', '1642', 'image', '46', '8', '9', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1773', 'LE02G48TA-5', 'HUAWEI', 'GigabitEthernet-5', '5', '1642', 'image', '45', '20', '11', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1774', 'LE02G48TA-6', 'HUAWEI', 'GigabitEthernet-6', '6', '1642', 'image', '58', '8', '8', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1775', 'LE02G48TA-7', 'HUAWEI', 'GigabitEthernet-7', '7', '1642', 'image', '57', '20', '10', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1776', 'LE02G48TA-8', 'HUAWEI', 'GigabitEthernet-8', '8', '1642', 'image', '68', '9', '11', '7', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1777', 'LE02G48TA-9', 'HUAWEI', 'GigabitEthernet-9', '9', '1642', 'image', '68', '21', '11', '7', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1778', 'LE02G48TA-10', 'HUAWEI', 'GigabitEthernet-10', '10', '1642', 'image', '80', '9', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1779', 'LE02G48TA-11', 'HUAWEI', 'GigabitEthernet-11', '11', '1642', 'image', '80', '20', '11', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1780', 'LE02G48TA-12', 'HUAWEI', 'GigabitEthernet-12', '12', '1642', 'image', '91', '9', '10', '7', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1781', 'LE02G48TA-13', 'HUAWEI', 'GigabitEthernet-13', '13', '1642', 'image', '92', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1782', 'LE02G48TA-14', 'HUAWEI', 'GigabitEthernet-14', '14', '1642', 'image', '103', '9', '11', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1783', 'LE02G48TA-15', 'HUAWEI', 'GigabitEthernet-15', '15', '1642', 'image', '103', '20', '11', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1784', 'LE02G48TA-17', 'HUAWEI', 'GigabitEthernet-17', '17', '1642', 'image', '120', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1785', 'LE02G48TA-18', 'HUAWEI', 'GigabitEthernet-18', '18', '1642', 'image', '133', '9', '9', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1786', 'LE02G48TA-19', 'HUAWEI', 'GigabitEthernet-19', '19', '1642', 'image', '132', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1787', 'LE02G48TA-20', 'HUAWEI', 'GigabitEthernet-20', '20', '1642', 'image', '144', '9', '9', '7', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1788', 'LE02G48TA-21', 'HUAWEI', 'GigabitEthernet-21', '21', '1642', 'image', '144', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1789', 'LE02G48TA-22', 'HUAWEI', 'GigabitEthernet-22', '22', '1642', 'image', '156', '10', '9', '7', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1790', 'LE02G48TA-23', 'HUAWEI', 'GigabitEthernet-23', '23', '1642', 'image', '156', '20', '9', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1791', 'LE02G48TA-24', 'HUAWEI', 'GigabitEthernet-24', '24', '1642', 'image', '168', '7', '9', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1792', 'LE02G48TA-25', 'HUAWEI', 'GigabitEthernet-25', '25', '1642', 'image', '167', '19', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1793', 'LE02G48TA-26', 'HUAWEI', 'GigabitEthernet-26', '26', '1642', 'image', '179', '7', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1794', 'LE02G48TA-27', 'HUAWEI', 'GigabitEthernet-27', '27', '1642', 'image', '179', '19', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1795', 'LE02G48TA-28', 'HUAWEI', 'GigabitEthernet-28', '28', '1642', 'image', '190', '9', '10', '7', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1796', 'LE02G48TA-29', 'HUAWEI', 'GigabitEthernet-29', '29', '1642', 'image', '191', '19', '9', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1797', 'LE02G48TA-30', 'HUAWEI', 'GigabitEthernet-30', '30', '1642', 'image', '201', '8', '11', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1798', 'LE02G48TA-31', 'HUAWEI', 'GigabitEthernet-31', '31', '1642', 'image', '202', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1799', 'LE02G48TA-33', 'HUAWEI', 'GigabitEthernet-33', '33', '1642', 'image', '217', '20', '12', '7', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1800', 'LE02G48TA-34', 'HUAWEI', 'GigabitEthernet-34', '34', '1642', 'image', '230', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1801', 'LE02G48TA-35', 'HUAWEI', 'GigabitEthernet-35', '35', '1642', 'image', '230', '20', '11', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1802', 'LE02G48TA-36', 'HUAWEI', 'GigabitEthernet-36', '36', '1642', 'image', '242', '9', '10', '7', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1803', 'LE02G48TA-37', 'HUAWEI', 'GigabitEthernet-37', '37', '1642', 'image', '242', '20', '11', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1804', 'LE02G48TA-38', 'HUAWEI', 'GigabitEthernet-38', '38', '1642', 'image', '254', '9', '9', '7', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1805', 'LE02G48TA-40', 'HUAWEI', 'GigabitEthernet-40', '40', '1642', 'image', '266', '9', '10', '7', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1806', 'LE02G48TA-42', 'HUAWEI', 'GigabitEthernet-42', '42', '1642', 'image', '277', '9', '11', '7', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1807', 'LE02G48TA-43', 'HUAWEI', 'GigabitEthernet-43', '43', '1642', 'image', '278', '19', '10', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1808', 'LE02G48TA-45', 'HUAWEI', 'GigabitEthernet-45', '45', '1642', 'image', '288', '20', '11', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1809', 'LE02G48TA-46', 'HUAWEI', 'GigabitEthernet-46', '46', '1642', 'image', '301', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1810', 'LE02X40SFC-36', 'HUAWEI', 'XGigabitEthernet-36', '36', '1643', 'image', '280', '9', '11', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1811', 'LE02X40SFC-39', 'HUAWEI', 'XGigabitEthernet-39', '39', '1643', 'image', '296', '20', '8', '7', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1812', 'LE02G48TA-39', 'HUAWEI', 'GigabitEthernet-39', '39', '1642', 'image', '254', '20', '10', '7', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1813', 'LE02G48TA-41', 'HUAWEI', 'GigabitEthernet-41', '41', '1642', 'image', '266', '20', '10', '7', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1814', 'LE02G48TA-44', 'HUAWEI', 'GigabitEthernet-44', '44', '1642', 'image', '289', '8', '9', '10', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1815', 'LE02G48TA-47', 'HUAWEI', 'GigabitEthernet-47', '47', '1642', 'image', '300', '20', '11', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1816', 'LE02X40SFC-13', 'HUAWEI', 'XGigabitEthernet-13', '13', '1643', 'image', '109', '20', '10', '7', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1817', 'LE02X40SFC-34', 'HUAWEI', 'XGigabitEthernet-34', '34', '1643', 'image', '265', '10', '13', '7', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1818', 'LE02G48TC-40', 'HUAWEI', 'GigabitEthernet-40', '40', '1645', 'image', '264', '9', '11', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:03:00', '1', '2015-06-30 17:03:00', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1819', 'LE02G48TC-41', 'HUAWEI', 'GigabitEthernet-41', '41', '1645', 'image', '266', '18', '9', '10', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:03:00', '1', '2015-06-30 17:03:00', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1820', 'LE02X40SFC-33', 'HUAWEI', 'XGigabitEthernet-33', '33', '1643', 'image', '252', '19', '10', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1821', 'LE02G48TC-42', 'HUAWEI', 'GigabitEthernet-42', '42', '1645', 'image', '276', '8', '11', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:03:00', '1', '2015-06-30 17:03:00', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1822', 'LE02G48TC-43', 'HUAWEI', 'GigabitEthernet-43', '43', '1645', 'image', '276', '18', '11', '10', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:03:00', '1', '2015-06-30 17:03:00', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1823', 'LE02G48TC-44', 'HUAWEI', 'GigabitEthernet-44', '44', '1645', 'image', '288', '9', '11', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:03:00', '1', '2015-06-30 17:03:00', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1824', 'LE02G48TC-45', 'HUAWEI', 'GigabitEthernet-45', '45', '1645', 'image', '289', '19', '10', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:03:00', '1', '2015-06-30 17:03:00', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1825', 'LE02G48TC-46', 'HUAWEI', 'GigabitEthernet-46', '46', '1645', 'image', '300', '9', '11', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:03:00', '1', '2015-06-30 17:03:00', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1826', 'LE02G48TC-47', 'HUAWEI', 'GigabitEthernet-47', '47', '1645', 'image', '301', '19', '9', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 17:03:00', '1', '2015-06-30 17:03:00', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1827', 'LE02G48TFA-0', 'HUAWEI', 'GigabitEthernet-0', '0', '1647', 'image', '21', '8', '11', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:46', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1828', 'LE02G48TFA-1', 'HUAWEI', 'GigabitEthernet-1', '1', '1647', 'image', '22', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:34:05', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1829', 'LE02G48TFA-2', 'HUAWEI', 'GigabitEthernet-2', '2', '1647', 'image', '33', '8', '11', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1830', 'LE02G48TFA-3', 'HUAWEI', 'GigabitEthernet-3', '3', '1647', 'image', '34', '19', '10', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1831', 'LE02G48TFA-4', 'HUAWEI', 'GigabitEthernet-4', '4', '1647', 'image', '45', '8', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1832', 'LE02G48TFA-5', 'HUAWEI', 'GigabitEthernet-5', '5', '1647', 'image', '46', '19', '10', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1833', 'LE02G48TFA-6', 'HUAWEI', 'GigabitEthernet-6', '6', '1647', 'image', '57', '8', '10', '7', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1834', 'LE02G48TFA-7', 'HUAWEI', 'GigabitEthernet-7', '7', '1647', 'image', '57', '19', '11', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1835', 'LE02G48TFA-8', 'HUAWEI', 'GigabitEthernet-8', '8', '1647', 'image', '68', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1836', 'LE02G48TFA-9', 'HUAWEI', 'GigabitEthernet-9', '9', '1647', 'image', '69', '19', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1837', 'LE02G48TFA-10', 'HUAWEI', 'GigabitEthernet-10', '10', '1647', 'image', '81', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1838', 'LE02G48TFA-11', 'HUAWEI', 'GigabitEthernet-11', '11', '1647', 'image', '80', '19', '11', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1839', 'LE02G48TFA-12', 'HUAWEI', 'GigabitEthernet-12', '12', '1647', 'image', '92', '9', '9', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1840', 'LE02G48TFA-13', 'HUAWEI', 'GigabitEthernet-13', '13', '1647', 'image', '92', '19', '11', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1841', 'LE02G48TFA-14', 'HUAWEI', 'GigabitEthernet-14', '14', '1647', 'image', '103', '8', '11', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1842', 'LE02G48TFA-15', 'HUAWEI', 'GigabitEthernet-15', '15', '1647', 'image', '104', '20', '10', '7', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1843', 'LE02G48TFA-16', 'HUAWEI', 'GigabitEthernet-16', '16', '1647', 'image', '121', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1844', 'LE02G48TFA-17', 'HUAWEI', 'GigabitEthernet-17', '17', '1647', 'image', '120', '20', '11', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1845', 'LE02G48TFA-18', 'HUAWEI', 'GigabitEthernet-18', '18', '1647', 'image', '131', '7', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1846', 'LE02G48TFA-19', 'HUAWEI', 'GigabitEthernet-19', '19', '1647', 'image', '132', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1847', 'LE02G48TFA-20', 'HUAWEI', 'GigabitEthernet-20', '20', '1647', 'image', '144', '9', '9', '7', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1848', 'LE02G48TFA-21', 'HUAWEI', 'GigabitEthernet-21', '21', '1647', 'image', '144', '19', '11', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1849', 'LE02G48TFA-22', 'HUAWEI', 'GigabitEthernet-22', '22', '1647', 'image', '156', '8', '9', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1850', 'LE02G48TFA-23', 'HUAWEI', 'GigabitEthernet-23', '23', '1647', 'image', '156', '19', '10', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1851', 'LE02G48TFA-24', 'HUAWEI', 'GigabitEthernet-24', '24', '1647', 'image', '167', '9', '11', '7', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1852', 'LE02G48TFA-25', 'HUAWEI', 'GigabitEthernet-25', '25', '1647', 'image', '167', '20', '10', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1853', 'LE02G48TFA-26', 'HUAWEI', 'GigabitEthernet-26', '26', '1647', 'image', '177', '9', '12', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1854', 'LE02G48TFA-27', 'HUAWEI', 'GigabitEthernet-27', '27', '1647', 'image', '179', '20', '10', '7', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1855', 'LE02G48TFA-28', 'HUAWEI', 'GigabitEthernet-28', '28', '1647', 'image', '190', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1856', 'LE02G48TFA-29', 'HUAWEI', 'GigabitEthernet-29', '29', '1647', 'image', '190', '20', '11', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1857', 'LE02G48TFA-30', 'HUAWEI', 'GigabitEthernet-30', '30', '1647', 'image', '202', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1858', 'LE02G48TFA-31', 'HUAWEI', 'GigabitEthernet-31', '31', '1647', 'image', '201', '18', '11', '10', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1859', 'LE02G48TFA-32', 'HUAWEI', 'GigabitEthernet-32', '32', '1647', 'image', '219', '9', '10', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1860', 'LE02G48TFA-33', 'HUAWEI', 'GigabitEthernet-33', '33', '1647', 'image', '218', '20', '11', '9', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1861', 'LE02G48TFA-34', 'HUAWEI', 'GigabitEthernet-34', '34', '1647', 'image', '230', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1862', 'LE02G48TFA-35', 'HUAWEI', 'GigabitEthernet-35', '35', '1647', 'image', '230', '18', '10', '10', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1863', 'LE02G48TFA-36', 'HUAWEI', 'GigabitEthernet-36', '36', '1647', 'image', '242', '8', '10', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1864', 'LE02G48TFA-37', 'HUAWEI', 'GigabitEthernet-37', '37', '1647', 'image', '241', '20', '11', '8', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1865', 'LE02G48TFA-38', 'HUAWEI', 'GigabitEthernet-38', '38', '1647', 'image', '253', '9', '11', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1866', 'LE02G48TFA-39', 'HUAWEI', 'GigabitEthernet-39', '39', '1647', 'image', '254', '19', '10', '10', 'red', '1', '48portdown.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 14:22:15', '1', '2015-06-30 14:22:15', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1867', 'LE02G48TA-16', 'HUAWEI', 'GigabitEthernet-16', '16', '1642', 'image', '119', '8', '12', '9', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1868', 'LE02G48TA-32', 'HUAWEI', 'GigabitEthernet-32', '32', '1642', 'image', '218', '9', '11', '8', 'red', '1', '48portup.png', 'GigabitEthernet[X]/0/[Y]', '2015-06-30 11:43:42', '1', '2015-06-30 11:43:42', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1869', 'LE02X40SFC-0', 'HUAWEI', 'XGigabitEthernet-0', '0', '1643', 'image', '22', '10', '12', '9', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:23:39', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1870', 'LE02X40SFC-1', 'HUAWEI', 'XGigabitEthernet-1', '1', '1643', 'image', '23', '19', '10', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:24:21', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1871', 'LE02X40SFC-2', 'HUAWEI', 'XGigabitEthernet-2', '2', '1643', 'image', '37', '10', '11', '7', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:24:50', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1872', 'LE02X40SFC-3', 'HUAWEI', 'XGigabitEthernet-3', '3', '1643', 'image', '37', '19', '11', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1873', 'LE02X40SFC-4', 'HUAWEI', 'XGigabitEthernet-4', '4', '1643', 'image', '52', '10', '11', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1874', 'LE02X40SFC-5', 'HUAWEI', 'XGigabitEthernet-5', '5', '1643', 'image', '52', '19', '10', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1875', 'LE02X40SFC-6', 'HUAWEI', 'XGigabitEthernet-6', '6', '1643', 'image', '66', '9', '11', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1876', 'LE02X40SFC-7', 'HUAWEI', 'XGigabitEthernet-7', '7', '1643', 'image', '66', '19', '10', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1877', 'LE02X40SFC-8', 'HUAWEI', 'XGigabitEthernet-8', '8', '1643', 'image', '80', '9', '11', '9', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1878', 'LE02X40SFC-9', 'HUAWEI', 'XGigabitEthernet-9', '9', '1643', 'image', '80', '20', '11', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1879', 'LE02X40SFC-10', 'HUAWEI', 'XGigabitEthernet-10', '10', '1643', 'image', '95', '10', '11', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1880', 'LE02X40SFC-11', 'HUAWEI', 'XGigabitEthernet-11', '11', '1643', 'image', '95', '20', '10', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1881', 'LE02X40SFC-12', 'HUAWEI', 'XGigabitEthernet-12', '12', '1643', 'image', '109', '10', '10', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1882', 'LE02X40SFC-14', 'HUAWEI', 'XGigabitEthernet-14', '14', '1643', 'image', '123', '10', '11', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1883', 'LE02X40SFC-15', 'HUAWEI', 'XGigabitEthernet-15', '15', '1643', 'image', '123', '19', '11', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1884', 'LE02X40SFC-16', 'HUAWEI', 'XGigabitEthernet-16', '16', '1643', 'image', '137', '9', '11', '10', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1885', 'LE02X40SFC-17', 'HUAWEI', 'XGigabitEthernet-17', '17', '1643', 'image', '137', '19', '11', '9', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1886', 'LE02X40SFC-18', 'HUAWEI', 'XGigabitEthernet-18', '18', '1643', 'image', '152', '10', '10', '7', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1887', 'LE02X40SFC-19', 'HUAWEI', 'XGigabitEthernet-19', '19', '1643', 'image', '153', '20', '9', '6', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1888', 'LE02X40SFC-20', 'HUAWEI', 'XGigabitEthernet-20', '20', '1643', 'image', '166', '10', '10', '7', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1889', 'LE02X40SFC-21', 'HUAWEI', 'XGigabitEthernet-21', '21', '1643', 'image', '167', '20', '10', '7', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1890', 'LE02X40SFC-22', 'HUAWEI', 'XGigabitEthernet-22', '22', '1643', 'image', '180', '10', '11', '7', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1891', 'LE02X40SFC-23', 'HUAWEI', 'XGigabitEthernet-23', '23', '1643', 'image', '181', '20', '10', '7', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1892', 'LE02X40SFC-24', 'HUAWEI', 'XGigabitEthernet-24', '24', '1643', 'image', '196', '11', '10', '6', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1893', 'LE02X40SFC-25', 'HUAWEI', 'XGigabitEthernet-25', '25', '1643', 'image', '195', '21', '9', '6', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1894', 'LE02X40SFC-26', 'HUAWEI', 'XGigabitEthernet-26', '26', '1643', 'image', '209', '10', '11', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1895', 'LE02X40SFC-27', 'HUAWEI', 'XGigabitEthernet-27', '27', '1643', 'image', '209', '20', '11', '6', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1896', 'LE02X40SFC-28', 'HUAWEI', 'XGigabitEthernet-28', '28', '1643', 'image', '222', '10', '13', '7', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1897', 'LE02X40SFC-29', 'HUAWEI', 'XGigabitEthernet-29', '29', '1643', 'image', '223', '20', '11', '7', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1898', 'LE02X40SFC-30', 'HUAWEI', 'XGigabitEthernet-30', '30', '1643', 'image', '238', '10', '10', '7', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1899', 'LE02X40SFC-31', 'HUAWEI', 'XGigabitEthernet-31', '31', '1643', 'image', '237', '18', '11', '10', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1900', 'LE02X40SFC-32', 'HUAWEI', 'XGigabitEthernet-32', '32', '1643', 'image', '251', '9', '12', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1901', 'LE02X40SFC-35', 'HUAWEI', 'XGigabitEthernet-35', '35', '1643', 'image', '266', '20', '11', '7', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1902', 'LE02X40SFC-37', 'HUAWEI', 'XGigabitEthernet-37', '37', '1643', 'image', '280', '20', '11', '7', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('1903', 'LE02X40SFC-38', 'HUAWEI', 'XGigabitEthernet-38', '38', '1643', 'image', '295', '10', '10', '8', 'red', '1', '40port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-06-30 11:19:44', '1', '2015-06-30 11:19:44', '1', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('3162', 'LEODX16SFC00', 'HUAWEI', 'LEODX16SFC00板卡', '1', '0', 'image', '10', '10', '373', '41', 'red', '1', 'LEODX16SFC00.png', 'LEODX16SFC00', '2015-10-12 16:43:17', '1', null, null, null, null, null, null, null, '2', '0', '0', '1', null, null);
INSERT INTO `device_type_info` VALUES ('3204', 'LEODX16SFC00-0', 'HUAWEI', 'XGigabitEthernet-0', '0', '3162', 'image', '121', '7', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('3205', 'LEODX16SFC00-1', 'HUAWEI', 'XGigabitEthernet-1', '1', '3162', 'image', '121', '22', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('3206', 'LEODX16SFC00-2', 'HUAWEI', 'XGigabitEthernet-2', '2', '3162', 'image', '136', '7', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('3207', 'LEODX16SFC00-3', 'HUAWEI', 'XGigabitEthernet-3', '3', '3162', 'image', '136', '22', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('3208', 'LEODX16SFC00-4', 'HUAWEI', 'XGigabitEthernet-4', '4', '3162', 'image', '151', '7', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('3209', 'LEODX16SFC00-5', 'HUAWEI', 'XGigabitEthernet-5', '5', '3162', 'image', '151', '22', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('3210', 'LEODX16SFC00-6', 'HUAWEI', 'XGigabitEthernet-6', '6', '3162', 'image', '166', '7', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('3211', 'LEODX16SFC00-7', 'HUAWEI', 'XGigabitEthernet-7', '7', '3162', 'image', '166', '22', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('3212', 'LEODX16SFC00-8', 'HUAWEI', 'XGigabitEthernet-8', '8', '3162', 'image', '198', '7', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('3213', 'LEODX16SFC00-9', 'HUAWEI', 'XGigabitEthernet-9', '9', '3162', 'image', '198', '22', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('3214', 'LEODX16SFC00-10', 'HUAWEI', 'XGigabitEthernet-10', '10', '3162', 'image', '213', '7', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('3215', 'LEODX16SFC00-11', 'HUAWEI', 'XGigabitEthernet-11', '11', '3162', 'image', '213', '22', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('3216', 'LEODX16SFC00-12', 'HUAWEI', 'XGigabitEthernet-12', '12', '3162', 'image', '228', '7', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('3217', 'LEODX16SFC00-13', 'HUAWEI', 'XGigabitEthernet-13', '13', '3162', 'image', '228', '22', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('3218', 'LEODX16SFC00-14', 'HUAWEI', 'XGigabitEthernet-14', '14', '3162', 'image', '243', '7', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('3219', 'LEODX16SFC00-15', 'HUAWEI', 'XGigabitEthernet-15', '15', '3162', 'image', '243', '22', '13', '8', 'red', '1', 'LEODX16SFC00port.png', 'XGigabitEthernet[X]/0/[Y]', '2015-10-10 16:15:20', '242', '2015-10-10 16:15:20', '242', 'DI_SWITCHPORT', 'ifDescr', null, null, null, '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100000', 'FF-N3100', 'SUGON', '机框', '1', '0', 'image', '35', '35', '442', '573', 'red', '1', 'FF-N3100-FRAME.png', 'FF-N3100', '2018-07-10 15:04:44', '1', '2018-07-11 18:33:30', '1', '', null, null, '', '', '1', '0', '0', null, '0', '0');
INSERT INTO `device_type_info` VALUES ('100016', 'SINOVATIO_9012', 'SINOVATIO', '机框', '1', '0', 'image', '35', '35', '442', '775', 'red', '1', 'SINOVATIO_9012-FRAME.png', 'SINOVATIO_9012', '2018-07-10 15:11:55', '1', '2018-07-10 17:07:02', '1', 'DI_SYSTEM', '', '', '', '', '1', '0', '0', null, '0', '0');
INSERT INTO `device_type_info` VALUES ('100022', 'SINOVATIO_9012-1', 'SINOVATIO', '槽位-1', '1', '100016', 'image', '52', '38', '359', '40', 'red', '1', null, null, '2018-07-10 15:18:15', '100004', '2018-07-10 15:18:15', '100004', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100023', 'SINOVATIO_9012-2', 'SINOVATIO', '槽位-2', '2', '100016', 'image', '52', '78', '359', '40', 'red', '1', null, null, '2018-07-10 15:18:15', '100004', '2018-07-10 15:18:15', '100004', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100024', 'SINOVATIO_9012-3', 'SINOVATIO', '槽位-3', '3', '100016', 'image', '52', '118', '359', '40', 'red', '1', null, null, '2018-07-10 15:18:15', '100004', '2018-07-10 15:18:15', '100004', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100025', 'SINOVATIO_9012-4', 'SINOVATIO', '槽位-4', '4', '100016', 'image', '52', '158', '359', '40', 'red', '1', null, null, '2018-07-10 15:18:15', '100004', '2018-07-10 15:18:15', '100004', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100026', 'SINOVATIO_9012-5', 'SINOVATIO', '槽位-5', '5', '100016', 'image', '52', '198', '359', '40', 'red', '1', null, null, '2018-07-10 15:18:15', '100004', '2018-07-10 15:18:15', '100004', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100027', 'SINOVATIO_9012-6', 'SINOVATIO', '槽位-6', '6', '100016', 'image', '52', '237', '359', '40', 'red', '1', null, null, '2018-07-10 15:18:15', '100004', '2018-07-10 15:18:15', '100004', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100028', 'SINOVATIO_9012-7', 'SINOVATIO', '槽位-7', '7', '100016', 'image', null, null, null, null, 'red', '1', null, null, '2018-07-10 15:18:15', '100004', '2018-07-10 15:18:15', '100004', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100029', 'SINOVATIO_9012-8', 'SINOVATIO', '槽位-8', '8', '100016', 'image', null, null, null, null, 'red', '1', null, null, '2018-07-10 15:18:15', '100004', '2018-07-10 15:18:15', '100004', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100030', 'SINOVATIO_9012-9', 'SINOVATIO', '槽位-9', '9', '100016', 'image', '52', '358', '359', '40', 'red', '1', null, null, '2018-07-10 15:18:15', '100004', '2018-07-10 15:18:15', '100004', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100031', 'SINOVATIO_9012-10', 'SINOVATIO', '槽位-10', '10', '100016', 'image', '52', '398', '359', '40', 'red', '1', null, null, '2018-07-10 15:18:15', '100004', '2018-07-10 15:18:15', '100004', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100032', 'SINOVATIO_9012-11', 'SINOVATIO', '槽位-11', '11', '100016', 'image', '52', '438', '359', '40', 'red', '1', null, null, '2018-07-10 15:18:15', '100004', '2018-07-10 15:18:15', '100004', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100033', 'SINOVATIO_9012-12', 'SINOVATIO', '槽位-12', '12', '100016', 'image', '52', '478', '359', '40', 'red', '1', null, null, '2018-07-10 15:18:15', '100004', '2018-07-10 15:18:15', '100004', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100034', 'SINOVATIO_9012-13', 'SINOVATIO', '槽位-13', '13', '100016', 'image', '52', '518', '359', '40', 'red', '1', null, null, '2018-07-10 15:18:15', '100004', '2018-07-10 15:18:15', '100004', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100035', 'SINOVATIO_9012-14', 'SINOVATIO', '槽位-14', '14', '100016', 'image', '52', '558', '359', '40', 'red', '1', null, null, '2018-07-10 15:18:15', '100004', '2018-07-10 15:18:15', '100004', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100036', 'SINOVATIO_9012-2LIGHT', 'SINOVATIO', '', '1', '0', 'image', '35', '35', '349', '43', 'red', '1', 'SINOVATIO_9012-2LIGHT.png', 'SINOVATIO_9012-2LIGHT', '2018-07-10 15:23:11', '100004', '2018-07-10 17:27:08', '1', '', '', '', '', '', '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100037', 'SINOVATIO_9012-4LIGHT', 'SINOVATIO', '', '1', '0', 'image', '35', '35', '349', '43', 'red', '1', 'SINOVATIO_9012-4LIGHT.png', 'SINOVATIO_9012-4LIGHT', '2018-07-10 15:24:01', '100004', '2018-07-10 17:27:21', '1', '', '', '', '', '', '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100042', 'SINOVATIO_9012-10g', 'SINOVATIO', '', '1', '0', 'image', '35', '35', '349', '42', 'red', '1', 'SINOVATIO_9012-10g.png', 'SINOVATIO_9012-10g', '2018-07-10 16:00:19', '1', '2018-07-10 17:27:32', '1', '', '', '', '', '', '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100043', 'SINOVATIO_9012-4LIGHT-1', 'SINOVATIO', '-1', '1', '100037', 'image', '310', '21', '10', '10', 'red', '1', null, null, '2018-07-10 16:02:30', '1', '2018-07-10 16:02:30', '1', null, null, null, null, '', '3', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100044', 'SINOVATIO_9012-4LIGHT-2', 'SINOVATIO', '-2', '2', '100037', 'image', '322', '21', '10', '10', 'red', '1', null, null, '2018-07-10 16:02:30', '1', '2018-07-10 16:02:30', '1', null, null, null, null, '', '3', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100045', 'SINOVATIO_9012-100g', 'SINOVATIO', '', '1', '0', 'image', '35', '35', '349', '42', 'red', '1', 'SINOVATIO_9012-100g.png', 'SINOVATIO_9012-100g', '2018-07-10 16:03:27', '1', '2018-07-10 17:27:43', '1', '', '', '', '', '', '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100047', 'SINOVATIO_9012-2LIGHT-1', 'SINOVATIO', '-1', '1', '100036', 'image', '310', '22', '11', '11', 'red', '1', null, null, '2018-07-10 16:06:03', '1', '2018-07-10 16:06:03', '1', null, null, null, null, '', '3', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100048', 'SINOVATIO_9012-2LIGHT-2', 'SINOVATIO', '-2', '2', '100036', 'image', '323', '22', '11', '11', 'red', '1', null, null, '2018-07-10 16:06:03', '1', '2018-07-10 16:06:03', '1', null, null, null, null, '', '3', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100049', '31231', 'DPtech', '', '3123213213', '1', 'image', '35', '35', null, null, 'red', '1', null, '31231', '2018-07-10 16:03:35', '100002', '2018-07-10 16:03:35', '100002', 'DI_TEST', 't_number', 't_date', '>', '2', '2', '0', '1', '2', '0', '0');
INSERT INTO `device_type_info` VALUES ('100050', 'FF-N3100-1', 'SUGON', '-1', '1', '100000', 'image', '21', '404', '397', '41', 'red', '1', null, null, '2018-07-10 16:26:50', '1', '2018-07-10 16:26:50', '1', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100051', 'FF-N3100-2', 'SUGON', '-2', '2', '100000', 'image', '21', '362', '397', '41', 'red', '1', null, null, '2018-07-10 16:26:50', '1', '2018-07-10 16:26:50', '1', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100052', 'FF-N3100-3', 'SUGON', '-3', '3', '100000', 'image', '21', '321', '397', '41', 'red', '1', null, null, '2018-07-10 16:26:50', '1', '2018-07-10 16:26:50', '1', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100053', 'FF-N3100-4', 'SUGON', '-4', '4', '100000', 'image', '21', '285', '397', '31', 'red', '1', null, null, '2018-07-10 16:26:50', '1', '2018-07-10 16:26:50', '1', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100054', 'FF-N3100-5', 'SUGON', '-5', '5', '100000', 'image', '21', '253', '397', '31', 'red', '1', null, null, '2018-07-10 16:26:50', '1', '2018-07-10 16:26:50', '1', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100055', 'FF-N3100-6', 'SUGON', '-6', '6', '100000', 'image', '21', '210', '397', '41', 'red', '1', null, null, '2018-07-10 16:26:50', '1', '2018-07-10 16:26:50', '1', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100056', 'FF-N3100-7', 'SUGON', '-7', '7', '100000', 'image', '21', '170', '397', '41', 'red', '1', null, null, '2018-07-10 16:26:50', '1', '2018-07-10 16:26:50', '1', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100057', 'FF-N3100-8', 'SUGON', '-8', '8', '100000', 'image', '21', '130', '397', '41', 'red', '1', null, null, '2018-07-10 16:26:50', '1', '2018-07-10 16:26:50', '1', null, null, null, null, '', '2', '0', '0', '1', '1', '0');
INSERT INTO `device_type_info` VALUES ('100058', 'FF-N3100-NBLANK', 'SUGON', '', '1', '0', 'image', '35', '35', '397', '31', 'red', '1', 'FF-N3100-NBLANK.png', 'FF-N3100-NBLANK', '2018-07-10 16:31:11', '1', '2018-07-10 17:29:22', '1', '', '', '', '', '', '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100059', 'FF-N3100-NMANAGER', 'SUGON', '', '1', '0', 'image', '35', '35', '397', '31', 'red', '1', 'FF-N3100-NMANAGER.png', 'FF-N3100-NMANAGER', '2018-07-10 16:31:34', '1', '2018-07-10 17:28:18', '1', '', '', '', '', '', '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100060', 'FF-N3100-W10G_BUSINESS', 'SUGON', '', '1', '0', 'image', '35', '35', '397', '41', 'red', '1', 'FF-N3100-W10G_BUSINESS.png', 'FF-N3100-W10G_BUSINESS', '2018-07-10 16:32:10', '1', '2018-07-10 17:28:29', '1', '', '', '', '', '', '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100061', 'FF-N3100-W100G_BUSINESS', 'SUGON', '', '1', '0', 'image', '35', '35', '397', '41', 'red', '1', 'FF-N3100-W100G_BUSINESS.png', 'FF-N3100-W100G_BUSINESS', '2018-07-10 16:32:38', '1', '2018-07-10 17:28:38', '1', '', '', '', '', '', '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100062', 'FF-N3100-WBLANK', 'SUGON', '', '1', '0', 'image', '35', '35', '397', '41', 'red', '1', 'FF-N3100-WBLANK.png', 'FF-N3100-WBLANK', '2018-07-10 16:33:01', '1', '2018-07-10 17:29:01', '1', '', '', '', '', '', '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100063', 'FF-N3100-WPROTECT', 'SUGON', '', '1', '0', 'image', '35', '35', '397', '41', 'red', '1', 'FF-N3100-WPROTECT.png', 'FF-N3100-WPROTECT', '2018-07-10 16:33:21', '1', '2018-07-10 17:29:12', '1', '', '', '', '', '', '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100064', 'FF-N3100-WSWITCH', 'SUGON', '', '1', '0', 'image', '35', '35', '397', '41', 'red', '1', 'FF-N3100-WSWITCH.png', 'FF-N3100-WSWITCH', '2018-07-10 16:33:38', '1', '2018-07-10 17:28:03', '1', '', '', '', '', '', '2', '0', '0', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100065', 'FF-N3100-W100G_BUSINESS-1-2', 'SUGON', 'W100G_BUSINESS-1--2', '2', '100061', 'image', '56', '3', '15', '10', 'red', '1', null, 'xgei_[X]/1/[Y]', '2018-07-11 17:59:06', '1', '2018-07-11 17:59:06', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100066', 'FF-N3100-W100G_BUSINESS-1-3', 'SUGON', 'W100G_BUSINESS-1--3', '3', '100061', 'image', '56', '17', '15', '12', 'red', '1', null, 'xgei_[X]/1/[Y]', '2018-07-11 17:59:06', '1', '2018-07-11 17:59:06', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100067', 'FF-N3100-W100G_BUSINESS-1-4', 'SUGON', 'W100G_BUSINESS-1--4', '4', '100061', 'image', '71', '4', '13', '10', 'red', '1', null, 'xgei_[X]/1/[Y]', '2018-07-11 17:59:06', '1', '2018-07-11 17:59:06', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100068', 'FF-N3100-W100G_BUSINESS-1-5', 'SUGON', 'W100G_BUSINESS-1--5', '5', '100061', 'image', '71', '16', '14', '11', 'red', '1', null, 'xgei_[X]/1/[Y]', '2018-07-11 17:59:06', '1', '2018-07-11 17:59:06', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100069', 'FF-N3100-W100G_BUSINESS-1-6', 'SUGON', 'W100G_BUSINESS-1--6', '6', '100061', 'image', '85', '4', '13', '9', 'red', '1', null, 'xgei_[X]/1/[Y]', '2018-07-11 17:59:06', '1', '2018-07-11 17:59:06', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100070', 'FF-N3100-W100G_BUSINESS-1-7', 'SUGON', 'W100G_BUSINESS-1--7', '7', '100061', 'image', '85', '17', '14', '10', 'red', '1', null, 'xgei_[X]/1/[Y]', '2018-07-11 17:59:06', '1', '2018-07-11 17:59:06', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100071', 'FF-N3100-W100G_BUSINESS-1-8', 'SUGON', 'W100G_BUSINESS-1--8', '8', '100061', 'image', '99', '3', '14', '11', 'red', '1', null, 'xgei_[X]/1/[Y]', '2018-07-11 17:59:06', '1', '2018-07-11 17:59:06', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100072', 'FF-N3100-W100G_BUSINESS-1-9', 'SUGON', 'W100G_BUSINESS-1--9', '9', '100061', 'image', '100', '16', '13', '11', 'red', '1', null, 'xgei_[X]/1/[Y]', '2018-07-11 17:59:06', '1', '2018-07-11 17:59:06', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100073', 'FF-N3100-W100G_BUSINESS-1-10', 'SUGON', 'W100G_BUSINESS-1--10', '10', '100061', 'image', '114', '4', '14', '11', 'red', '1', null, 'xgei_[X]/1/[Y]', '2018-07-11 17:59:06', '1', '2018-07-11 17:59:06', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100074', 'FF-N3100-W100G_BUSINESS-1-11', 'SUGON', 'W100G_BUSINESS-1--11', '11', '100061', 'image', '113', '15', '15', '14', 'red', '1', null, 'xgei_[X]/1/[Y]', '2018-07-11 17:59:06', '1', '2018-07-11 17:59:06', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100075', 'FF-N3100-W100G_BUSINESS-1-12', 'SUGON', 'W100G_BUSINESS-1--12', '12', '100061', 'image', '127', '3', '14', '13', 'red', '1', null, 'xgei_[X]/1/[Y]', '2018-07-11 17:59:06', '1', '2018-07-11 17:59:06', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100076', 'FF-N3100-W100G_BUSINESS-1-13', 'SUGON', 'W100G_BUSINESS-1--13', '13', '100061', 'image', '129', '18', '13', '9', 'red', '1', null, 'xgei_[X]/1/[Y]', '2018-07-11 17:59:06', '1', '2018-07-11 17:59:06', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100077', 'FF-N3100-W100G_BUSINESS-2-2', 'SUGON', 'W100G_BUSINESS-2--2', '2', '100061', 'image', '283', '4', '13', '9', 'red', '1', null, 'xgei_[X]/2/[Y]', '2018-07-11 18:08:21', '1', '2018-07-11 18:08:21', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100078', 'FF-N3100-W100G_BUSINESS-2-3', 'SUGON', 'W100G_BUSINESS-2--3', '3', '100061', 'image', '283', '17', '13', '10', 'red', '1', null, 'xgei_[X]/2/[Y]', '2018-07-11 18:08:21', '1', '2018-07-11 18:08:21', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100079', 'FF-N3100-W100G_BUSINESS-2-4', 'SUGON', 'W100G_BUSINESS-2--4', '4', '100061', 'image', '299', '3', '12', '11', 'red', '1', null, 'xgei_[X]/2/[Y]', '2018-07-11 18:08:21', '1', '2018-07-11 18:08:21', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100080', 'FF-N3100-W100G_BUSINESS-2-5', 'SUGON', 'W100G_BUSINESS-2--5', '5', '100061', 'image', '297', '16', '14', '13', 'red', '1', null, 'xgei_[X]/2/[Y]', '2018-07-11 18:08:21', '1', '2018-07-11 18:08:21', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100081', 'FF-N3100-W100G_BUSINESS-2-6', 'SUGON', 'W100G_BUSINESS-2--6', '6', '100061', 'image', '310', '3', '14', '11', 'red', '1', null, 'xgei_[X]/2/[Y]', '2018-07-11 18:08:21', '1', '2018-07-11 18:08:21', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100082', 'FF-N3100-W100G_BUSINESS-2-7', 'SUGON', 'W100G_BUSINESS-2--7', '7', '100061', 'image', '310', '16', '14', '11', 'red', '1', null, 'xgei_[X]/2/[Y]', '2018-07-11 18:08:21', '1', '2018-07-11 18:08:21', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100083', 'FF-N3100-W100G_BUSINESS-2-8', 'SUGON', 'W100G_BUSINESS-2--8', '8', '100061', 'image', '325', '4', '13', '10', 'red', '1', null, 'xgei_[X]/2/[Y]', '2018-07-11 18:08:21', '1', '2018-07-11 18:08:21', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100084', 'FF-N3100-W100G_BUSINESS-2-9', 'SUGON', 'W100G_BUSINESS-2--9', '9', '100061', 'image', '324', '15', '14', '14', 'red', '1', null, 'xgei_[X]/2/[Y]', '2018-07-11 18:08:21', '1', '2018-07-11 18:08:21', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100085', 'FF-N3100-W100G_BUSINESS-2-10', 'SUGON', 'W100G_BUSINESS-2--10', '10', '100061', 'image', '340', '3', '13', '11', 'red', '1', null, 'xgei_[X]/2/[Y]', '2018-07-11 18:08:21', '1', '2018-07-11 18:08:21', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100086', 'FF-N3100-W100G_BUSINESS-2-11', 'SUGON', 'W100G_BUSINESS-2--11', '11', '100061', 'image', '340', '16', '14', '11', 'red', '1', null, 'xgei_[X]/2/[Y]', '2018-07-11 18:08:21', '1', '2018-07-11 18:08:21', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100087', 'FF-N3100-W100G_BUSINESS-2-12', 'SUGON', 'W100G_BUSINESS-2--12', '12', '100061', 'image', '353', '3', '16', '12', 'red', '1', null, 'xgei_[X]/2/[Y]', '2018-07-11 18:08:21', '1', '2018-07-11 18:08:21', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');
INSERT INTO `device_type_info` VALUES ('100088', 'FF-N3100-W100G_BUSINESS-2-13', 'SUGON', 'W100G_BUSINESS-2--13', '13', '100061', 'image', '353', '15', '16', '11', 'red', '1', null, 'xgei_[X]/2/[Y]', '2018-07-11 18:08:21', '1', '2018-07-11 18:08:21', '1', 'DI_SWITCHPORT', 'ifindex', '', '', '', '3', '1', '1', '1', '0', '0');



-- ----------------------------
-- Records of dictionary_table
-- ----------------------------


-- ----------------------------
-- Records of di_base_info
-- ----------------------------


-- ----------------------------
-- Records of di_dpboardstatusentry
-- ----------------------------



-- ----------------------------
-- Records of di_dpslotentry
-- ----------------------------



-- ----------------------------
-- Records of di_dpsystemfanentry
-- ----------------------------



-- ----------------------------
-- Records of di_dpsystempowerentry
-- ----------------------------



-- ----------------------------
-- Records of di_dpsystemstatus
-- ----------------------------



-- ----------------------------
-- Records of di_ifxtable
-- ----------------------------



-- ----------------------------
-- Records of di_switchport
-- ----------------------------



-- ----------------------------
-- Records of di_system
-- ----------------------------



-- ----------------------------
-- Records of di_systeminfo
-- ----------------------------



-- ----------------------------
-- Records of di_systeminfo_disk
-- ----------------------------



-- ----------------------------
-- Records of di_systeminfo_net
-- ----------------------------



-- ----------------------------
-- Records of email_table
-- ----------------------------


-- ----------------------------
-- Records of event_record_library
-- ----------------------------



-- ----------------------------
-- Records of flow_audit_rz
-- ----------------------------



-- ----------------------------
-- Records of gorup_system_table
-- ----------------------------



-- ----------------------------
-- Records of img_url
-- ----------------------------



-- ----------------------------
-- Records of loopmission_state_table
-- ----------------------------



-- ----------------------------
-- Records of metadata
-- ----------------------------
INSERT INTO `metadata` VALUES ('1', '0', 'DI_SYSTEMINFO', null, 'HOST_NAME', 'i18n_metadata.HOST_NAME.filed_comments_n81i', 'VARCHAR2(200)', '2013-01-31 00:00:00', '1', '0', null, null, '1', '1', null, null, null, null);
INSERT INTO `metadata` VALUES ('2', '0', 'DI_SYSTEMINFO', null, 'OPERATE_SYSTEM', 'i18n_metadata.OPERATE_SYSTEM.filed_comments_n81i', 'VARCHAR2(200)', '2013-01-31 00:00:00', '1', '0', null, null, '1', '2', null, null, null, null);
INSERT INTO `metadata` VALUES ('3', '0', 'DI_SYSTEMINFO', null, 'CPU_CNT', 'i18n_metadata.CPU_CNT.filed_comments_n81i', 'Number', '2013-01-31 00:00:00', '1', '0', null, null, '1', '3', null, null, null, null);
INSERT INTO `metadata` VALUES ('4', '0', 'DI_SYSTEMINFO', null, 'CPU_MHZ', 'i18n_metadata.CPU_MHZ.filed_comments_n81i', 'Number', '2013-01-31 00:00:00', '1', '0', null, null, '1', '4', null, null, '1', null);
INSERT INTO `metadata` VALUES ('5', '0', 'DI_SYSTEMINFO', null, 'MEMORY_SIZE', 'i18n_metadata.MEMORY_SIZE.filed_comments_n81i', 'Number', '2013-01-31 00:00:00', '1', '0', null, null, '1', '5', null, null, null, null);
INSERT INTO `metadata` VALUES ('6', '0', 'DI_SYSTEMINFO', null, 'SWAP_SIZE', 'i18n_metadata.SWAP_SIZE.filed_comments_n81i', 'Number', '2013-01-31 00:00:00', '1', '0', null, null, '1', '6', null, null, null, null);
INSERT INTO `metadata` VALUES ('7', '0', 'DI_SYSTEMINFO', null, 'DISK_SIZE', 'i18n_metadata.DISK_SIZE.filed_comments_n81i', 'Number', '2013-01-31 00:00:00', '1', '0', null, null, '1', '7', null, null, null, null);
INSERT INTO `metadata` VALUES ('8', '0', 'DI_SYSTEMINFO', null, 'NET_CNT', 'i18n_metadata.NET_CNT.filed_comments_n81i', 'Number', '2013-01-31 00:00:00', '1', '0', null, null, '1', '8', null, null, null, null);
INSERT INTO `metadata` VALUES ('9', '1', 'DETECT_INFO_CPU', null, 'USER_USED_CPU_PERC', 'i18n_metadata.USER_USED_CPU_PERC.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '0', '2', null, null, '1', null);
INSERT INTO `metadata` VALUES ('10', '1', 'DETECT_INFO_CPU', null, 'SYS_USED_CPU_PERC', 'i18n_metadata.SYS_USED_CPU_PERC.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '0', '3', null, null, '1', null);
INSERT INTO `metadata` VALUES ('11', '1', 'DETECT_INFO_CPU', null, 'WAIT_CPU_PERC', 'i18n_metadata.WAIT_CPU_PERC.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '0', '4', null, null, '1', null);
INSERT INTO `metadata` VALUES ('12', '1', 'DETECT_INFO_CPU', null, 'NICE_PERC', 'i18n_metadata.NICE_PERC.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '0', '5', null, null, '1', null);
INSERT INTO `metadata` VALUES ('13', '1', 'DETECT_INFO_CPU', null, 'FREE_CPU_PERC', 'i18n_metadata.FREE_CPU_PERC.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '0', '6', null, null, '1', null);
INSERT INTO `metadata` VALUES ('14', '1', 'DETECT_INFO_CPU', null, 'TOTAL_USED_PERC', 'i18n_metadata.TOTAL_USED_PERC.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '0', '7', null, null, '1', null);
INSERT INTO `metadata` VALUES ('15', '1', 'DETECT_INFO_CPU', null, 'CPU_MHZ', 'i18n_metadata.CPU_MHZ.filed_comments_n81i', 'Number', '2013-01-23 00:00:00', '1', '0', null, null, '1', '8', null, null, null, null);
INSERT INTO `metadata` VALUES ('16', '1', 'DETECT_INFO_CPU', null, 'CPU_NAME', 'i18n_metadata.CPU_NAME.filed_comments_n81i', 'VARCHAR2(100)', '2013-01-23 00:00:00', '1', '0', null, null, '1', '1', null, null, '0', null);
INSERT INTO `metadata` VALUES ('17', '2', 'DETECT_INFO_MEMORY', null, 'SIZE_STOREDINPAGING_FILES', 'i18n_metadata.SIZE_STOREDINPAGING_FILES.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '1', null, null, '1', null);
INSERT INTO `metadata` VALUES ('18', '2', 'DETECT_INFO_MEMORY', null, 'FREE_SPACE_INPAGING_FILES', 'i18n_metadata.FREE_SPACE_INPAGING_FILES.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '0', '2', null, null, '1', null);
INSERT INTO `metadata` VALUES ('19', '2', 'DETECT_INFO_MEMORY', null, 'TOTAL_MEMORY_SIZE', 'i18n_metadata.TOTAL_MEMORY_SIZE.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '3', null, null, '1', null);
INSERT INTO `metadata` VALUES ('20', '2', 'DETECT_INFO_MEMORY', null, 'USED_MEMORY_SIZE', 'i18n_metadata.USED_MEMORY_SIZE.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '4', null, null, '1', null);
INSERT INTO `metadata` VALUES ('21', '2', 'DETECT_INFO_MEMORY', null, 'FREE_MEMORY_SIZE', 'i18n_metadata.FREE_MEMORY_SIZE.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '5', null, null, '1', null);
INSERT INTO `metadata` VALUES ('22', '2', 'DETECT_INFO_MEMORY', null, 'USED_MEMORY_PERC', 'i18n_metadata.USED_MEMORY_PERC.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '0', '6', null, null, '1', null);
INSERT INTO `metadata` VALUES ('23', '3', 'DETECT_INFO_DISK', null, 'DISK_RANGE', 'i18n_metadata.DISK_RANGE.filed_comments_n81i', 'VARCHAR2(50)', null, '1', '0', null, '0', '1', '1', null, null, '0', null);
INSERT INTO `metadata` VALUES ('24', '3', 'DETECT_INFO_DISK', null, 'TOTAL_DISK_SIZE', 'i18n_metadata.TOTAL_DISK_SIZE.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '2', null, null, '1', null);
INSERT INTO `metadata` VALUES ('25', '3', 'DETECT_INFO_DISK', null, 'FREE_DISK_SIZE', 'i18n_metadata.FREE_DISK_SIZE.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '0', '3', null, null, '1', null);
INSERT INTO `metadata` VALUES ('26', '3', 'DETECT_INFO_DISK', null, 'USED_DISK_PERC', 'i18n_metadata.USED_DISK_PERC.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '0', '4', null, null, '1', null);
INSERT INTO `metadata` VALUES ('27', '3', 'DETECT_INFO_DISK', null, 'DISK_ISWRITE', 'i18n_metadata.DISK_ISWRITE.filed_comments_n81i', 'NUMBER', '2013-03-28 00:00:00', '1', '0', null, '0', '1', '5', null, null, '1', null);
INSERT INTO `metadata` VALUES ('28', '4', 'DETECT_INFO_NETDATA', null, 'RX_PACKETS', 'i18n_metadata.RX_PACKETS.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '2', null, null, '1', null);
INSERT INTO `metadata` VALUES ('29', '4', 'DETECT_INFO_NETDATA', null, 'TX_PACKETS', 'i18n_metadata.TX_PACKETS.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '3', null, null, '1', null);
INSERT INTO `metadata` VALUES ('30', '4', 'DETECT_INFO_NETDATA', null, 'RX_BYTES', 'i18n_metadata.RX_BYTES.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '4', null, null, '1', null);
INSERT INTO `metadata` VALUES ('31', '4', 'DETECT_INFO_NETDATA', null, 'TX_BYTES', 'i18n_metadata.TX_BYTES.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '5', null, null, '1', null);
INSERT INTO `metadata` VALUES ('32', '4', 'DETECT_INFO_NETDATA', null, 'RX_ERRORS', 'i18n_metadata.RX_ERRORS.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '6', null, null, '1', null);
INSERT INTO `metadata` VALUES ('33', '4', 'DETECT_INFO_NETDATA', null, 'TX_ERRORS', 'i18n_metadata.TX_ERRORS.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '7', null, null, '1', null);
INSERT INTO `metadata` VALUES ('34', '4', 'DETECT_INFO_NETDATA', null, 'RX_DROPPED', 'i18n_metadata.RX_DROPPED.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '8', null, null, '1', null);
INSERT INTO `metadata` VALUES ('35', '4', 'DETECT_INFO_NETDATA', null, 'TX_DROPPED', 'i18n_metadata.TX_DROPPED.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '9', null, null, '1', null);
INSERT INTO `metadata` VALUES ('36', '4', 'DETECT_INFO_NETDATA', null, 'SPEED', 'i18n_metadata.SPEED.filed_comments_n81i', 'Number', '2013-01-22 00:00:00', '1', '0', null, null, '1', '10', null, null, null, null);
INSERT INTO `metadata` VALUES ('37', '4', 'DETECT_INFO_NETDATA', null, 'RX_BPS', 'i18n_metadata.RX_BPS.filed_comments_n81i', 'Number', '2013-01-22 00:00:00', '1', '0', null, null, '0', '11', null, null, null, null);
INSERT INTO `metadata` VALUES ('38', '4', 'DETECT_INFO_NETDATA', null, 'TX_BPS', 'i18n_metadata.TX_BPS.filed_comments_n81i', 'Number', '2013-01-22 00:00:00', '1', '0', null, null, '0', '12', null, null, null, null);
INSERT INTO `metadata` VALUES ('39', '4', 'DETECT_INFO_NETDATA', null, 'RX_PPS', 'i18n_metadata.RX_PPS.filed_comments_n81i', 'Number', '2013-01-22 00:00:00', '1', '0', null, null, '0', '13', null, null, '1', null);
INSERT INTO `metadata` VALUES ('40', '4', 'DETECT_INFO_NETDATA', null, 'TX_PPS', 'i18n_metadata.TX_PPS.filed_comments_n81i', 'Number', '2013-01-22 00:00:00', '1', '0', null, null, '0', '14', null, null, null, null);
INSERT INTO `metadata` VALUES ('41', '4', 'DETECT_INFO_NETDATA', null, 'NAME', 'i18n_metadata.NAME.filed_comments_n81i', 'VARCHAR2(200)', '2013-01-22 00:00:00', '1', '0', null, null, '1', '1', null, null, '0', null);
INSERT INTO `metadata` VALUES ('42', '4', 'DETECT_INFO_NETDATA', null, 'RX_ERRORS_PERC', 'i18n_metadata.RX_ERRORS_PERC.filed_comments_n81i', 'Number', '2013-01-23 00:00:00', '1', '0', null, null, '1', '15', null, null, null, null);
INSERT INTO `metadata` VALUES ('43', '4', 'DETECT_INFO_NETDATA', null, 'TX_ERRORS_PERC', 'i18n_metadata.TX_ERRORS_PERC.filed_comments_n81i', 'Number', '2013-01-23 00:00:00', '1', '0', null, null, '1', '16', null, null, null, null);
INSERT INTO `metadata` VALUES ('44', '4', 'DETECT_INFO_NETDATA', null, 'RX_DROP_PERC', 'i18n_metadata.RX_DROP_PERC.filed_comments_n81i', 'Number', '2013-01-23 00:00:00', '1', '0', null, null, '1', '17', null, null, null, null);
INSERT INTO `metadata` VALUES ('45', '4', 'DETECT_INFO_NETDATA', null, 'TX_DROP_PERC', 'i18n_metadata.TX_DROP_PERC.filed_comments_n81i', 'Number', '2013-01-23 00:00:00', '1', '0', null, null, '1', '18', null, null, null, null);
INSERT INTO `metadata` VALUES ('46', '5', 'DETECT_INFO_SYSTEM_DATE', null, 'SERVICE_DATE', 'i18n_metadata.SERVICE_DATE.filed_comments_n81i', 'DATE', null, '1', '0', null, '0', '1', '1', null, null, '1', null);
INSERT INTO `metadata` VALUES ('47', '5', 'DETECT_INFO_SYSTEM_DATE', null, 'DETECT_DATE', 'i18n_metadata.DETECT_DATE.filed_comments_n81i', 'DATE', null, '1', '0', null, '0', '1', '2', null, null, '1', null);
INSERT INTO `metadata` VALUES ('48', '5', 'DETECT_INFO_SYSTEM_DATE', null, 'TIME_DELAY', 'i18n_metadata.TIME_DELAY.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '3', null, null, '1', null);
INSERT INTO `metadata` VALUES ('49', '6', 'DETECT_INFO_PING', null, 'PACKETS_SEND', 'i18n_metadata.PACKETS_SEND.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '1', null, null, '1', null);
INSERT INTO `metadata` VALUES ('50', '6', 'DETECT_INFO_PING', null, 'PACKETS_RECEIVED', 'i18n_metadata.PACKETS_RECEIVED.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '2', null, null, '1', null);
INSERT INTO `metadata` VALUES ('51', '6', 'DETECT_INFO_PING', null, 'PACKETS_LOST', 'i18n_metadata.PACKETS_LOST.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '3', null, null, '1', null);
INSERT INTO `metadata` VALUES ('52', '6', 'DETECT_INFO_PING', null, 'PACKETS_LOST_RATE', 'i18n_metadata.PACKETS_LOST_RATE.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '0', '4', null, null, '1', null);
INSERT INTO `metadata` VALUES ('53', '6', 'DETECT_INFO_PING', null, 'TIME_CONSUMING_MIN', 'i18n_metadata.TIME_CONSUMING_MIN.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '5', null, null, '1', null);
INSERT INTO `metadata` VALUES ('54', '6', 'DETECT_INFO_PING', null, 'TIME_CONSUMING_MAX', 'i18n_metadata.TIME_CONSUMING_MAX.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '6', null, null, '1', null);
INSERT INTO `metadata` VALUES ('55', '6', 'DETECT_INFO_PING', null, 'TIME_CONSUMING_AVER', 'i18n_metadata.TIME_CONSUMING_AVER.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '0', '7', null, null, '1', null);
INSERT INTO `metadata` VALUES ('56', '7', 'DELECT_INFO_NMSC', null, 'SEND_INFO', 'i18n_metadata.SEND_INFO.filed_comments_n81i', 'VARCHAR2(100)', null, '1', '0', null, '0', '1', '1', null, null, '1', null);
INSERT INTO `metadata` VALUES ('57', '7', 'DELECT_INFO_NMSC', null, 'RETURN_INFO', 'i18n_metadata.RETURN_INFO.filed_comments_n81i', 'VARCHAR2(100)', null, '1', '0', null, '0', '1', '2', null, null, '1', null);
INSERT INTO `metadata` VALUES ('58', '7', 'DELECT_INFO_NMSC', null, 'IS_IDENTICAL', 'i18n_metadata.IS_IDENTICAL.filed_comments_n81i', 'NUMBER', null, '1', '0', null, '0', '0', '3', null, null, '1', '161');
INSERT INTO `metadata` VALUES ('59', '7', 'DELECT_INFO_NMSC', null, 'SEND_TIME', 'i18n_metadata.SEND_TIME.filed_comments_n81i', 'DATE', null, '1', '0', null, '0', '1', '4', null, null, '1', null);
INSERT INTO `metadata` VALUES ('60', '7', 'DELECT_INFO_NMSC', null, 'RETURN_TIME', 'i18n_metadata.RETURN_TIME.filed_comments_n81i', 'DATE', null, '1', '0', null, '0', '1', '5', null, null, '1', null);
INSERT INTO `metadata` VALUES ('61', '7', 'DELECT_INFO_NMSC', null, 'DELAY_TIME', 'i18n_metadata.DELAY_TIME.filed_comments_n81i', 'NUMBER', null, '1', '0', null, '0', '1', '6', null, null, '1', null);
INSERT INTO `metadata` VALUES ('62', '8', 'DETECT_INFO_PROCESS', null, 'CPU_USED_PERC', 'i18n_metadata.CPU_USED_PERC.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '0', '1', null, null, '1', null);
INSERT INTO `metadata` VALUES ('63', '8', 'DETECT_INFO_PROCESS', null, 'MEM_USED_PERC', 'i18n_metadata.MEM_USED_PERC.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '0', '2', null, null, '1', null);
INSERT INTO `metadata` VALUES ('64', '8', 'DETECT_INFO_PROCESS', null, 'PRO_START_TIME', 'i18n_metadata.PRO_START_TIME.filed_comments_n81i', 'DATE', null, '1', '0', null, '0', '1', '3', null, null, '1', null);
INSERT INTO `metadata` VALUES ('65', '8', 'DETECT_INFO_PROCESS', null, 'PROC_STATE', 'i18n_metadata.PROC_STATE.filed_comments_n81i', 'VARCHAR2(2)', null, '1', '0', null, '0', '1', '4', null, null, '1', null);
INSERT INTO `metadata` VALUES ('66', '8', 'DETECT_INFO_PROCESS', null, 'PROC_PRIORITY', 'i18n_metadata.PROC_PRIORITY.filed_comments_n81i', 'Number', null, '1', '0', null, '0', '1', '5', null, null, '1', null);
INSERT INTO `metadata` VALUES ('67', '9', 'DI_SYSTEM', 'i18n_metadata.sysDescr.table_comments_n81i', 'sysDescr', 'sysDescr', 'VARCHAR2(400)', null, '1', '0', null, null, '1', '1', null, '1.3.6.1.2.1.1.1', '1', null);
INSERT INTO `metadata` VALUES ('68', '9', 'DI_SYSTEM', 'i18n_metadata.sysObjectID.table_comments_n81i', 'sysObjectID', 'sysObjectID', 'VARCHAR2(400)', null, '1', '0', null, null, '1', '2', null, '1.3.6.1.2.1.1.2', '1', null);
INSERT INTO `metadata` VALUES ('69', '9', 'DI_SYSTEM', 'i18n_metadata.sysUpTime.table_comments_n81i', 'sysUpTime', 'sysUpTime', 'VARCHAR2(400)', null, '1', '0', null, null, '1', '3', null, '1.3.6.1.2.1.1.3', '1', null);
INSERT INTO `metadata` VALUES ('70', '9', 'DI_SYSTEM', 'i18n_metadata.sysContact.table_comments_n81i', 'sysContact', 'sysContact', 'VARCHAR2(400)', null, '1', '0', null, null, '1', '4', null, '1.3.6.1.2.1.1.4', '1', null);
INSERT INTO `metadata` VALUES ('71', '9', 'DI_SYSTEM', 'i18n_metadata.sysName.table_comments_n81i', 'sysName', 'sysName', 'VARCHAR2(400)', null, '1', '0', null, null, '1', '5', null, '1.3.6.1.2.1.1.5', '1', null);
INSERT INTO `metadata` VALUES ('72', '9', 'DI_SYSTEM', 'i18n_metadata.sysLocation.table_comments_n81i', 'sysLocation', 'sysLocation', 'VARCHAR2(400)', null, '1', '0', null, null, '1', '6', null, '1.3.6.1.2.1.1.6', '1', null);
INSERT INTO `metadata` VALUES ('73', '9', 'DI_SYSTEM', 'i18n_metadata.sysServices.table_comments_n81i', 'sysServices', 'sysServices', 'VARCHAR2(400)', null, '1', '0', null, null, '0', '7', null, '1.3.6.1.2.1.1.7', '1', null);
INSERT INTO `metadata` VALUES ('74', '10', 'DI_SWITCHPORT', null, 'ifIndex', 'i18n_metadata.ifIndex.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '1', null, '1.3.6.1.2.1.2.2.1.1', '1', null);
INSERT INTO `metadata` VALUES ('75', '10', 'DI_SWITCHPORT', null, 'ifDescr', 'i18n_metadata.ifDescr.filed_comments_n81i', 'VARCHAR2(400)', null, '1', '0', null, null, '1', '2', null, '1.3.6.1.2.1.2.2.1.2', '0', null);
INSERT INTO `metadata` VALUES ('76', '10', 'DI_SWITCHPORT', null, 'ifType', 'i18n_metadata.ifType.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '3', null, '1.3.6.1.2.1.2.2.1.3', '1', null);
INSERT INTO `metadata` VALUES ('77', '10', 'DI_SWITCHPORT', null, 'ifMtu', 'ifMtu', 'NUMBER', null, '1', '0', null, null, '1', '4', null, '1.3.6.1.2.1.2.2.1.4', '1', null);
INSERT INTO `metadata` VALUES ('78', '10', 'DI_SWITCHPORT', null, 'ifSpeed', 'i18n_metadata.ifSpeed.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '5', null, '1.3.6.1.2.1.2.2.1.5', '1', null);
INSERT INTO `metadata` VALUES ('79', '10', 'DI_SWITCHPORT', null, 'ifPhysAddress', 'i18n_metadata.ifPhysAddress.filed_comments_n81i', 'VARCHAR2(400)', null, '1', '0', null, null, '1', '6', null, '1.3.6.1.2.1.2.2.1.6', '1', null);
INSERT INTO `metadata` VALUES ('80', '10', 'DI_SWITCHPORT', null, 'ifAdminStatus', 'i18n_metadata.ifAdminStatus.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '7', null, '1.3.6.1.2.1.2.2.1.7', '1', null);
INSERT INTO `metadata` VALUES ('81', '10', 'DI_SWITCHPORT', null, 'ifOperStatus', 'i18n_metadata.ifOperStatus.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '8', null, '1.3.6.1.2.1.2.2.1.8', '1', null);
INSERT INTO `metadata` VALUES ('82', '10', 'DI_SWITCHPORT', null, 'ifLastChange', 'i18n_metadata.ifLastChange.filed_comments_n81i', 'VARCHAR2(50)', null, '1', '0', null, null, '1', '9', null, '1.3.6.1.2.1.2.2.1.9', '1', null);
INSERT INTO `metadata` VALUES ('83', '10', 'DI_SWITCHPORT', null, 'ifInOctets', 'i18n_metadata.ifInOctets.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '0', '10', null, '1.3.6.1.2.1.2.2.1.10', '1', null);
INSERT INTO `metadata` VALUES ('84', '10', 'DI_SWITCHPORT', null, 'ifInUcastPkts', 'i18n_metadata.ifInUcastPkts.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '11', null, '1.3.6.1.2.1.2.2.1.11', '1', null);
INSERT INTO `metadata` VALUES ('85', '10', 'DI_SWITCHPORT', null, 'ifInNUcastPkts', 'i18n_metadata.ifInNUcastPkts.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '12', null, '1.3.6.1.2.1.2.2.1.12', '1', null);
INSERT INTO `metadata` VALUES ('86', '10', 'DI_SWITCHPORT', null, 'ifInDiscards', 'i18n_metadata.ifInDiscards.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '13', null, '1.3.6.1.2.1.2.2.1.13', '1', null);
INSERT INTO `metadata` VALUES ('87', '10', 'DI_SWITCHPORT', null, 'ifInErrors', 'i18n_metadata.ifInErrors.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '14', null, '1.3.6.1.2.1.2.2.1.14', '1', null);
INSERT INTO `metadata` VALUES ('88', '10', 'DI_SWITCHPORT', null, 'ifInUnknownProtos', 'i18n_metadata.ifInUnknownProtos.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '15', null, '1.3.6.1.2.1.2.2.1.15', '1', null);
INSERT INTO `metadata` VALUES ('89', '10', 'DI_SWITCHPORT', null, 'ifOutOctets', 'i18n_metadata.ifOutOctets.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '16', null, '1.3.6.1.2.1.2.2.1.16', '1', null);
INSERT INTO `metadata` VALUES ('90', '10', 'DI_SWITCHPORT', null, 'ifOutUcastPkts', 'i18n_metadata.ifOutUcastPkts.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '17', null, '1.3.6.1.2.1.2.2.1.17', '1', null);
INSERT INTO `metadata` VALUES ('91', '10', 'DI_SWITCHPORT', null, 'ifOutNUcastPkts', 'i18n_metadata.ifOutNUcastPkts.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '18', null, '1.3.6.1.2.1.2.2.1.18', '1', null);
INSERT INTO `metadata` VALUES ('92', '10', 'DI_SWITCHPORT', null, 'ifOutDiscards', 'i18n_metadata.ifOutDiscards.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '19', null, '1.3.6.1.2.1.2.2.1.19', '1', null);
INSERT INTO `metadata` VALUES ('93', '10', 'DI_SWITCHPORT', null, 'ifOutErrors', 'i18n_metadata.ifOutErrors.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '20', null, '1.3.6.1.2.1.2.2.1.20', '1', null);
INSERT INTO `metadata` VALUES ('94', '10', 'DI_SWITCHPORT', null, 'ifOutQLen', 'i18n_metadata.ifOutQLen.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '21', null, '1.3.6.1.2.1.2.2.1.21', '1', null);
INSERT INTO `metadata` VALUES ('95', '10', 'DI_SWITCHPORT', null, 'ifSpecific', 'i18n_metadata.ifSpecific.filed_comments_n81i', 'VARCHAR2(400)', null, '1', '0', null, null, '1', '22', null, '1.3.6.1.2.1.2.2.1.22', '1', null);
INSERT INTO `metadata` VALUES ('96', '10', 'DI_SWITCHPORT', null, 'INOCTETSSPEED', 'i18n_metadata.INOCTETSSPEED.filed_comments_n81i', 'Number', null, '1', '0', null, null, '0', '23', null, '.0', null, null);
INSERT INTO `metadata` VALUES ('97', '10', 'DI_SWITCHPORT', null, 'inPktsSpeed', 'i18n_metadata.inPktsSpeed.filed_comments_n81i', 'Number', '2012-12-06 00:00:00', '1', '0', null, null, '0', '24', null, '.0', '1', null);
INSERT INTO `metadata` VALUES ('98', '10', 'DI_SWITCHPORT', null, 'ifInDiscardsPerc', 'i18n_metadata.ifInDiscardsPerc.filed_comments_n81i', 'Number', '2012-12-06 00:00:00', '1', '0', null, null, '1', '25', null, '.0', '1', null);
INSERT INTO `metadata` VALUES ('99', '10', 'DI_SWITCHPORT', null, 'INERRORSSCALE', 'i18n_metadata.INERRORSSCALE.filed_comments_n81i', 'Number', null, '1', '0', null, null, '1', '26', null, '.0', null, null);
INSERT INTO `metadata` VALUES ('100', '10', 'DI_SWITCHPORT', null, 'OUTOCTETSSPEED', 'i18n_metadata.OUTOCTETSSPEED.filed_comments_n81i', 'Number', null, '1', '0', null, null, '0', '27', null, '.0', null, null);
INSERT INTO `metadata` VALUES ('101', '10', 'DI_SWITCHPORT', null, 'outPktsSpeed', 'i18n_metadata.outPktsSpeed.filed_comments_n81i', 'Number', '2012-12-06 00:00:00', '1', '0', null, null, '0', '28', null, '.0', '1', null);
INSERT INTO `metadata` VALUES ('102', '10', 'DI_SWITCHPORT', null, 'ifOutDiscardsPerc', 'i18n_metadata.ifOutDiscardsPerc.filed_comments_n81i', 'Number', '2012-12-06 00:00:00', '1', '0', null, null, '1', '29', null, '.0', '1', null);
INSERT INTO `metadata` VALUES ('103', '10', 'DI_SWITCHPORT', null, 'OUTERRORSSCALE', 'i18n_metadata.OUTERRORSSCALE.filed_comments_n81i', 'Number', null, '1', '0', null, null, '1', '30', null, '.0', null, null);
INSERT INTO `metadata` VALUES ('104', '11', 'DETECT_INFO_SNMP_TRAP', null, 'agent_Send_IP', 'agentSendIP', 'VARCHAR2(20)', null, '1', '0', null, null, '1', '1', null, null, '1', null);
INSERT INTO `metadata` VALUES ('105', '11', 'DETECT_INFO_SNMP_TRAP', null, 'pdu_Agent_IP', 'pduAgentIP', 'VARCHAR2(20)', null, '1', '0', null, null, '1', '2', null, null, '1', null);
INSERT INTO `metadata` VALUES ('106', '11', 'DETECT_INFO_SNMP_TRAP', null, 'receiver_Time', 'receiverTime', 'NUMBER', null, '1', '0', null, null, '1', '3', null, null, '0', null);
INSERT INTO `metadata` VALUES ('107', '11', 'DETECT_INFO_SNMP_TRAP', null, 'trap_Version', 'trapVersion', 'Number', null, '1', '0', null, null, '1', '4', null, null, '1', null);
INSERT INTO `metadata` VALUES ('108', '11', 'DETECT_INFO_SNMP_TRAP', null, 'Generic_Type', 'trapV1GenericType', 'Number', null, '1', '0', null, null, '1', '5', null, null, '1', null);
INSERT INTO `metadata` VALUES ('109', '11', 'DETECT_INFO_SNMP_TRAP', null, 'Specific_Type', 'trapV1SpecificType', 'Number', null, '1', '0', null, null, '1', '6', null, null, '1', null);
INSERT INTO `metadata` VALUES ('110', '11', 'DETECT_INFO_SNMP_TRAP', null, 'trap_Name', 'trapName', 'VARCHAR2(200)', null, '1', '0', null, null, '1', '7', null, null, '1', null);
INSERT INTO `metadata` VALUES ('111', '11', 'DETECT_INFO_SNMP_TRAP', null, 'trap_OID', 'trapOID', 'VARCHAR2(200)', null, '1', '0', null, null, '1', '8', null, null, '1', null);
INSERT INTO `metadata` VALUES ('112', '11', 'DETECT_INFO_SNMP_TRAP', null, 'trap_PDU_OIDs', 'trapPDUOIDs', 'VARCHAR2(2000)', null, '1', '0', null, null, '1', '9', null, null, '1', null);
INSERT INTO `metadata` VALUES ('113', '11', 'DETECT_INFO_SNMP_TRAP', null, 'trap_PDU_OID_V', 'trapPDUOIDValues', 'VARCHAR2(2000)', null, '1', '0', null, null, '1', '10', null, null, '1', null);
INSERT INTO `metadata` VALUES ('114', '11', 'DETECT_INFO_SNMP_TRAP', null, 'original_PDU', 'originalPDU', 'VARCHAR2(1000)', null, '1', '0', null, null, '1', '11', null, null, '1', null);
INSERT INTO `metadata` VALUES ('115', '13', 'DI_DPBOARDSTATUSENTRY', null, 'dpBoardTemperature', 'dpBoardTemperature', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '0', '1', null, '1.3.6.1.4.1.31648.3.19.1.1', '0', null);
INSERT INTO `metadata` VALUES ('116', '14', 'DI_DPSYSTEMPOWERENTRY', null, 'dpSystemPowerNo', 'dpSystemPowerNo', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '1', null, '1.3.6.1.4.1.31648.3.20.1.1', '0', null);
INSERT INTO `metadata` VALUES ('117', '14', 'DI_DPSYSTEMPOWERENTRY', null, 'dpSystemPowerStat', 'dpSystemPowerStat', 'VARCHAR2(400)', '2013-03-14 00:00:00', '1', '0', null, null, '1', '2', null, '1.3.6.1.4.1.31648.3.20.1.2', '1', null);
INSERT INTO `metadata` VALUES ('118', '15', 'DI_DPSYSTEMFANENTRY', null, 'dpSystemFanNo', 'dpSystemFanNo', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '1', null, '1.3.6.1.4.1.31648.3.21.1.1', '0', null);
INSERT INTO `metadata` VALUES ('119', '15', 'DI_DPSYSTEMFANENTRY', null, 'dpSystemFanStat', 'dpSystemFanStat', 'VARCHAR2(400)', '2013-03-14 00:00:00', '1', '0', null, null, '1', '2', null, '1.3.6.1.4.1.31648.3.21.1.2', '1', null);
INSERT INTO `metadata` VALUES ('120', '16', 'DI_DPSLOTENTRY', null, 'dpSlotIndex', 'i18n_metadata.dpSlotIndex.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '1', null, '1.3.6.1.4.1.31648.6.1.1.1', '1', null);
INSERT INTO `metadata` VALUES ('121', '16', 'DI_DPSLOTENTRY', null, 'dpSlotType', 'i18n_metadata.dpSlotType.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '2', null, '1.3.6.1.4.1.31648.6.1.1.2', '1', null);
INSERT INTO `metadata` VALUES ('122', '16', 'DI_DPSLOTENTRY', null, 'dpSlotDesc', 'i18n_metadata.dpSlotDesc.filed_comments_n81i', 'VARCHAR2(400)', '2013-03-14 00:00:00', '1', '0', null, null, '1', '3', null, '1.3.6.1.4.1.31648.6.1.1.3', '0', null);
INSERT INTO `metadata` VALUES ('123', '16', 'DI_DPSLOTENTRY', null, 'dpSlotPortNum', 'i18n_metadata.dpSlotPortNum.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '4', null, '1.3.6.1.4.1.31648.6.1.1.4', '1', null);
INSERT INTO `metadata` VALUES ('124', '16', 'DI_DPSLOTENTRY', null, 'dpSlotStatus', 'i18n_metadata.dpSlotStatus.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '0', '5', null, '1.3.6.1.4.1.31648.6.1.1.5', '1', null);
INSERT INTO `metadata` VALUES ('125', '16', 'DI_DPSLOTENTRY', null, 'dpSlotIsMain', 'i18n_metadata.dpSlotIsMain.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '6', null, '1.3.6.1.4.1.31648.6.1.1.6', '1', null);
INSERT INTO `metadata` VALUES ('126', '16', 'DI_DPSLOTENTRY', null, 'dpSlotRunTimes', 'i18n_metadata.dpSlotRunTimes.filed_comments_n81i', 'VARCHAR2(400)', '2013-03-14 00:00:00', '1', '0', null, null, '1', '7', null, '1.3.6.1.4.1.31648.6.1.1.7', '1', null);
INSERT INTO `metadata` VALUES ('127', '19', 'DI_DPSYSTEMSTATUS', null, 'dpCpuRatio', 'i18n_metadata.dpCpuRatio.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '1', null, '1.3.6.1.4.1.31648.3.15.1', '1', null);
INSERT INTO `metadata` VALUES ('128', '19', 'DI_DPSYSTEMSTATUS', null, 'dpCpuRatioPeak', 'i18n_metadata.dpCpuRatioPeak.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '2', null, '1.3.6.1.4.1.31648.3.15.2', '1', null);
INSERT INTO `metadata` VALUES ('129', '19', 'DI_DPSYSTEMSTATUS', null, 'dpCpuRatioAverage', 'i18n_metadata.dpCpuRatioAverage.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '3', null, '1.3.6.1.4.1.31648.3.15.3', '1', null);
INSERT INTO `metadata` VALUES ('130', '19', 'DI_DPSYSTEMSTATUS', null, 'dpCpuTemperature', 'i18n_metadata.dpCpuTemperature.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '4', null, '1.3.6.1.4.1.31648.3.15.4', '1', null);
INSERT INTO `metadata` VALUES ('131', '19', 'DI_DPSYSTEMSTATUS', null, 'dpMemRatio', 'i18n_metadata.dpMemRatio.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '5', null, '1.3.6.1.4.1.31648.3.15.5', '1', null);
INSERT INTO `metadata` VALUES ('132', '19', 'DI_DPSYSTEMSTATUS', null, 'dpMemRatioPeak', 'i18n_metadata.dpMemRatioPeak.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '6', null, '1.3.6.1.4.1.31648.3.15.6', '1', null);
INSERT INTO `metadata` VALUES ('133', '19', 'DI_DPSYSTEMSTATUS', null, 'dpMemRatioAverage', 'i18n_metadata.dpMemRatioAverage.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '7', null, '1.3.6.1.4.1.31648.3.15.7', '1', null);
INSERT INTO `metadata` VALUES ('134', '19', 'DI_DPSYSTEMSTATUS', null, 'dpMainboardTemperature', 'i18n_metadata.dpMainboardTemperature.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '0', '8', null, '1.3.6.1.4.1.31648.3.15.8', '1', null);
INSERT INTO `metadata` VALUES ('135', '19', 'DI_DPSYSTEMSTATUS', null, 'dpSession', 'i18n_metadata.dpSession.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '9', null, '1.3.6.1.4.1.31648.3.15.9', '0', null);
INSERT INTO `metadata` VALUES ('136', '19', 'DI_DPSYSTEMSTATUS', null, 'dpCpuRatio30s', 'i18n_metadata.dpCpuRatio30s.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '10', null, '1.3.6.1.4.1.31648.3.15.10', '1', null);
INSERT INTO `metadata` VALUES ('137', '19', 'DI_DPSYSTEMSTATUS', null, 'dpCpuRatio5min', 'i18n_metadata.dpCpuRatio5min.filed_comments_n81i', 'NUMBER', '2013-03-14 00:00:00', '1', '0', null, null, '1', '11', null, '1.3.6.1.4.1.31648.3.15.11', '1', null);
INSERT INTO `metadata` VALUES ('138', '17', 'DI_IFXTABLE', null, 'ifName', 'ifName', 'VARCHAR2(25)', '2013-03-18 00:00:00', '1', '0', null, null, '1', '1', null, '1.3.6.1.2.1.31.1.1.1.1', null, null);
INSERT INTO `metadata` VALUES ('139', '17', 'DI_IFXTABLE', null, 'InMulticastPkts', 'ifInMulticastPkts', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '2', null, '1.3.6.1.2.1.31.1.1.1.2', null, null);
INSERT INTO `metadata` VALUES ('140', '17', 'DI_IFXTABLE', null, 'InBroadcastPkts', 'ifInBroadcastPkts', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '3', null, '1.3.6.1.2.1.31.1.1.1.3', null, null);
INSERT INTO `metadata` VALUES ('141', '17', 'DI_IFXTABLE', null, 'OutMulcastPkts', 'ifOutMulticastPkts', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '4', null, '1.3.6.1.2.1.31.1.1.1.4', null, null);
INSERT INTO `metadata` VALUES ('142', '17', 'DI_IFXTABLE', null, 'OutBrocastPkts', 'ifOutBroadcastPkts', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '5', null, '1.3.6.1.2.1.31.1.1.1.5', null, null);
INSERT INTO `metadata` VALUES ('143', '17', 'DI_IFXTABLE', null, 'ifHCInOctets', 'ifHCInOctets', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '6', null, '1.3.6.1.2.1.31.1.1.1.6', null, null);
INSERT INTO `metadata` VALUES ('144', '17', 'DI_IFXTABLE', null, 'HCInUCastPkts', 'ifHCInUcastPkts', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '7', null, '1.3.6.1.2.1.31.1.1.1.7', null, null);
INSERT INTO `metadata` VALUES ('145', '17', 'DI_IFXTABLE', null, 'HCIMulCastPkts', 'ifHCInMulticastPkts', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '8', null, '1.3.6.1.2.1.31.1.1.1.8', null, null);
INSERT INTO `metadata` VALUES ('146', '17', 'DI_IFXTABLE', null, 'HCIBroCastPkts', 'ifHCInBroadcastPkts', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '9', null, '1.3.6.1.2.1.31.1.1.1.9', '1', null);
INSERT INTO `metadata` VALUES ('147', '17', 'DI_IFXTABLE', null, 'HCOutOctets', 'ifHCOutOctets', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '10', null, '1.3.6.1.2.1.31.1.1.1.10', '1', null);
INSERT INTO `metadata` VALUES ('148', '17', 'DI_IFXTABLE', null, 'HCOUcastPkts', 'ifHCOutUcastPkts', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '11', null, '1.3.6.1.2.1.31.1.1.1.11', '1', null);
INSERT INTO `metadata` VALUES ('149', '17', 'DI_IFXTABLE', null, 'HCOMulCastPkts', 'ifHCOutMulticastPkts', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '12', null, '1.3.6.1.2.1.31.1.1.1.12', '1', null);
INSERT INTO `metadata` VALUES ('150', '17', 'DI_IFXTABLE', null, 'HCOBroCastPkts', 'ifHCOutBroadcastPkts', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '13', null, '1.3.6.1.2.1.31.1.1.1.13', '1', null);
INSERT INTO `metadata` VALUES ('151', '17', 'DI_IFXTABLE', null, 'LinkUpDownTrapE', 'ifLinkUpDownTrapEnable', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '14', null, '1.3.6.1.2.1.31.1.1.1.14', '1', null);
INSERT INTO `metadata` VALUES ('152', '17', 'DI_IFXTABLE', null, 'ifHighSpeed', 'i18n_metadata.ifHighSpeed.filed_comments_n81i', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '15', null, '1.3.6.1.2.1.31.1.1.1.15', '1', null);
INSERT INTO `metadata` VALUES ('153', '17', 'DI_IFXTABLE', null, 'PromiscuousMode', 'ifPromiscuousMode', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '16', null, '1.3.6.1.2.1.31.1.1.1.16', '1', null);
INSERT INTO `metadata` VALUES ('154', '17', 'DI_IFXTABLE', null, 'ConnectorPresen', 'ifConnectorPresent', 'Number', '2013-03-18 00:00:00', '1', '0', null, null, '1', '17', null, '1.3.6.1.2.1.31.1.1.1.17', '1', null);
INSERT INTO `metadata` VALUES ('155', '17', 'DI_IFXTABLE', null, 'ifAlias', 'ifAlias', 'VARCHAR2(50)', '2013-03-18 00:00:00', '1', '0', null, null, '1', '18', null, '1.3.6.1.2.1.31.1.1.1.18', '1', null);
INSERT INTO `metadata` VALUES ('156', '17', 'DI_IFXTABLE', null, 'CounterDisconti', 'ifCounterDiscontinuityTime', 'VARCHAR2(100)', '2013-03-18 00:00:00', '1', '0', null, null, '1', '19', null, '1.3.6.1.2.1.31.1.1.1.19', '1', null);
INSERT INTO `metadata` VALUES ('183', '10', 'DI_SWITCHPORT', null, 'ifInOctets_t1', 'i18n_metadata.ifInOctets_t1.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '31', null, '1.3.6.1.2.1.2.2.1.10', '1', null);
INSERT INTO `metadata` VALUES ('184', '10', 'DI_SWITCHPORT', null, 'ifInUcastPkts_t1', 'i18n_metadata.ifInUcastPkts_t1.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '32', null, '1.3.6.1.2.1.2.2.1.11', '1', null);
INSERT INTO `metadata` VALUES ('185', '10', 'DI_SWITCHPORT', null, 'ifInNUcastPkts_t1', 'i18n_metadata.ifInNUcastPkts_t1.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '33', null, '1.3.6.1.2.1.2.2.1.12', '1', null);
INSERT INTO `metadata` VALUES ('186', '10', 'DI_SWITCHPORT', null, 'ifOutOctets_t1', 'i18n_metadata.ifOutOctets_t1.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '34', null, '1.3.6.1.2.1.2.2.1.16', '1', null);
INSERT INTO `metadata` VALUES ('187', '10', 'DI_SWITCHPORT', null, 'ifOutUcastPkts_t1', 'i18n_metadata.ifOutUcastPkts_t1.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '35', null, '1.3.6.1.2.1.2.2.1.17', '1', null);
INSERT INTO `metadata` VALUES ('188', '10', 'DI_SWITCHPORT', null, 'ifOutNUcastPkts_t1', 'i18n_metadata.ifOutNUcastPkts_t1.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '36', null, '1.3.6.1.2.1.2.2.1.18', '1', null);
INSERT INTO `metadata` VALUES ('189', '10', 'DI_SWITCHPORT', null, 'ifHighSpeed', 'i18n_metadata.ifHighSpeed.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '37', null, '1.3.6.1.2.1.31.1.1.1.15.1.1000000', '1', null);
INSERT INTO `metadata` VALUES ('201', '10', 'DI_SWITCHPORT', null, 'Data_64_FLag', 'i18n_metadata.Data_64_FLag.filed_comments_n81i', 'NUMBER', null, '1', '0', null, null, '1', '38', null, '.0', '1', null);



-- ----------------------------
-- Records of mission_file_information
-- ----------------------------



-- ----------------------------
-- Records of mission_parameter_table1
-- ----------------------------



-- ----------------------------
-- Records of mission_parameter_table4
-- ----------------------------



-- ----------------------------
-- Records of mission_parameter_table6
-- ----------------------------



-- ----------------------------
-- Records of mission_result_table1
-- ----------------------------



-- ----------------------------
-- Records of mission_result_table4
-- ----------------------------



-- ----------------------------
-- Records of mission_result_table6
-- ----------------------------



-- ----------------------------
-- Records of mission_state_table
-- ----------------------------



-- ----------------------------
-- Records of nms_error_code
-- ----------------------------
INSERT INTO `nms_error_code` VALUES ('9', 'CreateSocketError', 'i18n_nms_error_code.CreateSocketError.error_name_n81i', 'i18n_nms_error_code.CreateSocketError.error_des_n81i', '0');
INSERT INTO `nms_error_code` VALUES ('10', 'NCWorkError', 'i18n_nms_error_code.NCWorkError.error_name_n81i', 'i18n_nms_error_code.NCWorkError.error_des_n81i', '0');
INSERT INTO `nms_error_code` VALUES ('11', 'DCSocketServerStartError', 'i18n_nms_error_code.DCSocketServerStartError.error_name_n81i', 'i18n_nms_error_code.DCSocketServerStartError.error_des_n81i', '0');
INSERT INTO `nms_error_code` VALUES ('12', 'DCSocketServerRuntimeError', 'i18n_nms_error_code.DCSocketServerRuntimeError.error_name_n81i', 'i18n_nms_error_code.DCSocketServerRuntimeError.error_des_n81i', '0');
INSERT INTO `nms_error_code` VALUES ('13', 'DCSocketRuntimeError', 'i18n_nms_error_code.DCSocketRuntimeError.error_name_n81i', 'i18n_nms_error_code.DCSocketRuntimeError.error_des_n81i', '0');
INSERT INTO `nms_error_code` VALUES ('21', 'ProcessNotExist', 'i18n_nms_error_code.ProcessNotExist.error_name_n81i', 'i18n_nms_error_code.ProcessNotExist.error_des_n81i', '1');
INSERT INTO `nms_error_code` VALUES ('22', 'ThreadRuntimeError', 'i18n_nms_error_code.ThreadRuntimeError.error_name_n81i', 'i18n_nms_error_code.ThreadRuntimeError.error_des_n81i', '3');
INSERT INTO `nms_error_code` VALUES ('23', 'HandShakeError', 'i18n_nms_error_code.HandShakeError.error_name_n81i', 'i18n_nms_error_code.HandShakeError.error_des_n81i', '2');
INSERT INTO `nms_error_code` VALUES ('24', 'ProtListenerError', 'i18n_nms_error_code.ProtListenerError.error_name_n81i', 'i18n_nms_error_code.ProtListenerError.error_des_n81i', '2');
INSERT INTO `nms_error_code` VALUES ('25', 'DeamonNotExist', 'i18n_nms_error_code.DeamonNotExist.error_name_n81i', 'i18n_nms_error_code.DeamonNotExist.error_des_n81i', '2');
INSERT INTO `nms_error_code` VALUES ('26', 'DataResoveError', 'i18n_nms_error_code.DataResoveError.error_name_n81i', 'i18n_nms_error_code.DataResoveError.error_des_n81i', '3');
INSERT INTO `nms_error_code` VALUES ('27', 'SocketError', 'i18n_nms_error_code.SocketError.error_name_n81i', 'i18n_nms_error_code.SocketError.error_des_n81i', '3');
INSERT INTO `nms_error_code` VALUES ('28', 'NetWorkError', 'i18n_nms_error_code.NetWorkError.error_name_n81i', 'i18n_nms_error_code.NetWorkError.error_des_n81i', '0');
INSERT INTO `nms_error_code` VALUES ('29', 'DataCollectError', 'i18n_nms_error_code.DataCollectError.error_name_n81i', 'i18n_nms_error_code.DataCollectError.error_des_n81i', '3');



-- ----------------------------
-- Records of nms_error_info
-- ----------------------------



-- ----------------------------
-- Records of nodegroup_arrow_position
-- ----------------------------



-- ----------------------------
-- Records of nodegroup_bgimg_position
-- ----------------------------



-- ----------------------------
-- Records of nodegroup_position
-- ----------------------------


-- ----------------------------
-- Records of nodegroup_table
-- ----------------------------


-- ----------------------------
-- Records of node_box_table
-- ----------------------------


-- ----------------------------
-- Records of node_figure_info
-- ----------------------------
INSERT INTO `node_figure_info` VALUES ('100271', '0', 'FF-N3100', '100022', '1', '1', 'FF-N3100', '-1', '-1', 'image', '35', '35', '442', '573', 'red', '1', 'FF-N3100-FRAME.png', null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', 'FF-N3100-FRAME.png', '1', '1');
INSERT INTO `node_figure_info` VALUES ('100272', '100271', 'FF-N3100-W100G_BUSINESS', '100022', '2', '3', 'FF-N3100-W100G_BUSINESS', '-1', '-1', 'image', '56', '356', '397', '41', 'red', '1', 'FF-N3100-W100G_BUSINESS.png', null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', 'FF-N3100-W100G_BUSINESS.png', '0', '1');
INSERT INTO `node_figure_info` VALUES ('100273', '100272', 'FF-N3100-W100G_BUSINESS-1-2', '100022', '3', '2', 'xgei_3/1/2', '-1', '-1', 'image', '112', '359', '15', '10', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100274', '100272', 'FF-N3100-W100G_BUSINESS-1-3', '100022', '3', '3', 'xgei_3/1/3', '-1', '-1', 'image', '112', '373', '15', '12', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100275', '100272', 'FF-N3100-W100G_BUSINESS-1-4', '100022', '3', '4', 'xgei_3/1/4', '-1', '-1', 'image', '127', '360', '13', '10', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100276', '100272', 'FF-N3100-W100G_BUSINESS-1-5', '100022', '3', '5', 'xgei_3/1/5', '-1', '-1', 'image', '127', '372', '14', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100277', '100272', 'FF-N3100-W100G_BUSINESS-1-6', '100022', '3', '6', 'xgei_3/1/6', '-1', '-1', 'image', '141', '360', '13', '9', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100278', '100272', 'FF-N3100-W100G_BUSINESS-1-7', '100022', '3', '7', 'xgei_3/1/7', '-1', '-1', 'image', '141', '373', '14', '10', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100279', '100272', 'FF-N3100-W100G_BUSINESS-1-8', '100022', '3', '8', 'xgei_3/1/8', '-1', '-1', 'image', '155', '359', '14', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100280', '100272', 'FF-N3100-W100G_BUSINESS-1-9', '100022', '3', '9', 'xgei_3/1/9', '-1', '-1', 'image', '156', '372', '13', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100281', '100272', 'FF-N3100-W100G_BUSINESS-1-10', '100022', '3', '10', 'xgei_3/1/10', '-1', '-1', 'image', '170', '360', '14', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100282', '100272', 'FF-N3100-W100G_BUSINESS-1-11', '100022', '3', '11', 'xgei_3/1/11', '-1', '-1', 'image', '169', '371', '15', '14', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100283', '100272', 'FF-N3100-W100G_BUSINESS-1-12', '100022', '3', '12', 'xgei_3/1/12', '-1', '-1', 'image', '183', '359', '14', '13', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100284', '100272', 'FF-N3100-W100G_BUSINESS-1-13', '100022', '3', '13', 'xgei_3/1/13', '-1', '-1', 'image', '185', '374', '13', '9', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100285', '100272', 'FF-N3100-W100G_BUSINESS-2-2', '100022', '3', '2', 'xgei_3/2/2', '-1', '-1', 'image', '339', '360', '13', '9', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100286', '100272', 'FF-N3100-W100G_BUSINESS-2-3', '100022', '3', '3', 'xgei_3/2/3', '-1', '-1', 'image', '339', '373', '13', '10', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100287', '100272', 'FF-N3100-W100G_BUSINESS-2-4', '100022', '3', '4', 'xgei_3/2/4', '-1', '-1', 'image', '355', '359', '12', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100288', '100272', 'FF-N3100-W100G_BUSINESS-2-5', '100022', '3', '5', 'xgei_3/2/5', '-1', '-1', 'image', '353', '372', '14', '13', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100289', '100272', 'FF-N3100-W100G_BUSINESS-2-6', '100022', '3', '6', 'xgei_3/2/6', '-1', '-1', 'image', '366', '359', '14', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100290', '100272', 'FF-N3100-W100G_BUSINESS-2-7', '100022', '3', '7', 'xgei_3/2/7', '-1', '-1', 'image', '366', '372', '14', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100291', '100272', 'FF-N3100-W100G_BUSINESS-2-8', '100022', '3', '8', 'xgei_3/2/8', '-1', '-1', 'image', '381', '360', '13', '10', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100292', '100272', 'FF-N3100-W100G_BUSINESS-2-9', '100022', '3', '9', 'xgei_3/2/9', '-1', '-1', 'image', '380', '371', '14', '14', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100293', '100272', 'FF-N3100-W100G_BUSINESS-2-10', '100022', '3', '10', 'xgei_3/2/10', '-1', '-1', 'image', '396', '359', '13', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100294', '100272', 'FF-N3100-W100G_BUSINESS-2-11', '100022', '3', '11', 'xgei_3/2/11', '-1', '-1', 'image', '396', '372', '14', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100295', '100272', 'FF-N3100-W100G_BUSINESS-2-12', '100022', '3', '12', 'xgei_3/2/12', '-1', '-1', 'image', '409', '359', '16', '12', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100296', '100272', 'FF-N3100-W100G_BUSINESS-2-13', '100022', '3', '13', 'xgei_3/2/13', '-1', '-1', 'image', '409', '371', '16', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100297', '100271', 'FF-N3100-W100G_BUSINESS', '100022', '2', '2', 'FF-N3100-W100G_BUSINESS', '-1', '-1', 'image', '56', '397', '397', '41', 'red', '1', 'FF-N3100-W100G_BUSINESS.png', null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', 'FF-N3100-W100G_BUSINESS.png', '0', '1');
INSERT INTO `node_figure_info` VALUES ('100298', '100297', 'FF-N3100-W100G_BUSINESS-1-2', '100022', '3', '2', 'xgei_2/1/2', '-1', '-1', 'image', '112', '400', '15', '10', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100299', '100297', 'FF-N3100-W100G_BUSINESS-1-3', '100022', '3', '3', 'xgei_2/1/3', '-1', '-1', 'image', '112', '414', '15', '12', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100300', '100297', 'FF-N3100-W100G_BUSINESS-1-4', '100022', '3', '4', 'xgei_2/1/4', '-1', '-1', 'image', '127', '401', '13', '10', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100301', '100297', 'FF-N3100-W100G_BUSINESS-1-5', '100022', '3', '5', 'xgei_2/1/5', '-1', '-1', 'image', '127', '413', '14', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100302', '100297', 'FF-N3100-W100G_BUSINESS-1-6', '100022', '3', '6', 'xgei_2/1/6', '-1', '-1', 'image', '141', '401', '13', '9', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100303', '100297', 'FF-N3100-W100G_BUSINESS-1-7', '100022', '3', '7', 'xgei_2/1/7', '-1', '-1', 'image', '141', '414', '14', '10', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100304', '100297', 'FF-N3100-W100G_BUSINESS-1-8', '100022', '3', '8', 'xgei_2/1/8', '-1', '-1', 'image', '155', '400', '14', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100305', '100297', 'FF-N3100-W100G_BUSINESS-1-9', '100022', '3', '9', 'xgei_2/1/9', '-1', '-1', 'image', '156', '413', '13', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100306', '100297', 'FF-N3100-W100G_BUSINESS-1-10', '100022', '3', '10', 'xgei_2/1/10', '-1', '-1', 'image', '170', '401', '14', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100307', '100297', 'FF-N3100-W100G_BUSINESS-1-11', '100022', '3', '11', 'xgei_2/1/11', '-1', '-1', 'image', '169', '412', '15', '14', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100308', '100297', 'FF-N3100-W100G_BUSINESS-1-12', '100022', '3', '12', 'xgei_2/1/12', '-1', '-1', 'image', '183', '400', '14', '13', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100309', '100297', 'FF-N3100-W100G_BUSINESS-1-13', '100022', '3', '13', 'xgei_2/1/13', '-1', '-1', 'image', '185', '415', '13', '9', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100310', '100297', 'FF-N3100-W100G_BUSINESS-2-2', '100022', '3', '2', 'xgei_2/2/2', '-1', '-1', 'image', '339', '401', '13', '9', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100311', '100297', 'FF-N3100-W100G_BUSINESS-2-3', '100022', '3', '3', 'xgei_2/2/3', '-1', '-1', 'image', '339', '414', '13', '10', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100312', '100297', 'FF-N3100-W100G_BUSINESS-2-4', '100022', '3', '4', 'xgei_2/2/4', '-1', '-1', 'image', '355', '400', '12', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100313', '100297', 'FF-N3100-W100G_BUSINESS-2-5', '100022', '3', '5', 'xgei_2/2/5', '-1', '-1', 'image', '353', '413', '14', '13', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100314', '100297', 'FF-N3100-W100G_BUSINESS-2-6', '100022', '3', '6', 'xgei_2/2/6', '-1', '-1', 'image', '366', '400', '14', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100315', '100297', 'FF-N3100-W100G_BUSINESS-2-7', '100022', '3', '7', 'xgei_2/2/7', '-1', '-1', 'image', '366', '413', '14', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100316', '100297', 'FF-N3100-W100G_BUSINESS-2-8', '100022', '3', '8', 'xgei_2/2/8', '-1', '-1', 'image', '381', '401', '13', '10', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100317', '100297', 'FF-N3100-W100G_BUSINESS-2-9', '100022', '3', '9', 'xgei_2/2/9', '-1', '-1', 'image', '380', '412', '14', '14', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100318', '100297', 'FF-N3100-W100G_BUSINESS-2-10', '100022', '3', '10', 'xgei_2/2/10', '-1', '-1', 'image', '396', '400', '13', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100319', '100297', 'FF-N3100-W100G_BUSINESS-2-11', '100022', '3', '11', 'xgei_2/2/11', '-1', '-1', 'image', '396', '413', '14', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100320', '100297', 'FF-N3100-W100G_BUSINESS-2-12', '100022', '3', '12', 'xgei_2/2/12', '-1', '-1', 'image', '409', '400', '16', '12', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100321', '100297', 'FF-N3100-W100G_BUSINESS-2-13', '100022', '3', '13', 'xgei_2/2/13', '-1', '-1', 'image', '409', '412', '16', '11', 'red', '1', null, null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', null, '1', '1');
INSERT INTO `node_figure_info` VALUES ('100322', '100271', 'FF-N3100-WPROTECT', '100022', '2', '1', 'FF-N3100-WPROTECT', '-1', '-1', 'image', '56', '439', '397', '41', 'red', '1', 'FF-N3100-WPROTECT.png', null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', 'FF-N3100-WPROTECT.png', '0', '1');
INSERT INTO `node_figure_info` VALUES ('100323', '100271', 'FF-N3100-NMANAGER', '100022', '2', '4', 'FF-N3100-NMANAGER', '-1', '-1', 'image', '56', '320', '397', '31', 'red', '1', 'FF-N3100-NMANAGER.png', null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', 'FF-N3100-NMANAGER.png', '0', '1');
INSERT INTO `node_figure_info` VALUES ('100324', '100271', 'FF-N3100-NMANAGER', '100022', '2', '5', 'FF-N3100-NMANAGER', '-1', '-1', 'image', '56', '288', '397', '31', 'red', '1', 'FF-N3100-NMANAGER.png', null, '2018-07-11 18:28:17', '1', '2018-07-11 18:28:17', '1', 'FF-N3100-NMANAGER.png', '0', '1');



-- ----------------------------
-- Records of node_ip_table
-- ----------------------------


-- ----------------------------
-- Records of node_lattice_record
-- ----------------------------



-- ----------------------------
-- Records of node_lattice_table
-- ----------------------------



-- ----------------------------
-- Records of node_position
-- ----------------------------



-- ----------------------------
-- Records of node_room_lattice_table
-- ----------------------------



-- ----------------------------
-- Records of node_room_table
-- ----------------------------



-- ----------------------------
-- Records of node_table
-- ----------------------------



-- ----------------------------
-- Records of oid_dictionary
-- ----------------------------



-- ----------------------------
-- Records of operate_audit_rz
-- ----------------------------



-- ----------------------------
-- Records of option_table
-- ----------------------------
INSERT INTO `option_table` VALUES ('100000', 'emergent', '1', 'i18n_option_table.1.type_value_n81i', '1', '0', '60');
INSERT INTO `option_table` VALUES ('100001', 'isIdentical', '1', 'i18n_option_table.2.type_value_n81i', '1', '0', '0');
INSERT INTO `option_table` VALUES ('100002', 'detecWarningLevel', '5', 'i18n_option_table.3.type_value_n81i', '5', '1', '0');
INSERT INTO `option_table` VALUES ('100003', 'detecWarningLevel', '2', 'i18n_option_table.4.type_value_n81i', '2', '1', '0');
INSERT INTO `option_table` VALUES ('100004', 'isIdentical', '0', 'i18n_option_table.5.type_value_n81i', '2', '0', '0');
INSERT INTO `option_table` VALUES ('100005', 'detecWarningLevel', '1', 'i18n_option_table.6.type_value_n81i', '1', '0', '0');
INSERT INTO `option_table` VALUES ('100006', 'detecWarningLevel', '3', 'i18n_option_table.7.type_value_n81i', '3', '1', '0');
INSERT INTO `option_table` VALUES ('100007', 'detecWarningLevel', '4', 'i18n_option_table.8.type_value_n81i', '4', '1', '0');
INSERT INTO `option_table` VALUES ('100008', 'emailflag', '1', 'i18n_option_table.9.type_value_n81i', '1', '0', '0');
INSERT INTO `option_table` VALUES ('100009', 'diskwritestate', '0', 'i18n_option_table.10.type_value_n81i', '1', '0', null);
INSERT INTO `option_table` VALUES ('100010', 'diskwritestate', '1', 'i18n_option_table.11.type_value_n81i', '2', '0', null);
INSERT INTO `option_table` VALUES ('100011', 'emergent', '0', 'i18n_option_table.12.type_value_n81i', '0', '0', '0');
INSERT INTO `option_table` VALUES ('100012', 'dpfan', 'normal', 'i18n_option_table.13.type_value_n81i', '1', '0', null);
INSERT INTO `option_table` VALUES ('100013', 'dpfan', 'abnormal', 'i18n_option_table.14.type_value_n81i', '2', '0', null);
INSERT INTO `option_table` VALUES ('100014', 'dpfan', 'offline', 'i18n_option_table.15.type_value_n81i', '3', '0', null);
INSERT INTO `option_table` VALUES ('100015', 'netelementtype', '1', 'i18n_option_table.16.type_value_n81i', '1', '0', null);
INSERT INTO `option_table` VALUES ('100016', 'netelementtype', '2', 'i18n_option_table.17.type_value_n81i', '2', '0', null);
INSERT INTO `option_table` VALUES ('100017', 'netelementtype', '3', 'i18n_option_table.18.type_value_n81i', '3', '0', null);
INSERT INTO `option_table` VALUES ('100018', 'netelementtype', '4', 'i18n_option_table.19.type_value_n81i', '4', '0', null);
INSERT INTO `option_table` VALUES ('100019', 'monitorStatusInfo', 'i18n_option_table.20.type_code_n81i', 'i18n_option_table.20.type_value_n81i', '3', '0', '0');
INSERT INTO `option_table` VALUES ('100020', 'monitorStatusInfo', 'i18n_option_table.21.type_code_n81i', 'i18n_option_table.21.type_value_n81i', '4', '0', '0');
INSERT INTO `option_table` VALUES ('100021', 'monitorStatusInfo', 'i18n_option_table.22.type_code_n81i', 'i18n_option_table.22.type_value_n81i', '5', '0', '0');
INSERT INTO `option_table` VALUES ('100022', 'monitorStatusInfo', 'i18n_option_table.23.type_code_n81i', 'i18n_option_table.23.type_value_n81i', '6', '0', '0');
INSERT INTO `option_table` VALUES ('100023', 'monitorStatusInfo', 'i18n_option_table.24.type_code_n81i', 'i18n_option_table.24.type_value_n81i', '1', '0', '0');
INSERT INTO `option_table` VALUES ('100024', 'monitorStatusInfo', 'ss', 'ss', '2', '0', '0');
INSERT INTO `option_table` VALUES ('100025', 'monitorStatusInfo', 'i18n_option_table.26.type_code_n81i', 'i18n_option_table.26.type_value_n81i', '1', '0', '0');
INSERT INTO `option_table` VALUES ('100026', 'monitorStatusInfo', 'i18n_option_table.27.type_code_n81i', 'i18n_option_table.27.type_value_n81i', '7', '0', '0');



-- ----------------------------
-- Records of order_table
-- ----------------------------
INSERT INTO `order_table` VALUES ('1', 'upgrade_kill_process', 'i18n_order_table.upgrade_kill_process.command_desc_n81i', '1', 'Os.val.mem.used', null, null, '1', null, 'i18n_kill_process_n81i', 'killProcessTemplate');
INSERT INTO `order_table` VALUES ('2', 'upgrade_backup', 'i18n_order_table.upgrade_backup.command_desc_n81i', '1', 'Os.val.disk.used', null, null, '1', 'i18n_order_table.upgrade_backup.command_model_n81i', 'i18n_backup_n81i', 'backupTemplate');
INSERT INTO `order_table` VALUES ('3', 'upgrade_update', 'i18n_order_table.upgrade_update.command_desc_n81i', '1', 'Os.str.process', null, null, '1', 'i18n_order_table.upgrade_update.command_model_n81i', 'i18n_update_n81i', 'updateTemplate');
INSERT INTO `order_table` VALUES ('4', 'upgrade_start', 'i18n_order_table.upgrade_start.command_desc_n81i', '1', 'Os.val.last.restart', null, null, '1', 'i18n_order_table.upgrade_start.command_model_n81i', 'i18n_start_n81i', 'startTemplate');
INSERT INTO `order_table` VALUES ('5', 'upgrade_recover', 'i18n_order_table.upgrade_recover.command_desc_n81i', '1', 'Os.val.file.modify.time', 'i18n_order_table.upgrade_recover.shell_path_n81i', null, '1', 'i18n_order_table.upgrade_recover.command_model_n81i', 'i18n_recover_n81i', 'recoverTemplate');
INSERT INTO `order_table` VALUES ('6', 'upgrade_exec', 'i18n_order_table.upgrade_exec.command_desc_n81i', '2', 'date', 'test_1305174377363.sh', 'fd4df417fc6cad0da1a49fb9872f59dd', '1', 'i18n_order_table.upgrade_exec.command_model_n81i', 'i18n_exec_n81i', 'startTemplate');
INSERT INTO `order_table` VALUES ('7', 'push_file', 'i18n_order_table.push_file.command_desc_n81i', '5', null, null, null, '1', 'i18n_order_table.push_file.command_model_n81i', 'i18n_push_file_n81i', 'paramM1Template');
INSERT INTO `order_table` VALUES ('8', 'upgrade_agent', 'i18n_order_table.upgrade_agent.command_desc_n81i', '4', null, null, null, '1', 'i18n_order_table.upgrade_agent.command_model_n81i', 'i18n_agent_n81i', 'AgentUpgradeTemplate');
INSERT INTO `order_table` VALUES ('9', 'upgrade_other', 'i18n_order_table.upgrade_other.command_desc_n81i', '4', 'Os.val.cpu.used', null, null, '1', 'i18n_order_table.upgrade_other.command_model_n81i', 'i18n_other_n81i', 'OtherUpgradeTemplate');
INSERT INTO `order_table` VALUES ('10', 'upgrade_server', 'i18n_order_table.upgrade_server.command_desc_n81i', '4', null, null, null, '1', 'i18n_order_table.upgrade_server.command_model_n81i', 'i18n_server_n81i', 'OtherUpgradeTemplate');
INSERT INTO `order_table` VALUES ('11', 'single_exec', 'i18n_order_table.single_exec.command_desc_n81i', '2', null, null, null, '1', null, 'i18n_single_exec_n81i', 'SingleExecTemplate');



-- ----------------------------
-- Records of plugin_info
-- ----------------------------



-- ----------------------------
-- Records of procedure_log
-- ----------------------------



-- ----------------------------
-- Records of proexecinfo
-- ----------------------------



-- ----------------------------
-- Records of pro_exec_log
-- ----------------------------



-- ----------------------------
-- Records of server_ip_segment
-- ----------------------------


-- ----------------------------
-- Records of server_table
-- ----------------------------



-- ----------------------------
-- Records of set_det_data_con
-- ----------------------------
INSERT INTO `set_det_data_con` VALUES ('6', 'i18n_xt_mk_jbxx.441.mkmc_n81i', null, null, '3DroomWarningInfo');
INSERT INTO `set_det_data_con` VALUES ('1', 'i18n_set_det_data_con.1.menu_name_n81i', null, ',0,', 'logicTopo');
INSERT INTO `set_det_data_con` VALUES ('2', 'i18n_set_det_data_con.2.menu_name_n81i', null, ',0,', 'allWarningInfo');
INSERT INTO `set_det_data_con` VALUES ('3', 'i18n_set_det_data_con.3.menu_name_n81i', null, null, 'serverWarningInfo');
INSERT INTO `set_det_data_con` VALUES ('4', 'i18n_set_det_data_con.4.menu_name_n81i', null, ',0,1,', 'netEleWarningInfo');
INSERT INTO `set_det_data_con` VALUES ('5', 'i18n_set_det_data_con.5.menu_name_n81i', null, ',0,', 'emergentwarningInfo');



-- ----------------------------
-- Records of sort_info
-- ----------------------------



-- ----------------------------
-- Records of system_company_config
-- ----------------------------



-- ----------------------------
-- Records of system_gateway_config
-- ----------------------------



-- ----------------------------
-- Records of system_ip_config
-- ----------------------------



-- ----------------------------
-- Records of system_proxy_config
-- ----------------------------



-- ----------------------------
-- Records of system_route_config
-- ----------------------------



-- ----------------------------
-- Records of system_table
-- ----------------------------
INSERT INTO `system_table` VALUES ('100000', 'New Web', 'New Web', '0', '2018-07-12 11:12:09', null, null, null, '10.0.6.127', '167773823', '8080', '0', '1');



-- ----------------------------
-- Records of sys_data_dictionary_item
-- ----------------------------



-- ----------------------------
-- Records of sys_data_dictionary_name
-- ----------------------------



-- ----------------------------
-- Records of sys_sequence
-- ----------------------------
INSERT INTO `sys_sequence` VALUES ('SEQ_CHECK_TYPE_INFO', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_CHECK_TYPE_NAME', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DATA_POLICE_RELATION', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DELECT_INFO_NMSC', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DETECTION_INFO', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DETECTION_INFO_NEW', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DETECTION_INFO_WARNING', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DETECTION_SET_IDEN', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DETECTION_SET_INFO', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DETECT_INFO_CPU', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DETECT_INFO_DISK', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DETECT_INFO_MEMORY', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DETECT_INFO_NETDATA', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DETECT_INFO_PING', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DETECT_INFO_PROCESS', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DETECT_INFO_SNMP_TRAP', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DETECT_INFO_SYSTEM_DATE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DEVICE_BOARDSOLT_BOARD', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DEVICE_BRAND_INFO', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DEVICE_BRAND_TYPE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DEVICE_TYPE_INFO', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DICTIONARY_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_CHECKSET_GRID', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_DPBOARDSTATUSENTRY', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_DPSLOTENTRY', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_DPSYSTEMFANENTRY', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_DPSYSTEMFANENTRY2', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_DPSYSTEMPOWERENTRY', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_DPSYSTEMPOWERENTRY2', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_DPSYSTEMSTATUS', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_IFXTABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_KINGTEST', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_MENCPU', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_SWITCHPORT', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_SYSTEM', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_SYSTEMINFO', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_SYSTEMZG', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_TCT', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_TCT2', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_TCT3', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_TCT4', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_TESTLOCAL', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_DI_TT_INDEX', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_EMAIL_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_EVENT_RECORD_LIBRARY', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_FAIL_COMMUNICATION_INFO', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_GORUP_SYSTEM_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_IMG_URL', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_METADATA', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_MIB_SORT', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_MISSION_FILE_INFORMATION', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_MISSION_PARAMETER_DEFAULTS', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_MISSION_PARAMETER_TABLE1', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_MISSION_PARAMETER_TABLE2', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_MISSION_PARAMETER_TABLE3', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_MISSION_PARAMETER_TABLE4', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_MISSION_PARAMETER_TABLE5', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_MISSION_RESULT_TABLE1', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_MISSION_RESULT_TABLE2', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_MISSION_RESULT_TABLE3', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_MISSION_RESULT_TABLE4', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_MISSION_RESULT_TABLE5', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_MISSION_STATE_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_NMS_ERROR_CODE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_NMS_ERROR_INFO', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_NODEGROUP_ARROW_POSITION', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_NODEGROUP_BGIMG_POSITION', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_NODEGROUP_MEM_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_NODEGROUP_POSITION', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_NODEGROUP_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_NODE_BOX_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_NODE_FIGURE_INFO', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_NODE_IP_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_NODE_LATTICE_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_NODE_POSITION', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_NODE_ROOM_LATTICE_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_NODE_ROOM_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_NODE_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_OID_DICTIONARY', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_OPTION_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_ORDER_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_PLUGIN_INFO', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_POLICE_POINT_SET', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_PROCEDURE_LOG', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_PROEXECINFO', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_PRO_EXEC_LOG', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_SEQ_ID', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_SERVER_IP_SEGMENT', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_SERVER_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_SET_DET_DATA_CON', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_SORT_INFO', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_SYSTEM_TABLE', '100000', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_TABLEDBOPERATIONRPT', '100010', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_TABLEDEPARTMENT', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_TABLELOGINRPT', '100005', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_TABLEUSERDEPARTMENT', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_TABLE_GUIDE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_TESTTRRGGER', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_TEST_BONECP_ZG', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_TROUBLE_STATE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_TYPE_TABLE', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_XT_JS_JBXX', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_XT_JS_MK_GN_INDEX', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_XT_JS_MK_INDEX', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_XT_MK_GN_JBXX', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_XT_MK_JBXX', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_XT_YH_JBXX', '99999', '1');
INSERT INTO `sys_sequence` VALUES ('SEQ_XT_YH_JS_INDEX', '99999', '1');



-- ----------------------------
-- Records of tabledboperationrpt
-- ----------------------------
INSERT INTO `tabledboperationrpt` VALUES ('100000', 'i18n_xt_yh_jbxx.admin.yhmc_n81i', '2018-07-12 11:45:29', 'xt_js_jbxx', null, 'SELECT', 'where zxbz<>2');
INSERT INTO `tabledboperationrpt` VALUES ('100001', 'i18n_xt_yh_jbxx.admin.yhmc_n81i', '2018-07-12 11:45:29', 'nodegroup_table', null, 'SELECT', 'where 1=1 and isValid = 1 order by groupLevel asc,showIndex asc');
INSERT INTO `tabledboperationrpt` VALUES ('100002', 'i18n_xt_yh_jbxx.admin.yhmc_n81i', '2018-07-12 11:45:29', 'xt_js_jbxx', null, 'SELECT', 'where zxbz<>2');
INSERT INTO `tabledboperationrpt` VALUES ('100003', 'i18n_xt_yh_jbxx.admin.yhmc_n81i', '2018-07-12 11:45:29', 'nodegroup_table', null, 'SELECT', 'where 1=1 and isValid = 1 order by groupLevel asc,showIndex asc');
INSERT INTO `tabledboperationrpt` VALUES ('100004', 'i18n_xt_yh_jbxx.admin.yhmc_n81i', '2018-07-12 11:45:29', 'node_table', null, 'SELECT', 'select * from node_table where 1=1 order by node_state asc,Node_createtime desc');
INSERT INTO `tabledboperationrpt` VALUES ('100005', 'i18n_xt_yh_jbxx.admin.yhmc_n81i', '2018-07-12 11:49:54', 'nodegroup_table', null, 'SELECT', 'where 1=1 and isValid = 1 order by groupLevel asc,showIndex asc');
INSERT INTO `tabledboperationrpt` VALUES ('100006', 'i18n_xt_yh_jbxx.admin.yhmc_n81i', '2018-07-12 11:49:54', 'node_table', null, 'SELECT', 'select * from node_table where 1=1 order by node_state asc,Node_createtime desc');
INSERT INTO `tabledboperationrpt` VALUES ('100007', 'i18n_xt_yh_jbxx.admin.yhmc_n81i', '2018-07-12 13:11:19', 'system_table', null, 'SELECT', 'select * from system_table where 1=1 order by system_state asc,systemCreatetime desc');
INSERT INTO `tabledboperationrpt` VALUES ('100008', 'i18n_xt_yh_jbxx.admin.yhmc_n81i', '2018-07-12 13:11:24', 'ServerTable', null, 'SELECT', 'where 1=1');
INSERT INTO `tabledboperationrpt` VALUES ('100009', 'i18n_xt_yh_jbxx.admin.yhmc_n81i', '2018-07-12 13:11:28', 'ServerTable', null, 'SELECT', 'where 1=1');
INSERT INTO `tabledboperationrpt` VALUES ('100010', 'i18n_xt_yh_jbxx.admin.yhmc_n81i', '2018-07-12 13:12:13', 'xt_js_jbxx', null, 'SELECT', 'where zxbz<>2');



-- ----------------------------
-- Records of tabledepartment
-- ----------------------------



-- ----------------------------
-- Records of tableloginrpt
-- ----------------------------
INSERT INTO `tableloginrpt` VALUES ('test', '100000', '127.0.0.1', '2018-07-12 11:26:24', 'i18n_LoginAction.login.in_n81i', '用户名或密码错误');
INSERT INTO `tableloginrpt` VALUES ('test', '100001', '127.0.0.1', '2018-07-12 11:29:06', 'i18n_LoginAction.login.in_n81i', '用户名或密码错误');
INSERT INTO `tableloginrpt` VALUES ('test', '100002', '127.0.0.1', '2018-07-12 11:29:17', 'i18n_LoginAction.login.in_n81i', '用户名或密码错误');
INSERT INTO `tableloginrpt` VALUES ('test', '100003', '127.0.0.1', '2018-07-12 11:40:54', 'i18n_LoginAction.login.in_n81i', '用户名或密码错误');
INSERT INTO `tableloginrpt` VALUES ('test', '100004', '127.0.0.1', '2018-07-12 11:45:02', 'i18n_LoginAction.login.in_n81i', '用户名或密码错误');
INSERT INTO `tableloginrpt` VALUES ('i18n_xt_yh_jbxx.admin.yhmc_n81i', '100005', '127.0.0.1', '2018-07-12 11:45:12', 'i18n_LoginAction.login.in_n81i', 'i18n_LoginAction.login.success_n81i');



-- ----------------------------
-- Records of tableuserdepartment
-- ----------------------------



-- ----------------------------
-- Records of table_guide
-- ----------------------------


-- ----------------------------
-- Records of topo_con_info
-- ----------------------------



-- ----------------------------
-- Records of topo_img
-- ----------------------------
INSERT INTO `topo_img` VALUES ('1', '11.png');
INSERT INTO `topo_img` VALUES ('2', '22.png');
INSERT INTO `topo_img` VALUES ('3', '33.png');
INSERT INTO `topo_img` VALUES ('4', '44.png');
INSERT INTO `topo_img` VALUES ('5', '55.png');
INSERT INTO `topo_img` VALUES ('6', '66.png');
INSERT INTO `topo_img` VALUES ('7', '77.png');
INSERT INTO `topo_img` VALUES ('8', '88.png');
INSERT INTO `topo_img` VALUES ('9', '99.png');
INSERT INTO `topo_img` VALUES ('10', 'clound2.png');



-- ----------------------------
-- Records of topo_info
-- ----------------------------
INSERT INTO `topo_info` VALUES ('1', 'topo1', '100000', '800', '800', '', '2018-08-14', '0', '2018-08-14', '0', null, null, '1');
INSERT INTO `topo_info` VALUES ('2', 'topo2', '-1', '800', '800', '', '2018-08-14', '0', '2018-08-14', '0', null, null, '1');


-- ----------------------------
-- Records of topo_line_info
-- ----------------------------
INSERT INTO `topo_line_info` VALUES ('1', '1', '30', '[{newLineMethod:\"FoldLink\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('2', '2', '30', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"10\"},{direction:\"horizontal\"},{nodeIndex:\"-0.25\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('3', '3', '30', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"55\"},{direction:\"horizontal\"},{nodeIndex:\"0.25\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('4', '4', '31', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"65\"},{direction:\"horizontal\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('5', '5', '31', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"65\"},{direction:\"horizontal\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('6', '6', '31', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"65\"},{direction:\"horizontal\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('7', '7', '31', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"65\"},{direction:\"horizontal\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('8', '8', '31', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"65\"},{direction:\"horizontal\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('9', '30', '9', null, '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('10', '31', '9', null, '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('11', '10', '11', '', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('12', '11', '9', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"77\"},{direction:\"vertical\"},{nodeIndex:\"1.25\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('13', '12', '9', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"77\"},{direction:\"vertical\"},{nodeIndex:\"-0.5\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('14', '13', '9', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"77\"},{direction:\"vertical\"},{nodeIndex:\"-0.5\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('15', '14', '9', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"77\"},{direction:\"vertical\"},{nodeIndex:\"-0.5\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('16', '15', '9', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"77\"},{direction:\"vertical\"},{nodeIndex:\"-0.5\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('17', '9', '16', null, '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('18', '21', '22', null, '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('19', '22', '18', '', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('20', '22', '20', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"34\"},{direction:\"horizontal\"},{nodeIndex:\"-0.75\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('21', '22', '19', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"34\"},{direction:\"horizontal\"},{nodeIndex:\"0.75\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('22', '20', '18', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"40\"},{direction:\"horizontal\"},{nodeIndex:\"-0.75\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('23', '19', '18', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"40\"},{direction:\"horizontal\"},{nodeIndex:\"0.75\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('24', '9', '22', null, '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('25', '17', '22', '[{newLineMethod:\"FoldLink\"},{nodeIndex:\"-0.5\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('26', '17', '29', null, '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('27', '18', '23', null, '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('28', '16', '24', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"45\"},{direction:\"horizontal\"},{nodeIndex:\"-0.5\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('29', '16', '25', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"45\"},{direction:\"horizontal\"},{nodeIndex:\"-0.5\"}]', '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('30', '29', '26', null, '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('31', '29', '27', null, '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('32', '29', '28', null, '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('33', '18', '29', null, '', null, null, null, null, '1', '1');
INSERT INTO `topo_line_info` VALUES ('34', '48', '51', null, '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('35', '44', '48', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"70\"},{direction:\"vertical\"}]', '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('36', '45', '48', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"70\"},{direction:\"vertical\"}]', '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('37', '46', '48', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"70\"},{direction:\"vertical\"}]', '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('38', '47', '48', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"70\"},{direction:\"vertical\"}]', '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('39', '48', '49', null, '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('40', '50', '49', null, '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('41', '48', '42', null, '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('42', '42', '41', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"50\"},{direction:\"horizontal\"},{nodeIndex:\"-0.5\"}]', '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('43', '42', '43', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"50\"},{direction:\"horizontal\"},{nodeIndex:\"-0.5\"}]', '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('44', '49', '32', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"47\"},{direction:\"horizontal\"},{nodeIndex:\"-0.75\"}]', '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('45', '49', '33', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"47\"},{direction:\"horizontal\"},{nodeIndex:\"0.75\"}]', '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('46', '34', '49', null, '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('47', '32', '34', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"53\"},{direction:\"horizontal\"},{nodeIndex:\"-0.75\"}]', '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('48', '33', '34', '[{newLineMethod:\"FlexionalLink\"},{offsetGap:\"53\"},{direction:\"horizontal\"},{nodeIndex:\"0.75\"}]', '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('49', '34', '35', null, '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('50', '40', '49', '[{newLineMethod:\"FoldLink\"},{nodeIndex:\"-0.5\"}]', '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('51', '40', '39', null, '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('52', '39', '36', null, '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('53', '39', '37', null, '', null, null, null, null, '2', '1');
INSERT INTO `topo_line_info` VALUES ('54', '39', '38', null, '', null, null, null, null, '2', '1');


-- ----------------------------
-- Records of topo_node_info
-- ----------------------------
INSERT INTO `topo_node_info` VALUES ('1', '5', '1', '4', '2', '783', '-280', '50', '50', null, null, null, null, 'Region Center 1', null, '');
INSERT INTO `topo_node_info` VALUES ('2', '5', '1', '4', '3', '783', '-191', '50', '50', null, null, null, null, 'Region Center 2', null, '');
INSERT INTO `topo_node_info` VALUES ('3', '5', '1', '4', '4', '783', '-53', '50', '50', null, null, null, null, 'Region Center 17', null, '');
INSERT INTO `topo_node_info` VALUES ('4', '9', '1', '2', '100009', '659', '14', '50', '50', null, null, null, null, 'Integrated Management', null, '');
INSERT INTO `topo_node_info` VALUES ('5', '9', '1', '2', '100009', '659', '71', '50', '50', null, null, null, null, 'Operation and Maintenanee', null, '');
INSERT INTO `topo_node_info` VALUES ('6', '9', '1', '2', '100009', '659', '128', '50', '50', null, null, null, null, 'Data Collector', null, '');
INSERT INTO `topo_node_info` VALUES ('7', '9', '1', '2', '100009', '659', '188', '50', '50', null, null, null, null, 'Data Analysis & Statistics', null, '');
INSERT INTO `topo_node_info` VALUES ('8', '9', '1', '2', '100009', '659', '254', '50', '50', null, null, null, null, 'Data Store & Index', null, '');
INSERT INTO `topo_node_info` VALUES ('9', '8', '1', '2', '100004', '397', '146', '50', '50', null, null, null, null, 'Core Switch', null, '[{textPosition:\"Bottom_Left\"}]');
INSERT INTO `topo_node_info` VALUES ('10', '6', '1', '3', null, '659', '350', '50', '50', null, null, null, null, 'Big Screen', null, '');
INSERT INTO `topo_node_info` VALUES ('11', '7', '1', '2', '100004', '500', '350', '50', '50', null, null, null, null, 'Visualization\\nAccess Switch', null, '[{textPosition:\"Bottom_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('12', '2', '1', '2', '100004', '-73', '350', '50', '50', null, null, null, null, 'Time Sync', null, '');
INSERT INTO `topo_node_info` VALUES ('13', '9', '1', '2', '100004', '338', '350', '50', '50', null, null, null, null, 'File Digest Analysis', null, '');
INSERT INTO `topo_node_info` VALUES ('14', '9', '1', '2', '100004', '208', '350', '50', '50', null, null, null, null, 'Configure and Log\\nManagement', null, '[{textPosition:\"Bottom_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('15', '9', '1', '2', '100004', '57', '350', '50', '50', null, null, null, null, 'Operation and Maintenance\\n    Management System', null, '');
INSERT INTO `topo_node_info` VALUES ('16', '3', '1', '2', '100004', '200', '146', '50', '50', null, null, null, null, 'ISPs Logs\\nTraffic Analysis', null, '[{textPosition:\"Bottom_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('17', '4', '1', '1', '100001', '238', '26', '50', '50', null, null, null, null, 'Block Router', null, '');
INSERT INTO `topo_node_info` VALUES ('18', '4', '1', '1', '100001', '150', '-209', '50', '50', null, null, null, null, 'In-Line Block\\nRouter', null, '[{textPosition:\"Bottom_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('19', '1', '1', '1', '100001', '280', '-124', '50', '50', null, null, null, null, 'National Cache MITM', null, '[{textPosition:\"Bottom_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('20', '1', '1', '1', '100001', '280', '-288', '50', '50', null, null, null, null, 'Traffic Analysis', null, '[{textPosition:\"Top_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('21', '1', '1', '1', '100001', '525', '-211', '50', '50', null, null, null, null, 'Traffic Deep\\nAnalysis', null, '[{textPosition:\"Bottom_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('22', '7', '1', '1', '100001', '397', '-211', '50', '50', null, null, null, null, 'Access Switch', null, '[{textPosition:\"Top_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('23', '4', '1', '1', '100001', '14', '-211', '50', '50', null, null, null, null, 'ISPs Ring Network\\nCore Router', null, '[{textPosition:\"Bottom_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('24', '10', '1', '1', '100001', '60', '108', '50', '50', null, null, null, null, 'ISPs Radius\\nData', null, '[{textPosition:\"Middle_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('25', '10', '1', '1', '100001', '60', '188', '50', '50', null, null, null, null, 'ISPs Radius\\nData', null, '[{textPosition:\"Middle_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('26', '10', '1', '2', '100004', '-130', '-66', '50', '50', null, null, null, null, 'IPS 1\\nNetwork', null, '[{textPosition:\"Middle_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('27', '10', '1', '2', '100004', '-130', '26', '50', '50', null, null, null, null, 'IPS 2\\nNetwork', null, '[{textPosition:\"Middle_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('28', '10', '1', '2', '100004', '-130', '122', '50', '50', null, null, null, null, 'IPS 3\\nNetwork', null, '[{textPosition:\"Middle_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('29', '4', '1', '1', '100001', '14', '26', '50', '50', null, null, null, null, 'ISPs Backbone\\nCore Router', null, '[{textPosition:\"Bottom_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('30', '7', '1', '1', '100001', '621', '-191', '50', '50', null, null, null, null, 'Access\\nSwitch', null, '[{textPosition:\"Top_Right\"}]');
INSERT INTO `topo_node_info` VALUES ('31', '7', '1', '1', '100001', '479', '146', '50', '50', null, null, null, null, 'Main Control\\nAccess Switch', null, '[{textPosition:\"Bottom_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('32', '1', '2', '1', '100001', '308', '-168', '50', '50', null, null, null, null, 'Traffic Analysis', null, '[{textPosition:\"Top_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('33', '1', '2', '1', '100001', '308', '-46', '50', '50', null, null, null, null, 'National Cache MITM', null, '');
INSERT INTO `topo_node_info` VALUES ('34', '4', '2', '1', '100001', '152', '-107', '50', '50', null, null, null, null, 'In-Line Block\\nRouter', null, '[{textPosition:\"Bottom_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('35', '4', '2', '1', '100001', '-12', '-106', '50', '50', null, null, null, null, 'ISPs Ring Network\\nCore Router', null, '[{textPosition:\"Bottom_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('36', '10', '2', '2', '100004', '-82', '-10', '50', '50', null, null, null, null, 'IPS 1', null, '');
INSERT INTO `topo_node_info` VALUES ('37', '10', '2', '2', '100004', '-82', '86', '50', '50', null, null, null, null, 'IPS 2', null, '');
INSERT INTO `topo_node_info` VALUES ('38', '10', '2', '2', '100004', '-82', '189', '50', '50', null, null, null, null, 'IPS 3', null, '');
INSERT INTO `topo_node_info` VALUES ('39', '4', '2', '1', '100001', '80', '86', '50', '50', null, null, null, null, 'ISPs Backbone Core Router', null, '');
INSERT INTO `topo_node_info` VALUES ('40', '4', '2', '1', '100001', '295', '89', '50', '50', null, null, null, null, 'Block Router', null, '');
INSERT INTO `topo_node_info` VALUES ('41', '10', '2', '1', '100001', '72', '198', '50', '50', null, null, null, null, 'ISPs Radius Data', null, '');
INSERT INTO `topo_node_info` VALUES ('42', '3', '2', '1', '100001', '222', '239', '50', '50', null, null, null, null, 'ISPs Logs\\nTraffic Analysis', null, '[{textPosition:\"Bottom_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('43', '10', '2', '1', '100001', '72', '297', '50', '50', null, null, null, null, 'ISPs Radius Data', null, '');
INSERT INTO `topo_node_info` VALUES ('44', '2', '2', '1', '100001', '139', '429', '50', '50', null, null, null, null, 'Time Sync', null, '');
INSERT INTO `topo_node_info` VALUES ('45', '9', '2', '1', '100001', '328', '429', '50', '50', null, null, null, null, 'Operation and Maintenance\\n    Management System', null, '[{textPosition:\"Bottom_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('46', '9', '2', '1', '100001', '495', '429', '50', '50', null, null, null, null, 'Configure and Log\\nManagement', null, '[{textPosition:\"Bottom_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('47', '9', '2', '1', '100001', '666', '429', '50', '50', null, null, null, null, 'File Digest Analysis', null, '');
INSERT INTO `topo_node_info` VALUES ('48', '8', '2', '1', '100001', '452', '239', '50', '50', null, null, null, null, 'Core Switch', null, '[{textPosition:\"Top_Right\"}]');
INSERT INTO `topo_node_info` VALUES ('49', '7', '2', '1', '100001', '453', '-107', '50', '50', null, null, null, null, 'Access Switch', null, '[{textPosition:\"Top_Center\"}]');
INSERT INTO `topo_node_info` VALUES ('50', '1', '2', '1', '100001', '597', '-107', '50', '50', null, null, null, null, 'Traffic Deep Analysis', null, '');
INSERT INTO `topo_node_info` VALUES ('51', '5', '2', '4', '1', '783', '239', '50', '50', null, null, null, null, 'National Center', null, '');


-- ----------------------------
-- Records of trouble_state
-- ----------------------------



-- ----------------------------
-- Records of type_table
-- ----------------------------
INSERT INTO `type_table` VALUES ('1', '1', '0', 'i18n_type_table.1.type_desc_n81i', 'i18n_type_table.1.type_name_n81i', 'showAutoAlarm');
INSERT INTO `type_table` VALUES ('2', '1', '0', 'i18n_type_table.2.type_desc_n81i', 'i18n_type_table.2.type_name_n81i', 'isIdentical');
INSERT INTO `type_table` VALUES ('3', '1', '0', 'i18n_type_table.3.type_desc_n81i', 'i18n_type_table.3.type_name_n81i', 'detecWarningLevel');
INSERT INTO `type_table` VALUES ('4', '10', '0', 'i18n_type_table.4.type_desc_n81i', 'i18n_type_table.4.type_name_n81i', 'emailflag');
INSERT INTO `type_table` VALUES ('5', '3', '0', null, 'i18n_type_table.5.type_name_n81i', 'netelementtype');
INSERT INTO `type_table` VALUES ('6', '5', '0', 'i18n_type_table.6.type_desc_n81i', 'i18n_type_table.6.type_name_n81i', 'emergent');
INSERT INTO `type_table` VALUES ('7', '1', '0', null, 'i18n_type_table.7.type_name_n81i', 'dpfan');
INSERT INTO `type_table` VALUES ('8', '2', '0', null, 'i18n_type_table.8.type_name_n81i', 'diskwritestate');
INSERT INTO `type_table` VALUES ('9', '13', '0', 'i18n_type_table.9.type_desc_n81i', 'i18n_type_table.9.type_name_n81i', 'monitorStatusInfo');



-- ----------------------------
-- Records of update_model_rz
-- ----------------------------



-- ----------------------------
-- Records of upload_file_rz
-- ----------------------------


-- ----------------------------
-- Records of xt_js_jbxx
-- ----------------------------
INSERT INTO `xt_js_jbxx` VALUES ('i18n_xt_js_jbxx.1.jsmc_n81i', '1', '0', 'i18n_xt_js_jbxx.1.jsms_n81i', null, '1');
INSERT INTO `xt_js_jbxx` VALUES ('i18n_xt_js_jbxx.2.jsmc_n81i', '2', '0', 'i18n_xt_js_jbxx.2.jsms_n81i', null, null);
INSERT INTO `xt_js_jbxx` VALUES ('i18n_xt_js_jbxx.3.jsmc_n81i', '3', '0', 'i18n_xt_js_jbxx.3.jsms_n81i', null, null);
INSERT INTO `xt_js_jbxx` VALUES ('i18n_xt_js_jbxx.21.jsmc_n81i', '21', '0', 'i18n_xt_js_jbxx.21.jsms_n81i', null, null);
INSERT INTO `xt_js_jbxx` VALUES ('i18n_xt_js_jbxx.224.jsmc_n81i', '224', '0', 'i18n_xt_js_jbxx.224.jsms_n81i', null, null);
INSERT INTO `xt_js_jbxx` VALUES ('i18n_xt_js_jbxx.225.jsmc_n81i', '225', '0', 'i18n_xt_js_jbxx.225.jsms_n81i', null, null);



-- ----------------------------
-- Records of xt_js_mk_index
-- ----------------------------
INSERT INTO `xt_js_mk_index` VALUES ('6259', '267', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6261', '269', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6262', '311', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6263', '312', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6264', '313', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6265', '314', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6266', '315', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6267', '270', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6268', '308', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6269', '309', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6270', '310', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6271', '271', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6272', '303', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6273', '304', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6274', '305', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6275', '306', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6276', '307', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6277', '272', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6278', '273', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6279', '300', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6280', '301', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6281', '302', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6282', '274', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6283', '298', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6284', '299', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6285', '275', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6286', '294', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6287', '295', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6288', '296', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6289', '297', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6290', '276', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6291', '290', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6292', '291', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6293', '292', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6294', '293', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6297', '278', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6298', '288', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6299', '289', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6301', '361', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6302', '421', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6303', '461', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6304', '462', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6305', '521', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6306', '279', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6307', '280', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6308', '281', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6309', '282', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6310', '283', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6311', '284', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6312', '261', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6313', '262', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6314', '263', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6315', '264', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6316', '266', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6317', '285', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6318', '381', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6319', '441', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6321', '501', '61', null);
INSERT INTO `xt_js_mk_index` VALUES ('6882', '1', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6883', '9', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6884', '10', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6885', '11', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6886', '12', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6887', '13', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6888', '14', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6889', '15', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6890', '16', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6891', '17', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6892', '267', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6894', '269', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6895', '311', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6896', '312', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6897', '313', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6898', '314', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6899', '315', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6900', '270', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6901', '308', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6902', '309', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6903', '310', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6904', '271', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6905', '303', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6906', '304', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6907', '305', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6908', '306', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6909', '307', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6910', '272', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6911', '273', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6912', '300', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6913', '301', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6914', '302', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6915', '274', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6916', '298', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6917', '299', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6918', '275', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6919', '294', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6920', '295', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6921', '296', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6922', '297', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6923', '276', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6924', '290', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6925', '291', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6926', '292', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6927', '293', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6930', '288', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6931', '289', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6933', '361', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6934', '421', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6935', '461', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6936', '462', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6937', '521', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6938', '279', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6939', '280', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6940', '281', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6941', '282', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6942', '283', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6943', '284', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6944', '261', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6945', '262', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6946', '263', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6947', '264', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6948', '266', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6949', '285', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6950', '381', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6951', '441', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6953', '501', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6954', '541', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6955', '542', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6956', '543', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6957', '544', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6958', '545', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6959', '546', '201', null);
INSERT INTO `xt_js_mk_index` VALUES ('6960', '1', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6961', '9', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6962', '10', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6963', '11', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6964', '12', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6965', '13', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6966', '14', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6967', '15', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6968', '16', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6969', '17', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6970', '267', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6972', '269', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6973', '311', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6974', '312', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6975', '313', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6976', '314', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6977', '315', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6978', '270', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6979', '308', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6980', '309', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6981', '310', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6982', '271', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6983', '303', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6984', '304', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6985', '305', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6986', '306', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6987', '307', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6988', '272', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6989', '273', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6990', '300', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6991', '301', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6992', '302', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6993', '274', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6994', '298', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6995', '299', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6996', '275', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6997', '294', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6998', '295', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('6999', '296', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('7000', '297', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('7001', '276', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('7002', '290', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('7003', '291', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('7004', '292', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('7005', '293', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('7008', '288', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('7009', '289', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('7011', '361', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('7012', '421', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('7013', '461', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('7014', '462', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('7015', '521', '221', '2015-10-20 09:44:46');
INSERT INTO `xt_js_mk_index` VALUES ('7996', '1', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('7997', '9', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('7998', '10', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('7999', '11', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8000', '12', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8001', '13', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8002', '14', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8003', '15', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8004', '16', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8005', '17', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8006', '267', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8007', '269', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8008', '311', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8009', '312', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8010', '313', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8011', '314', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8012', '315', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8013', '270', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8014', '308', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8015', '309', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8016', '310', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8017', '271', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8018', '303', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8019', '304', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8020', '305', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8021', '306', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8022', '307', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8023', '272', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8024', '273', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8025', '300', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8026', '301', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8027', '302', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8028', '274', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8029', '298', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8030', '299', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8031', '275', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8032', '294', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8033', '295', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8034', '296', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8035', '297', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8036', '276', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8037', '290', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8038', '291', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8039', '292', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8040', '293', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8041', '288', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8042', '289', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8043', '361', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8044', '421', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8045', '461', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8046', '462', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8047', '521', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8049', '279', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8050', '280', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8051', '281', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8052', '282', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8053', '283', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8054', '284', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8055', '261', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8056', '262', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8057', '263', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8058', '264', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8059', '266', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8060', '285', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8061', '381', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8062', '441', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8063', '501', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8064', '541', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8065', '542', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8066', '543', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8067', '544', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8068', '545', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8069', '546', '1', null);
INSERT INTO `xt_js_mk_index` VALUES ('8128', '267', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8129', '269', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8130', '311', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8131', '312', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8132', '313', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8133', '314', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8134', '315', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8135', '270', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8136', '308', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8137', '309', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8138', '310', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8139', '271', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8140', '303', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8141', '304', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8142', '305', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8143', '306', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8144', '307', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8145', '272', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8146', '273', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8147', '300', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8148', '301', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8149', '302', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8150', '274', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8151', '298', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8152', '299', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8153', '275', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8154', '294', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8155', '295', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8156', '296', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8157', '297', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8158', '276', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8159', '290', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8160', '291', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8161', '292', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8162', '293', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8163', '288', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8164', '289', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8165', '361', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8166', '421', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8167', '461', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8168', '462', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8169', '521', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8171', '279', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8172', '280', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8173', '281', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8174', '282', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8175', '283', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8176', '284', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8177', '261', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8178', '262', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8179', '263', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8180', '264', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8181', '266', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8182', '285', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8183', '381', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8184', '441', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8185', '501', '3', null);
INSERT INTO `xt_js_mk_index` VALUES ('8186', '279', '21', null);
INSERT INTO `xt_js_mk_index` VALUES ('8187', '283', '21', null);
INSERT INTO `xt_js_mk_index` VALUES ('8188', '284', '21', null);
INSERT INTO `xt_js_mk_index` VALUES ('8189', '261', '21', null);
INSERT INTO `xt_js_mk_index` VALUES ('8190', '262', '21', null);
INSERT INTO `xt_js_mk_index` VALUES ('8191', '263', '21', null);
INSERT INTO `xt_js_mk_index` VALUES ('8192', '264', '21', null);
INSERT INTO `xt_js_mk_index` VALUES ('8193', '266', '21', null);
INSERT INTO `xt_js_mk_index` VALUES ('8194', '285', '21', null);
INSERT INTO `xt_js_mk_index` VALUES ('8195', '381', '21', null);
INSERT INTO `xt_js_mk_index` VALUES ('8196', '441', '21', null);
INSERT INTO `xt_js_mk_index` VALUES ('8197', '501', '21', null);
INSERT INTO `xt_js_mk_index` VALUES ('8198', '267', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8199', '269', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8200', '311', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8201', '312', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8202', '313', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8203', '314', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8204', '315', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8205', '270', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8206', '308', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8207', '309', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8208', '310', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8209', '271', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8210', '303', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8211', '304', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8212', '305', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8213', '306', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8214', '307', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8215', '272', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8216', '273', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8217', '300', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8218', '301', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8219', '302', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8220', '274', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8221', '298', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8222', '299', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8223', '275', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8224', '294', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8225', '295', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8226', '296', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8227', '297', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8228', '276', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8229', '290', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8230', '291', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8231', '292', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8232', '293', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8233', '288', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8234', '289', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8235', '361', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8236', '421', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8237', '461', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8238', '462', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8239', '521', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8241', '279', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8242', '283', '224', null);
INSERT INTO `xt_js_mk_index` VALUES ('8298', '279', '225', null);
INSERT INTO `xt_js_mk_index` VALUES ('8299', '283', '225', null);
INSERT INTO `xt_js_mk_index` VALUES ('8300', '284', '225', null);
INSERT INTO `xt_js_mk_index` VALUES ('8301', '261', '225', null);
INSERT INTO `xt_js_mk_index` VALUES ('8302', '262', '225', null);
INSERT INTO `xt_js_mk_index` VALUES ('8303', '263', '225', null);
INSERT INTO `xt_js_mk_index` VALUES ('8304', '264', '225', null);
INSERT INTO `xt_js_mk_index` VALUES ('8305', '266', '225', null);
INSERT INTO `xt_js_mk_index` VALUES ('8306', '285', '225', null);
INSERT INTO `xt_js_mk_index` VALUES ('8307', '381', '225', null);
INSERT INTO `xt_js_mk_index` VALUES ('8308', '441', '225', null);
INSERT INTO `xt_js_mk_index` VALUES ('8309', '501', '225', null);
INSERT INTO `xt_js_mk_index` VALUES ('8310', '1', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8311', '9', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8312', '10', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8313', '11', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8314', '12', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8315', '13', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8316', '14', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8317', '15', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8318', '16', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8319', '17', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8320', '267', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8321', '269', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8322', '311', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8323', '312', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8324', '313', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8325', '314', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8326', '315', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8327', '270', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8328', '308', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8329', '309', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8330', '310', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8331', '271', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8332', '303', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8333', '304', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8334', '305', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8335', '306', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8336', '307', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8337', '272', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8338', '273', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8339', '300', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8340', '301', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8341', '302', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8342', '274', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8343', '298', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8344', '299', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8345', '275', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8346', '294', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8347', '295', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8348', '296', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8349', '297', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8350', '276', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8351', '290', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8352', '291', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8353', '292', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8354', '293', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8355', '288', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8356', '289', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8357', '361', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8358', '421', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8359', '461', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8360', '462', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8361', '521', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8363', '279', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8364', '280', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8365', '281', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8366', '282', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8367', '283', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8368', '284', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8369', '261', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8370', '262', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8371', '263', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8372', '264', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8373', '266', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8374', '285', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8375', '381', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8376', '441', '2', null);
INSERT INTO `xt_js_mk_index` VALUES ('8377', '501', '2', null);



-- ----------------------------
-- Records of xt_mk_jbxx
-- ----------------------------
INSERT INTO `xt_mk_jbxx` VALUES ('1', '0', '0_0001', 'i18n_xt_mk_jbxx.1.mkmc_n81i', 'i18n_xt_mk_jbxx.1.mkms_n81i', '/main/welcome.html', null, '0', null, 'xtpz_b.png', null, null, '1', '7', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('2', '0', '0_0002', 'i18n_xt_mk_jbxx.279.mkmc_n81i', 'i18n_xt_mk_jbxx.2.mkms_n81i', '模块名称', null, '1', null, 'ywpz_b.png', null, '0', '1', '6', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('3', '0', '0_0003', 'i18n_xt_mk_jbxx.3.mkmc_n81i', 'i18n_xt_mk_jbxx.275.mkms_n81i', 'tmp_js', null, '1', null, 'ywpz_b.png', null, '0', '1', '5', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('4', '0', '0_0004', 'i18n_xt_mk_jbxx.4.mkmc_n81i', 'i18n_xt_mk_jbxx.4.mkms_n81i', 'tmp_js', null, '1', null, 'ywpz_b.png', null, '0', '1', '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('5', '0', '0_0005', 'i18n_xt_mk_jbxx.5.mkmc_n81i', null, 'tmp_js', null, '1', null, 'xtpz_b.png', null, '0', '1', '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('6', '0', '0_0006', 'i18n_xt_mk_jbxx.6.mkmc_n81i', 'i18n_xt_mk_jbxx.6.mkms_n81i', 'tmp_js', null, '1', null, 'ywpz_b.png', null, '0', '1', '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('7', '0', '0_0007', 'i18n_xt_mk_jbxx.284.mkmc_n81i', 'i18n_xt_mk_jbxx.284.mkmc_n81i', '/url', null, '1', null, 'ywpz_b.png', null, '0', '1', '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('8', '1', '0_0001_0001', 'i18n_xt_mk_jbxx.283.mkmc_n81i', 'i18n_xt_mk_jbxx.283.mkmc_n81i', '/sysManage/sysPopedomManage!execute.do?action=updateSelfInfo', null, '1', null, null, null, '0', '2', '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('9', '1', '0_0001_0002', 'i18n_xt_mk_jbxx.9.mkmc_n81i', 'i18n_xt_mk_jbxx.9.mkms_n81i', '/sysManage/dataDictionary.do?action=query', null, '0', null, null, null, '0', '2', '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('10', '9', '0_0001_0002_0001', 'i18n_xt_mk_jbxx.10.mkmc_n81i', null, null, null, '0', null, null, 'addRecord', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('11', '1', '0_0001_0003', 'i18n_xt_mk_jbxx.11.mkms_n81i', 'i18n_xt_mk_jbxx.11.mkms_n81i', '/sysManage/sysErrorManage!execute.do?action=queryError', null, '0', null, null, null, '0', '2', '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('12', '11', '0_0001_0003_0001', 'i18n_xt_mk_jbxx.10.mkmc_n81i', 'i18n_xt_mk_jbxx.12.mkms_n81i', null, null, '0', null, null, 'addRecord', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('13', '11', '0_0001_0003_0002', 'i18n_xt_mk_jbxx.309.mkmc_n81i', 'i18n_xt_mk_jbxx.13.mkms_n81i', null, null, '0', null, null, 'updateRecord', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('14', '1', '0_0001_0000', 'i18n_xt_mk_jbxx.14.mkmc_n81i', 'i18n_xt_mk_jbxx.14.mkms_n81i', '/functionManager/functionManager.do?action=queryMkInfo', null, '0', null, 'ywpz_b.png', null, '0', '2', '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('15', '14', '0_0001_0002_0001', 'i18n_xt_mk_jbxx.309.mkmc_n81i', 'i18n_xt_mk_jbxx.309.mkmc_n81i', 'delMk', null, '0', null, null, 'updateMk', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('16', '14', '0_0001_0002_0002', 'i18n_xt_mk_jbxx.16.mkmc_n81i', 'i18n_xt_mk_jbxx.10.mkmc_n81i', null, null, '0', null, null, 'addZMk', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('17', '14', '0_0001_0002_0003', 'i18n_xt_mk_jbxx.17.mkms_n81i', 'i18n_xt_mk_jbxx.17.mkms_n81i', null, null, '0', null, null, 'addMk', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('18', '2', '0_0002_0001', 'i18n_xt_mk_jbxx.18.mkmc_n81i', null, '/deptManage/deptManage!execute.do?action=queryDeptInfo', null, '1', null, null, null, '0', '2', '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('19', '2', '0_0002_0002', 'i18n_xt_mk_jbxx.19.mkmc_n81i', 'i18n_xt_mk_jbxx.19.mkms_n81i', '/sysManage/sysPopedomManage!execute.do?action=queryJsInfo', null, '1', null, null, null, '0', '2', '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('20', '2', '0_0002_0003', 'i18n_xt_mk_jbxx.282.mkmc_n81i', null, '/sysManage/sysPopedomManage!execute.do?action=queryUserInfo', null, '1', null, null, null, '0', '2', '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('21', '2', '0_0002_0004', 'i18n_xt_mk_jbxx.21.mkmc_n81i', 'i18n_xt_mk_jbxx.21.mkms_n81i', '/sysManage/userGroupPerssion.do?action=query', null, '1', null, null, null, '0', null, '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('22', '21', '0_0002_0004_0001', 'i18n_xt_mk_jbxx.10.mkmc_n81i', 'i18n_xt_mk_jbxx.22.mkms_n81i', null, null, '0', null, null, 'addRecord', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('23', '3', '0_0003_0001', 'i18n_xt_mk_jbxx.275.mkms_n81i', 'i18n_xt_mk_jbxx.23.mkms_n81i', '/sysManage/systemManage.do?action=query', null, '1', null, null, null, null, null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('24', '23', '0_0003_0001_0001', 'i18n_xt_mk_jbxx.10.mkmc_n81i', 'i18n_xt_mk_jbxx.24.mkms_n81i', null, null, '0', null, null, 'addSystem', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('25', '23', '0_0003_0001_0002', 'i18n_xt_mk_jbxx.309.mkmc_n81i', 'i18n_xt_mk_jbxx.309.mkmc_n81i', null, null, '0', null, null, 'updateSystem', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('26', '23', '0_0003_0001_0003', 'i18n_xt_mk_jbxx.293.mkmc_n81i', 'i18n_xt_mk_jbxx.26.mkms_n81i', null, null, '0', null, null, 'stopSystem', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('27', '23', '0_0003_0001_0004', 'i18n_xt_mk_jbxx.299.mkmc_n81i', 'i18n_xt_mk_jbxx.27.mkms_n81i', null, null, '0', null, null, 'startSystem', '1', null, '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('28', '3', '0_0003_0002', 'i18n_xt_mk_jbxx.28.mkmc_n81i', 'i18n_xt_mk_jbxx.28.mkms_n81i', '/serverManager/serverManager.do?action=query', null, '1', null, null, null, '0', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('29', '28', '0_0003_0002_0001', 'i18n_xt_mk_jbxx.10.mkmc_n81i', null, null, null, '0', null, null, 'openAdd', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('30', '28', '0_0003_0002_0002', 'i18n_xt_mk_jbxx.293.mkmc_n81i', null, null, null, '0', null, null, 'stopServer', '1', null, '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('31', '28', '0_0003_0002_0003', 'i18n_xt_mk_jbxx.309.mkmc_n81i', null, null, null, '0', null, null, 'openUpdate', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('32', '28', '0_0003_0002_0004', 'i18n_xt_mk_jbxx.299.mkmc_n81i', null, null, null, '0', null, null, 'startServer', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('33', '4', '0_0004_0001', 'i18n_xt_mk_jbxx.33.mkmc_n81i', 'i18n_xt_mk_jbxx.33.mkms_n81i', '/sysManage/nodeGroupManage.do?action=query', null, '1', null, null, null, '0', null, null, '0');
INSERT INTO `xt_mk_jbxx` VALUES ('34', '33', '0_0004_0001_0001', 'i18n_xt_mk_jbxx.10.mkmc_n81i', 'i18n_xt_mk_jbxx.34.mkms_n81i', null, null, '1', null, null, 'addNodeGroup', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('35', '33', '0_0004_0001_0002', 'i18n_xt_mk_jbxx.309.mkmc_n81i', 'i18n_xt_mk_jbxx.35.mkms_n81i', null, null, '1', null, null, 'updateNodeGroup', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('36', '33', '0_0004_0001_0003', 'i18n_xt_mk_jbxx.36.mkmc_n81i', 'i18n_xt_mk_jbxx.36.mkms_n81i', null, null, '1', null, null, 'nodeMgmt', '1', null, null, '0');
INSERT INTO `xt_mk_jbxx` VALUES ('37', '33', '0_0004_0001_0004', 'xt_mk_jbxx.306.mkmc', 'i18n_xt_mk_jbxx.37.mkms_n81i', null, null, '1', null, null, 'stopNodeGroup', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('38', '33', '0_0004_0001_0005', 'i18n_xt_mk_jbxx.307.mkmc_n81i', 'i18n_xt_mk_jbxx.38.mkms_n81i', null, null, '1', null, null, 'startNodeGroup', '1', null, '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('39', '4', '0_0004_0002', 'i18n_xt_mk_jbxx.39.mkmc_n81i', 'i18n_xt_mk_jbxx.39.mkms_n81i', '/nodeGroupManage/nodeGroupManage!execute.do?action=queryNodeGroupInfo', null, '1', null, null, null, '0', '2', '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('40', '39', '0_0004_0002_0001', 'i18n_xt_mk_jbxx.40.mkmc_n81i', 'i18n_xt_mk_jbxx.40.mkms_n81i', null, null, '1', null, null, 'addSubNodeGroup', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('41', '39', '0_0004_0002_0002', 'i18n_xt_mk_jbxx.41.mkmc_n81i', 'i18n_xt_mk_jbxx.41.mkms_n81i', null, null, '1', null, null, 'addMainNodeGroup', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('42', '39', '0_0004_0002_0003', 'i18n_xt_mk_jbxx.309.mkmc_n81i', 'i18n_xt_mk_jbxx.42.mkms_n81i', null, null, '1', null, null, 'updateNodeGroup', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('43', '39', '0_0004_0002_0004', 'i18n_xt_mk_jbxx.43.mkmc_n81i', 'i18n_xt_mk_jbxx.43.mkms_n81i', null, null, '1', null, null, 'nodeManage', '1', null, null, '0');
INSERT INTO `xt_mk_jbxx` VALUES ('44', '39', '0_0004_0002_0005', 'i18n_xt_mk_jbxx.293.mkmc_n81i', 'i18n_xt_mk_jbxx.44.mkms_n81i', null, null, '0', null, null, 'stopNodeGroup', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('45', '39', '0_0004_0002_0005', 'i18n_xt_mk_jbxx.299.mkmc_n81i', 'i18n_xt_mk_jbxx.45.mkms_n81i', null, null, '0', null, null, 'startNodeGroup', '1', null, '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('46', '5', null, 'i18n_xt_mk_jbxx.46.mkmc_n81i', 'i18n_xt_mk_jbxx.46.mkms_n81i', '/detection/oidDictionary.do?action=query', null, '1', null, null, null, '0', '2', '5', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('47', '46', null, 'i18n_xt_mk_jbxx.309.mkmc_n81i', null, null, null, '1', null, null, 'addRecord', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('48', '46', null, 'i18n_xt_mk_jbxx.10.mkmc_n81i', null, null, null, '1', null, null, 'addRecord', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('49', '5', null, 'i18n_xt_mk_jbxx.49.mkmc_n81i', null, '/detection/switchDetection.do?action=query', null, '1', null, null, null, '0', '2', '6', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('50', '5', null, 'i18n_xt_mk_jbxx.50.mkmc_n81i', 'i18n_xt_mk_jbxx.50.mkms_n81i', '/detection/detectionSet.do?action=query', null, '1', null, null, null, null, '2', '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('51', '50', null, 'i18n_xt_mk_jbxx.10.mkmc_n81i', 'i18n_xt_mk_jbxx.51.mkms_n81i', null, null, '0', null, null, 'addDetecSet', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('52', '50', null, 'i18n_xt_mk_jbxx.309.mkmc_n81i', 'i18n_xt_mk_jbxx.52.mkms_n81i', null, null, '0', null, null, 'updDetecSet', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('53', '50', null, 'i18n_xt_mk_jbxx.53.mkmc_n81i', 'i18n_xt_mk_jbxx.53.mkms_n81i', null, null, '0', null, null, 'addPoliceSet', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('54', '53', null, 'i18n_xt_mk_jbxx.54.mkmc_n81i', 'i18n_xt_mk_jbxx.54.mkms_n81i', '/detection/policeSet.do?action=query', null, '0', null, null, null, '0', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('55', '54', null, 'i18n_xt_mk_jbxx.10.mkmc_n81i', 'i18n_xt_mk_jbxx.10.mkmc_n81i', null, null, '0', null, null, 'addPoliceRelation', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('56', '54', null, 'i18n_xt_mk_jbxx.309.mkmc_n81i', 'i18n_xt_mk_jbxx.309.mkmc_n81i', null, null, '0', null, null, 'updatePoliceRelation', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('57', '5', null, 'i18n_xt_mk_jbxx.57.mkmc_n81i', 'i18n_xt_mk_jbxx.57.mkms_n81i', '/detection/monitorData.do?action=query', null, '1', null, null, null, null, '2', '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('58', '5', null, 'i18n_xt_mk_jbxx.58.mkmc_n81i', 'i18n_xt_mk_jbxx.58.mkms_n81i', '/detection/checkTypeSet.do?action=query', null, '1', null, null, null, null, '2', '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('59', '58', null, 'i18n_xt_mk_jbxx.10.mkmc_n81i', 'i18n_xt_mk_jbxx.59.mkms_n81i', null, null, '0', null, null, 'addCheckTypeSet', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('60', '58', null, 'i18n_xt_mk_jbxx.309.mkmc_n81i', 'i18n_xt_mk_jbxx.60.mkms_n81i', null, null, '0', null, null, 'updCheckTypeSet', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('61', '58', null, 'i18n_xt_mk_jbxx.310.mkmc_n81i', 'i18n_xt_mk_jbxx.61.mkms_n81i', null, null, '0', null, null, 'delCheckTypeSet', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('62', '5', null, 'i18n_xt_mk_jbxx.62.mkmc_n81i', 'i18n_xt_mk_jbxx.62.mkms_n81i', '/detection/detectionWarning.do?action=query', null, '1', null, null, null, '0', '2', '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('63', '6', '0_0006_0001', 'i18n_xt_mk_jbxx.63.mkmc_n81i', 'i18n_xt_mk_jbxx.63.mkms_n81i', '/nmstaskManager/nmsTaskManager.do?action=query', null, '1', null, null, null, null, null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('64', '63', '0_0006_0001_0001', 'i18n_xt_mk_jbxx.64.mkmc_n81i', 'i18n_xt_mk_jbxx.64.mkms_n81i', null, null, '0', null, null, 'addSimilar', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('65', '63', '0_0006_0001_0002', 'i18n_xt_mk_jbxx.10.mkmc_n81i', 'i18n_xt_mk_jbxx.10.mkmc_n81i', null, null, '0', null, null, 'add', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('66', '63', '0_0006_0001_0003', 'i18n_xt_mk_jbxx.66.mkmc_n81i', 'i18n_xt_mk_jbxx.66.mkms_n81i', null, null, '0', null, null, 'shutDn', '1', null, '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('67', '63', '0_0006_0001_0004', 'i18n_xt_mk_jbxx.307.mkmc_n81i', 'i18n_xt_mk_jbxx.67.mkms_n81i', null, null, '0', null, null, 'startDn', '1', null, '5', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('68', '63', '0_0006_0001_0005', 'i18n_xt_mk_jbxx.68.mkmc_n81i', 'i18n_xt_mk_jbxx.68.mkms_n81i', null, null, '0', null, null, 'addConverse', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('69', '4', '0_0007_0001', 'i18n_xt_mk_jbxx.69.mkmc_n81i', 'i18n_xt_mk_jbxx.69.mkms_n81i', '/nodePosition/roomManage.do?action=query', null, '1', null, null, null, '0', '2', '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('70', '69', '0_0007_0001_0001', 'i18n_xt_mk_jbxx.10.mkmc_n81i', 'i18n_xt_mk_jbxx.70.mkms_n81i', null, null, '0', null, null, 'addRecord', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('71', '69', '0_0007_0001_0002', 'i18n_xt_mk_jbxx.309.mkmc_n81i', 'i18n_xt_mk_jbxx.71.mkms_n81i', null, null, '0', null, null, 'updRecord', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('72', '69', '0_0007_0001_0003', 'i18n_xt_mk_jbxx.310.mkmc_n81i', 'i18n_xt_mk_jbxx.72.mkms_n81i', null, null, '0', null, null, 'delRecord', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('73', '7', '0_0007_0002', 'i18n_xt_mk_jbxx.73.mkmc_n81i', null, '/nodePosition/nodePosition.do?action=showTopology', null, '1', null, null, null, null, '2', '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('74', '7', '0_0007_0003', 'i18n_xt_mk_jbxx.74.mkmc_n81i', null, '/nodePosition/nodePosition.do?action=showMap', null, '1', null, null, null, '0', '2', '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('75', '4', '0_0007_0004', 'i18n_xt_mk_jbxx.75.mkmc_n81i', 'i18n_xt_mk_jbxx.75.mkms_n81i', '/nodePosition/boxSet.do?action=query', null, '1', null, null, null, '0', '2', '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('76', '75', '0_0007_0004_0001', 'i18n_xt_mk_jbxx.10.mkmc_n81i', 'i18n_xt_mk_jbxx.10.mkmc_n81i', null, null, '0', null, null, 'addNb', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('77', '75', '0_0007_0004_0002', 'i18n_xt_mk_jbxx.309.mkmc_n81i', 'i18n_xt_mk_jbxx.309.mkmc_n81i', null, null, '0', null, null, 'updNb', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('78', '75', '0_0007_0004_0003', 'i18n_xt_mk_jbxx.310.mkmc_n81i', 'i18n_xt_mk_jbxx.310.mkmc_n81i', null, null, '0', null, null, 'delNb', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('79', '7', '0_0007_0005', 'i18n_xt_mk_jbxx.79.mkmc_n81i', null, '/nodePosition/topoShow.do?action=showTopo', null, '1', null, null, null, '0', '2', '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('80', '50', null, 'i18n_xt_mk_jbxx.293.mkmc_n81i', 'i18n_xt_mk_jbxx.80.mkms_n81i', null, null, '0', null, null, 'stopDSet', '1', null, '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('81', '50', null, 'i18n_xt_mk_jbxx.299.mkmc_n81i', 'i18n_xt_mk_jbxx.81.mkms_n81i', null, null, '0', null, null, 'startDSet', '1', null, '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('101', '1', null, 'dxytest', null, '/functionManager/functionManager.do?action=queryMkInfo', null, '1', '2013-04-10 16:37:41', null, null, '0', '2', '5', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('121', '4', null, 'i18n_xt_mk_jbxx.121.mkmc_n81i', 'i18n_xt_mk_jbxx.121.mkms_n81i', '/detection/switchDetection.do?action=toConfigSpecialDevice', null, '1', '2013-04-23 09:30:22', null, null, '0', '2', '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('122', '4', null, 'i18n_xt_mk_jbxx.122.mkmc_n81i', 'i18n_xt_mk_jbxx.122.mkms_n81i', '/detection/switchDetection.do?action=toConfigSpecialDevice', null, '1', '2013-04-23 09:35:40', null, null, '0', '2', '5', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('141', '7', null, 'i18n_xt_mk_jbxx.141.mkmc_n81i', null, '/nodePosition/topoShow.do?action=showNode', null, '1', '2013-04-26 10:18:37', null, null, '0', '2', '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('161', '5', null, 'i18n_xt_mk_jbxx.161.mkmc_n81i', null, '/sysManage/guideManage!execute.do?action=index', null, '1', '2013-04-26 15:33:45', null, null, '0', '2', '7', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('181', '5', null, 'i18n_xt_mk_jbxx.181.mkmc_n81i', null, '/sysManage/guideManage!execute.do?action=task', null, '1', '2013-04-27 10:01:09', null, null, '0', '2', '9', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('201', '5', null, 'i18n_xt_mk_jbxx.201.mkmc_n81i', null, '/sysManage/guideManage!execute.do?action=monitor', null, '1', '2013-04-28 13:32:54', null, null, '0', '2', '10', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('221', '4', null, 'i18n_xt_mk_jbxx.221.mkmc_n81i', null, '/sysManage/deviceBrandManage.do?action=queryDeviceBrandInfo', null, '1', '2013-05-03 16:52:14', null, null, '0', '2', '6', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('222', '461', null, 'i18n_xt_mk_jbxx.10.mkmc_n81i', 'i18n_xt_mk_jbxx.10.mkmc_n81i', null, null, '0', '2013-05-03 17:10:40', null, 'toAddDevBrand', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('223', '461', null, 'i18n_xt_mk_jbxx.309.mkmc_n81i', 'i18n_xt_mk_jbxx.309.mkmc_n81i', null, null, '0', '2013-05-03 17:11:12', null, 'toUpdateDevBrand', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('224', '461', null, 'i18n_xt_mk_jbxx.310.mkmc_n81i', 'i18n_xt_mk_jbxx.310.mkmc_n81i', null, null, '0', '2013-05-03 17:11:39', null, 'deleteDevBrand', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('241', '4', null, 'i18n_xt_mk_jbxx.241.mkmc_n81i', 'i18n_xt_mk_jbxx.241.mkms_n81i', '/sysManage/deviceBrandManage.do?action=queryDeviceTypeInfo', null, '1', '2013-05-06 10:01:23', null, null, '0', '2', '7', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('242', '241', null, 'i18n_xt_mk_jbxx.10.mkmc_n81i', 'i18n_xt_mk_jbxx.242.mkms_n81i', null, null, '1', '2013-05-06 10:04:42', null, 'toAdd', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('243', '241', null, 'i18n_xt_mk_jbxx.309.mkmc_n81i', 'i18n_xt_mk_jbxx.309.mkmc_n81i', null, null, '1', '2013-05-06 10:04:59', null, 'toUpdate', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('244', '241', null, 'i18n_xt_mk_jbxx.310.mkmc_n81i', 'i18n_xt_mk_jbxx.310.mkmc_n81i', null, null, '1', '2013-05-06 10:05:22', null, 'delete', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('245', '241', null, 'i18n_xt_mk_jbxx.245.mkmc_n81i', 'i18n_xt_mk_jbxx.245.mkms_n81i', null, null, '1', '2013-05-06 11:36:48', null, 'toAddDevType', '1', null, '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('261', '284', null, 'i18n_xt_mk_jbxx.261.mkmc_n81i', 'i18n_xt_mk_jbxx.261.mkms_n81i', '/detection/detectionWarning.do?action=query&menuVisit=true&timeoutDetecFilter=false', null, '0', '2013-05-10 14:41:43', null, null, '0', '2', '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('262', '284', null, 'i18n_xt_mk_jbxx.262.mkmc_n81i', 'i18n_xt_mk_jbxx.262.mkms_n81i', '/detection/monitorData.do?action=query', null, '0', '2013-05-10 14:42:11', null, null, '0', '2', '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('263', '284', null, 'i18n_xt_mk_jbxx.263.mkmc_n81i', null, '/detection/detectionWarning.do?action=queryNE&menuVisit=true&timeoutDetecFilter=true', null, '0', '2013-05-10 14:42:29', null, null, '0', '2', '5', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('264', '284', null, 'i18n_xt_mk_jbxx.264.mkmc_n81i', null, '/detection/switchDetection.do?action=query', null, '0', '2013-05-10 14:42:56', null, null, '0', '2', '6', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('265', '284', null, 'i18n_xt_mk_jbxx.265.mkmc_n81i', 'i18n_xt_mk_jbxx.265.mkms_n81i', '/detection/detectionWarning.do?action=queryAll', null, '1', '2013-05-10 14:43:14', null, null, '0', '2', '10', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('266', '284', null, 'i18n_xt_mk_jbxx.266.mkmc_n81i', 'i18n_xt_mk_jbxx.266.mkms_n81i', '/nmstaskManager/nmsTaskManager!execute.do?action=query', null, '0', '2013-05-10 14:43:32', null, null, '0', '2', '11', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('267', '0', null, 'i18n_xt_mk_jbxx.267.mkmc_n81i', 'i18n_xt_mk_jbxx.267.mkms_n81i', null, null, '0', '2013-05-10 14:50:50', null, null, '0', '1', '9', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('268', '267', null, 'i18n_xt_mk_jbxx.268.mkmc_n81i', null, '/sysManage/guideManage!execute.do?action=monitor', null, '1', '2013-05-10 14:51:41', null, null, '0', '2', '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('269', '267', null, 'i18n_xt_mk_jbxx.269.mkmc_n81i', 'i18n_xt_mk_jbxx.269.mkms_n81i', '/detection/detectionSet.do?action=query', null, '0', '2013-05-10 14:53:09', null, null, '0', '2', '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('270', '267', null, 'i18n_xt_mk_jbxx.270.mkmc_n81i', null, '/detection/checkTypeSet.do?action=query', null, '0', '2013-05-10 14:54:03', null, null, '0', '2', '5', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('271', '267', null, 'i18n_xt_mk_jbxx.271.mkmc_n81i', null, '/nmstaskManager/nmsTaskManager.do?action=query', null, '0', '2013-05-10 14:54:18', null, null, '0', '2', '6', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('272', '267', null, 'i18n_xt_mk_jbxx.272.mkmc_n81i', null, '/detection/switchDetection.do?action=toConfigSpecialDevice', null, '0', '2013-05-10 14:54:34', null, null, '0', '2', '7', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('273', '267', null, 'i18n_xt_mk_jbxx.273.mkmc_n81i', null, '/nodePosition/roomManage.do?action=query', null, '0', '2013-05-10 14:54:51', null, null, '0', '2', '8', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('274', '267', null, 'i18n_xt_mk_jbxx.274.mkmc_n81i', 'i18n_xt_mk_jbxx.274.mkms_n81i', '/nodeGroupManage/nodeGroupManage!execute.do?action=queryNodeGroupInfo', null, '0', '2013-05-10 14:55:08', null, null, '0', '2', '9', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('275', '267', null, 'i18n_xt_mk_jbxx.275.mkmc_n81i', 'i18n_xt_mk_jbxx.275.mkms_n81i', '/sysManage/systemManage.do?action=query', null, '0', '2013-05-10 14:55:22', null, null, '0', '2', '10', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('276', '267', null, 'i18n_xt_mk_jbxx.276.mkmc_n81i', 'i18n_xt_mk_jbxx.276.mkms_n81i', '/serverManager/serverManager.do?action=query', null, '0', '2013-05-10 14:55:32', null, null, '0', '2', '11', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('277', '267', null, 'i18n_xt_mk_jbxx.277.mkmc_n81i', null, '/sysManage/dataDictionary.do?action=query', null, '0', '2013-05-10 14:55:52', null, null, '0', '2', '12', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('278', '267', null, 'i18n_xt_mk_jbxx.278.mkmc_n81i', null, '/nodePosition/nodePosition.do?action=showMap', null, '1', '2013-05-10 14:56:05', null, null, '0', '2', '14', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('279', '0', null, 'i18n_xt_mk_jbxx.279.mkmc_n81i', null, null, null, '0', '2013-05-10 14:56:29', null, null, '0', '1', '10', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('280', '279', null, 'i18n_xt_mk_jbxx.280.mkmc_n81i', null, '/deptManage/deptManage!execute.do?action=queryDeptInfo', null, '0', '2013-05-10 14:56:40', null, null, '0', '2', '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('281', '279', null, 'i18n_xt_mk_jbxx.281.mkmc_n81i', null, '/sysManage/sysPopedomManage!execute.do?action=queryJsInfo', null, '0', '2013-05-10 14:56:53', null, null, '0', '2', '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('282', '279', null, 'i18n_xt_mk_jbxx.282.mkmc_n81i', null, '/sysManage/sysPopedomManage!execute.do?action=queryUserInfo', null, '0', '2013-05-10 14:57:07', null, null, '0', '2', '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('283', '279', null, 'i18n_xt_mk_jbxx.283.mkmc_n81i', null, '/sysManage/sysPopedomManage!execute.do?action=updateSelfInfo', null, '0', '2013-05-10 14:57:18', null, null, '0', '2', '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('284', '0', null, 'i18n_xt_mk_jbxx.284.mkmc_n81i', null, null, null, '0', '2013-05-10 15:00:41', null, null, '0', '1', '8', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('285', '284', null, 'i18n_xt_mk_jbxx.285.mkmc_n81i', 'i18n_xt_mk_jbxx.285.mkms_n81i', '/nodePosition/newTopoShow.do?action=showTopo', null, '0', '2013-05-10 16:20:20', null, null, '0', '2', '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('286', '284', null, 'i18n_xt_mk_jbxx.286.mkmc_n81i', null, '/nodePosition/topoShow.do?action=showTopo', null, '1', '2013-05-10 16:21:02', null, null, '0', '2', '9', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('288', '267', null, 'i18n_xt_mk_jbxx.288.mkmc_n81i', 'i18n_xt_mk_jbxx.288.mkms_n81i', '/sysManage/userGroupPerssion.do?action=query', null, '0', '2013-05-10 16:28:01', null, null, '0', '2', '13', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('289', '288', null, 'i18n_xt_mk_jbxx.10.mkmc_n81i', 'i18n_xt_mk_jbxx.289.mkms_n81i', null, null, '0', '2013-05-10 16:30:42', null, 'addRecord', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('290', '276', null, 'i18n_xt_mk_jbxx.10.mkmc_n81i', null, null, null, '0', '2013-05-10 16:50:00', null, 'openAdd', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('291', '276', null, 'i18n_xt_mk_jbxx.309.mkmc_n81i', null, null, null, '0', '2013-05-10 16:50:23', null, 'openUpdate', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('292', '276', null, 'i18n_xt_mk_jbxx.299.mkmc_n81i', null, null, null, '0', '2013-05-10 16:51:40', null, 'startServer', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('293', '276', null, 'i18n_xt_mk_jbxx.293.mkmc_n81i', null, null, null, '0', '2013-05-10 16:52:03', null, 'stopServer', '1', null, '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('294', '275', null, 'i18n_xt_mk_jbxx.10.mkmc_n81i', null, null, null, '0', '2013-05-10 16:52:27', null, 'addSystem', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('295', '275', null, 'i18n_xt_mk_jbxx.309.mkmc_n81i', null, null, null, '0', '2013-05-10 16:54:27', null, 'updateSystem', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('296', '275', null, 'i18n_xt_mk_jbxx.293.mkmc_n81i', null, null, null, '0', '2013-05-10 16:54:47', null, 'stopSystem', '1', null, '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('297', '275', null, 'i18n_xt_mk_jbxx.299.mkmc_n81i', null, null, null, '0', '2013-05-10 16:56:04', null, 'startSystem', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('298', '274', null, 'i18n_xt_mk_jbxx.293.mkmc_n81i', null, null, null, '0', '2013-05-10 16:59:19', null, 'stopNodeGroup', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('299', '274', null, 'i18n_xt_mk_jbxx.299.mkmc_n81i', null, null, null, '0', '2013-05-10 16:59:42', null, 'startNodeGroup', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('300', '273', null, 'i18n_xt_mk_jbxx.10.mkmc_n81i', null, null, null, '0', '2013-05-10 17:18:46', null, 'addRecord', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('301', '273', null, 'i18n_xt_mk_jbxx.309.mkmc_n81i', null, null, null, '0', '2013-05-10 17:19:09', null, 'updRecord', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('302', '273', null, 'i18n_xt_mk_jbxx.310.mkmc_n81i', null, null, null, '0', '2013-05-10 17:19:28', null, 'delRecord', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('303', '271', null, 'i18n_xt_mk_jbxx.303.mkmc_n81i', null, null, null, '0', '2013-05-10 17:20:53', null, 'addSimilar', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('304', '271', null, 'i18n_xt_mk_jbxx.304.mkmc_n81i', null, null, null, '0', '2013-05-10 17:21:14', null, 'addConverse', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('305', '271', null, 'i18n_xt_mk_jbxx.10.mkmc_n81i', null, null, null, '0', '2013-05-10 17:21:39', null, 'add', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('306', '271', null, 'i18n_xt_mk_jbxx.306.mkmc_n81i', null, null, null, '0', '2013-05-10 17:22:31', null, 'shutDn', '1', null, '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('307', '271', null, 'i18n_xt_mk_jbxx.307.mkmc_n81i', null, null, null, '0', '2013-05-10 17:22:49', null, 'startDn', '1', null, '5', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('308', '270', null, 'i18n_xt_mk_jbxx.10.mkmc_n81i', null, null, null, '0', '2013-05-10 17:23:48', null, 'addCheckTypeSet', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('309', '270', null, 'i18n_xt_mk_jbxx.309.mkmc_n81i', null, null, null, '0', '2013-05-10 17:24:12', null, 'updCheckTypeSet', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('310', '270', null, 'i18n_xt_mk_jbxx.310.mkmc_n81i', null, null, null, '0', '2013-05-10 17:24:36', null, 'delCheckTypeSet', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('311', '269', null, 'i18n_xt_mk_jbxx.10.mkmc_n81i', null, null, null, '0', '2013-05-10 17:26:15', null, 'addDetecSet', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('312', '269', null, 'i18n_xt_mk_jbxx.309.mkmc_n81i', null, null, null, '0', '2013-05-10 17:26:37', null, 'updDetecSet', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('313', '269', null, 'i18n_xt_mk_jbxx.313.mkmc_n81i', null, null, null, '0', '2013-05-10 17:27:03', null, 'addPoliceSet', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('314', '269', null, 'i18n_xt_mk_jbxx.299.mkmc_n81i', null, null, null, '0', '2013-05-10 17:27:43', null, 'startDSet', '1', null, '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('315', '269', null, 'i18n_xt_mk_jbxx.293.mkmc_n81i', null, null, null, '0', '2013-05-10 17:28:08', null, 'stopDSet', '1', null, '5', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('316', '267', null, 'i18n_xt_mk_jbxx.316.mkmc_n81i', null, '/sysManage/guideManage!execute.do?action=task', null, '1', '2013-05-10 17:41:19', null, null, '0', '2', '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('321', '5', null, 'i18n_xt_mk_jbxx.321.mkmc_n81i', null, '/detection/monitorData.do?action=queryAbnormalSet', null, '1', '2013-05-13 09:56:28', null, null, '0', '2', '8', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('341', '277', null, 'i18n_xt_mk_jbxx.10.mkmc_n81i', 'i18n_xt_mk_jbxx.341.mkms_n81i', null, null, '0', '2013-05-24 17:33:55', null, 'addRecord', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('361', '267', null, 'i18n_xt_mk_jbxx.361.mkmc_n81i', null, '/detection/switchDetection.do?action=toConfigPort', null, '0', '2013-06-06 11:18:07', null, null, '0', '2', '15', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('381', '284', null, 'i18n_xt_mk_jbxx.381.mkmc_n81i', null, '/detection/monitorData.do?action=queryNE', null, '0', '2013-06-17 15:42:12', null, null, '0', '2', '12', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('421', '267', null, 'i18n_xt_mk_jbxx.421.mkmc_n81i', null, '/detection/policeSet.do?action=query', null, '0', '2013-06-24 08:43:33', null, null, '0', '2', '16', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('431', '1', null, 'i18n_xt_mk_jbxx.431.mkmc_n81i', 'i18n_xt_mk_jbxx.431.mkms_n81i', '/functionManager/functionManager.do?action=queryMkInfo', null, '1', '2011-12-05 12:57:47', null, null, '0', '2', null, null);
INSERT INTO `xt_mk_jbxx` VALUES ('441', '284', null, 'i18n_xt_mk_jbxx.441.mkmc_n81i', null, '/nodePosition/topoShow.do?action=show3DRoom', null, '0', '2013-06-24 17:32:36', null, null, '0', '2', '13', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('461', '267', null, 'i18n_xt_mk_jbxx.461.mkmc_n81i', null, '/sysManage/deviceBrandManage.do?action=queryDeviceBrandInfo', null, '0', '2013-07-11 15:23:52', null, null, '0', '2', '17', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('462', '267', null, 'i18n_xt_mk_jbxx.462.mkmc_n81i', null, '/sysManage/deviceBrandManage.do?action=queryDeviceTypeInfo', null, '0', '2013-07-11 15:24:17', null, null, '0', '2', '18', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('481', '284', null, 'i18n_xt_mk_jbxx.481.mkmc_n81i', null, '/nodePosition/nodeGroupPosition.do?action=configTopo', null, '1', '2013-07-17 10:37:24', null, null, '0', '2', '14', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('501', '284', null, 'i18n_xt_mk_jbxx.501.mkmc_n81i', 'i18n_xt_mk_jbxx.501.mkms_n81i', '/detection/detectionWarning.do?action=queryAllConfigLevel&timeoutDetecFilter=true', null, '0', '2013-10-17 16:51:19', null, null, '0', '2', '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('521', '267', null, 'i18n_xt_mk_jbxx.521.mkmc_n81i', 'i18n_xt_mk_jbxx.521.mkms_n81i', '/sysManage/dataDictionary.do?action=queryDetectConditionSet', null, '0', '2013-12-25 16:24:26', null, null, '0', '2', '19', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('541', '0', null, 'i18n_xt_mk_jbxx.541.mkmc_n81i', 'i18n_xt_mk_jbxx.541.mkms_n81i', null, null, '0', '2015-01-27 09:58:01', null, null, '0', '1', '11', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('542', '541', null, 'i18n_xt_mk_jbxx.542.mkmc_n81i', 'i18n_xt_mk_jbxx.542.mkms_n81i', '/pluginManage/pluginManage.do?action=queryInfo', null, '0', '2015-01-27 10:03:37', null, null, '0', '2', '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('543', '542', null, 'i18n_xt_mk_jbxx.10.mkmc_n81i', 'i18n_xt_mk_jbxx.543.mkms_n81i', null, null, '0', '2015-01-27 10:05:51', null, 'addPlugin', '1', null, '1', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('544', '542', null, 'i18n_xt_mk_jbxx.309.mkmc_n81i', 'i18n_xt_mk_jbxx.544.mkms_n81i', null, null, '0', '2015-01-27 10:06:56', null, 'updatePlugin', '1', null, '2', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('545', '542', null, 'i18n_xt_mk_jbxx.310.mkmc_n81i', 'i18n_xt_mk_jbxx.545.mkms_n81i', null, null, '0', '2015-01-27 10:07:21', null, 'delPlugin', '1', null, '3', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('546', '542', null, 'i18n_xt_mk_jbxx.546.mkmc_n81i', 'i18n_xt_mk_jbxx.546.mkms_n81i', null, null, '0', '2015-01-27 10:07:47', null, 'downPlugin', '1', null, '4', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('561', '0', null, 'i18n_xt_mk_jbxx.561.mkmc_n81i', null, 'function', null, '1', '2015-07-21 13:48:30', null, null, '0', '1', '12', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('581', '267', null, 'i18n_xt_mk_jbxx.581.mkmc_n81i', 'i18n_xt_mk_jbxx.581.mkms_n81i', '/nodePosition/nodeGroupPosition.do?action=configTopo', null, '0', '2015-10-20 15:18:11', null, null, '0', '2', '20', '0');
INSERT INTO `xt_mk_jbxx` VALUES ('601', '1', null, 'i18n_xt_mk_jbxx.601.mkmc_n81i', null, '/sysManage/guideManage!execute.do?action=monitor', null, '0', '2016-09-09 11:19:26', null, null, '0', '2', '6', '0');



-- ----------------------------
-- Records of xt_yh_jbxx
-- ----------------------------
INSERT INTO `xt_yh_jbxx` VALUES ('admin', '202CB962AC59075B964B07152D234B70', 'i18n_xt_yh_jbxx.admin.yhmc_n81i', null, null, null, null, null, '0', null, '1', 'i18n_xt_yh_jbxx.admin.rigthmenuitems_n81i', '_yellow', '', '1', '0', 'zh_CN');



-- ----------------------------
-- Records of xt_yh_js_index
-- ----------------------------
INSERT INTO `xt_yh_js_index` VALUES ('1', 'admin', '1', null, null, null);

