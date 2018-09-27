#!/bin/bash

PLACE=".1.3.6.1.4.1.5000001.1.5.1"  # NET-MIB::netEntry的根OID


#
# 脚本会接收到两个参数
# $1     --请求类型
#    -s  --snmpset
#    -g  --snmpget
#    -n  --snmpgetnext/snmpwalk  注：snmpwalk的本质是循环执行snmpgetnext，以当次snmpgetnext的最终执行OID作为下次snmpgetnext的请求OID
# $2     --请求的OID
#
REQ="$2"	# 请求的OID
RET=""		# 最终执行的OID


#
# 提取net监测结果文件的内容
#
basePath=$(cd `dirname $0`; pwd) # 脚本所在目录
while read line;do 	# 读取配置文件
  eval "$line"
done < ${basePath}/config

declare -A devices_arr 	# 所有设备所有cpu数据存放的数组，最后从这里取数据，格式：devices_arr[“项”“设备序号”“网卡序号”]。个位数的项目号前面加0
		      	# 例如，取第2台设备的第3个网卡的速度（第11项）：devices_arr[1123]；第3台设备的第1个网卡的rxErrors（第6项）：devices_arr[0631]
declare -A device_net	# 设备对应的网卡数量，格式：device_core[1]=3，1号设备有3个网卡
device_index=1		# 设备序号
net_index=0 		# 网卡序号
item_num=19 		# 项目数量，根据业务而定

details=`awk 'NR>2{print}' ${snmp_result_dir}"/net.csv"`	# 取得details内容
details_rownum=`echo "$details"|awk '{print NR}'|tail -n1` 	# details行数

for((i=0;i<$details_rownum;i++));do
  for_i_flag=1
  rownum_t=$((i+1))
  detail_row=`echo "$details"|awk 'NR=="'$rownum_t'"{print}'` 	# details某行的整行数据

  OLD_IFS="$IFS"
  IFS=","
  detail_row_arr=($detail_row) 	# 将整行数据用逗号隔开转为数组
  IFS=$OLD_IFS

  forthInfo=${detail_row_arr[3]}

  OLD_IFS="$IFS"
  IFS="-"
  name_and_index_arr=($forthInfo)
  IFS=$OLD_IFS

  net_name=${name_and_index_arr[1]}		# 网卡名称
  device_index_t=${name_and_index_arr[0]#*if}	# 当前设备序号

  if [[ $device_index_t == $device_index ]];then
    net_index=$((net_index+1))
    devices_arr+=(["2"${device_index}${net_index}]=$net_name)	# 将第二项net名称存入
  else
    device_net+=([$device_index]=$net_index)
    net_index=1
    device_index=$device_index_t
    devices_arr+=(["2"${device_index}${net_index}]=${net_name})	# 将第二项net名称存入
  fi
  
  for((j=4;j<${#detail_row_arr[@]};j++));do
    item_index=$((j-1))
    if [[ j < 11 ]];then
      item_index="0"${item_index}
    fi
    devices_arr+=([${item_index}${device_index}${net_index}]=${detail_row_arr[$j]})
  done

done
device_net+=([$device_index]=$net_index)


#
# 处理snmpgetnext请求，获取REQ的递增后的下个OID，递增规则需要自定义
#
if [ "$1" = "-n" ]; then
  caseFlag=1

  # 机器编号 -------------------开始
  case $REQ in
    $PLACE|			\
    $PLACE.0|			\
    $PLACE.0.*|			\
    $PLACE.1)   		RET=$PLACE.1.1; caseFlag=0 ;;
  esac

  for((i=1;i<=$device_index&&$caseFlag==1;i++));do
    case $REQ in
      $PLACE.1.$((i-1))|	\
      $PLACE.1.$((i-1)).*)	RET=$PLACE.1.$i; caseFlag=0 ;;
    esac
  done
  # 机器编号 -------------------结束

  # net信息 --------------------开始
  for((i=2;i<=$item_num&&$caseFlag==1;i++));do
    case $REQ in
      $PLACE.$((i-1)).*|	\
      $PLACE.$i|		\
      $PLACE.$i.0)		RET=$PLACE.$i.1.1; caseFlag=0 ;;
    esac

    for((j=1;j<=$device_index&&$caseFlag==1;j++));do
      case $REQ in
	$PLACE.$i.$((j-1)).*|		\
	$PLACE.$i.$j)		RET=$PLACE.$i.$j.1; caseFlag=0 ;;
      esac

      for((k=1;k<=${device_net[$j]}&&$caseFlag==1;k++));do
	case $REQ in
	  $PLACE.$i.$j.$((k-1))|	\
	  $PLACE.$i.$j.$((k-1)).*)	RET=$PLACE.$i.$j.$k; caseFlag=0 ;;
	esac
      done
    done
  done
  # net信息 --------------------结束
fi


#
# 根据RET输出查询结果
#
echo "$RET"
for((i=1;i<=$device_index;i++));do
  case "$RET" in
    $PLACE.1.$i)		echo "integer";	echo $i;		exit 0 ;;
  esac
done

for((i=2;i<=$item_num;i++));do
  for((j=1;j<=$device_index;j++));do
    for((k=1;k<=${device_net[$j]};k++));do
      case "$RET" in
	$PLACE.$i.$j.$k)	echo "string";	echo "${devices_arr[$i$j$k]}";		exit 0 ;;
      esac
    done
  done
done
				echo "string";	echo "error OID";	exit 0
