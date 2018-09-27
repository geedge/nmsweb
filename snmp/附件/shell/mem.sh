#!/bin/bash

PLACE=".1.3.6.1.4.1.5000001.1.3.1"  # MEM-MIB::memEntry的根OID


#
# 脚本会接收到两个参数
# $1     --请求类型
#    -s  --snmpset
#    -g  --snmpget
#    -n  --snmpgetnext/snmpwalk  注：snmpwalk的本质是循环执行snmpgetnext，以当次snmpgetnext的最终执行OID作为下次snmpgetnext的请求OID
# $2     --请求的OID
#
REQ="$2"        # 请求的OID
RET=""          # 最终执行的OID


#
# 提取mem监测结果文件的内容
#
basePath=$(cd `dirname $0`; pwd) # 脚本所在目录
while read line;do      # 读取配置文件
  eval "$line"
done < ${basePath}/config

declare -A devices_arr  # 所有设备所有mem数据存放的数组，最后从这里取数据，格式：devices_arr[“项”“设备序号"]
                        # 例如，取第2台设备的总内存大小：devices_arr[42]
item_num=7              # 项目数量，根据业务而定

details=`awk 'NR>2{print}' ${snmp_result_dir}"/mem.csv"`              # 取得details内容
details_rownum=`echo "$details"|awk '{print NR}'|tail -n1`      # details行数
for((i=0;i<$details_rownum;i++));do
  device_index=$((i+1))
  detail_row=`echo "$details"|awk 'NR=="'$device_index'"{print}'`   # details某行的整行数据

  OLD_IFS="$IFS"
  IFS=","
  detail_row_arr=($detail_row)  # 将整行数据用逗号隔开转为数组
  IFS=$OLD_IFS

  for((j=3;j<${#detail_row_arr[@]};j++));do
    devices_arr+=([$((j-1))${device_index}]=${detail_row_arr[$((j))]})
  done
done


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

  # mem信息 --------------------开始
  for((i=2;i<=$item_num&&$caseFlag==1;i++));do
    case $REQ in
      $PLACE.$((i-1)).*|        \
      $PLACE.$i)		RET=$PLACE.$i.1; caseFlag=0 ;;
    esac

    for((j=1;j<=$device_index&&$caseFlag==1;j++));do
      case $REQ in
	$PLACE.$i.$((j-1))|	\
        $PLACE.$i.$((j-1)).*)	RET=$PLACE.$i.$j; caseFlag=0 ;;

        #$PLACE.$i.$((j-1)).*|           \
        #$PLACE.$i.$j)           RET=$PLACE.$i.$j; caseFlag=0 ;;
      esac
    done
  done
  # cpu信息 --------------------结束
fi


#
# 根据RET输出查询结果
#
echo "$RET"
for((i=1;i<=$device_index;i++));do
  case "$RET" in
    $PLACE.1.$i)                echo "integer"; echo $i;                exit 0 ;;
  esac
done

for((i=2;i<=$item_num;i++));do
  for((j=1;j<=device_index;j++));do
    case "$RET" in
      $PLACE.$i.$j)        echo "string";  echo ${devices_arr[$i$j]};            exit 0 ;;
    esac
  done
done
                                echo "string";  echo "error OID";       exit 0
