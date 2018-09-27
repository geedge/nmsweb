#!/bin/bash

PLACE=".1.3.6.1.4.1.5000001.1.1.1"	# ZDJZ-MIB::deviceOverviewEntry的根OID


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
# 获取系统运行时间，并提取cpu、内存结果文件内容，组织成结果
#
basePath=$(cd `dirname $0`; pwd) # 脚本所在目录
while read line;do 	# 读取配置文件
  eval "$line"
done < ${basePath}/config

declare -A devices_arr 	# 所有设备数据存放的数组，最后从这里取数据，格式：devices_arr["项""设备序号"]
		      	# 例如，取第2台设备的运行时间：devices_arr[32]
device_index=1 		# 设备序号
item_num=5 		# 项目数量，根据业务而定

# 获取cpu使用率 -----------------------开始
cpu_details=`awk 'NR>2{print}' ${snmp_result_dir}/"cpu.csv"` 	# 取得details内容
cpu_details_rownum=`echo "$cpu_details"|awk '{print NR}'|tail -n1` 	# details行数
for((i=0;i<$cpu_details_rownum;i++));do
  rownum_t=$((i+1))
  cpu_detail_row=`echo "$cpu_details"|awk 'NR=="'$rownum_t'"{print}'` 	# details某行的整行数据

  OLD_IFS="$IFS"
  IFS=","
  cpu_detail_row_arr=($cpu_detail_row) 	# 将整行数据用逗号隔开转为数组
  IFS=$OLD_IFS

  if [[ ${cpu_detail_row_arr[3]} =~ "-" ]];then
    continue
  else
    devices_arr+=([4${device_index}]=${cpu_detail_row_arr[9]})
    device_index=$((device_index+1)) 	# 设备序号加1
  fi
done
device_index=1	# 重置设备序号，准备处理内存信息
# 获取cpu使用率 -----------------------结束

# 获取内存使用率 ----------------------开始
mem_details=`awk 'NR>2{print}' ${snmp_result_dir}"/mem.csv"`		# 取得details内容
mem_details_rownum=`echo "$mem_details"|awk '{print NR}'|tail -n1`	# details行数
for((i=0;i<$mem_details_rownum;i++));do
  rownum_t=$((i+1))
  mem_detail_row=`echo "$mem_details"|awk 'NR=="'$rownum_t'"{print}'`   # details某行的整行数据

  OLD_IFS="$IFS"
  IFS=","
  mem_detail_row_arr=($mem_detail_row)  # 将整行数据用逗号隔开转为数组
  IFS=$OLD_IFS

  devices_arr+=([5${device_index}]=${mem_detail_row_arr[8]})
  device_index=$((device_index+1))
done
device_index=1
# 获取内存使用率 ----------------------结束

# 获取运行时间 ------------------------开始
runtimes=`cat ${snmp_result_dir}"/runtimes.csv"`
runtimes_arr=($runtimes)
for((i=0;i<${#runtimes_arr[@]};i++));do
  devices_arr+=([3${device_index}]=${runtimes_arr[i]})
  device_index=$((device_index+1))
done
device_index=$((device_index-1))
# 获取运行时间 ------------------------结束

# 设置状态 ----------------------------开始
for((i=1;i<=$device_index;i++));do
  devices_arr+=([2$i]=1)
done
# 设置状态 ----------------------------结束


#
# 处理snmpgetnext请求，获取REQ的递增后的下个OID，递增规则需要自定义
#
if [ "$1" = "-n" ]; then
  caseFlag=1

  # 机器编号 -------------------开始
  case $REQ in
    $PLACE|                     \
    $PLACE.0|                   \
    $PLACE.0.*|                 \
    $PLACE.1)                   RET=$PLACE.1.1; caseFlag=0 ;;
  esac

  for((i=1;i<=$device_index&&$caseFlag==1;i++));do
    case $REQ in
      $PLACE.1.$((i-1))|        \
      $PLACE.1.$((i-1)).*)      RET=$PLACE.1.$i; caseFlag=0 ;;
    esac
  done
  # 机器编号 -------------------结束

  # 详细信息 --------------------开始
  for((i=2;i<=$item_num&&$caseFlag==1;i++));do
    case $REQ in
      $PLACE.$((i-1)).*|        \
      $PLACE.$i)		RET=$PLACE.$i.1; caseFlag=0 ;;
    esac

    for((j=1;j<=$device_index&&$caseFlag==1;j++));do
      case $REQ in
	$PLACE.$i.$((j-1))|	\
        $PLACE.$i.$((j-1)).*)	RET=$PLACE.$i.$j; caseFlag=0 ;;
      esac
    done
  done
  # 详细信息 --------------------结束
fi


#
# 根据RET输出查询结果
#
echo "$RET"
for((i=1;i<=$device_index;i++));do
  case "$RET" in
    $PLACE.1.$i)                echo "integer"; echo $i;                	exit 0 ;;
  esac
done

for((i=2;i<=$item_num;i++));do
  for((j=1;j<=device_index;j++));do
    case "$RET" in
      $PLACE.$i.$j)        	echo "string";  echo ${devices_arr[$i$j]};      exit 0 ;;
    esac
  done
done
                                echo "string";  echo "error OID";       	exit 0
