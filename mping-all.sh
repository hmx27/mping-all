#!/bin/bash
#####		一键Ping测试		     #####
#####		Author:xiaoz.me			#####
#####		Update:2019-06-03		#####
#####		Forked:hmx27     		#####

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin:/sbin
export PATH

location=(
		'广州电信'
		'广州联通'
		'广州移动'
		'上海电信'
		'上海联通'
		'上海移动'
		'北京电信'
		'北京联通'
		'北京移动'
	)
#各地区DNS，来源于http://dns.lisect.com/ and https://www.ip.cn/dns.html
dnsip=(
	'202.96.128.166'	#广州电信
	'221.5.88.88'		#广州联通
	'211.136.20.203'	#广州移动
	
	'202.96.199.133'  	#上海电信
	'139.227.180.216'	#上海联通
	'211.136.150.66'	#上海移动
	
	'220.181.17.1'		#北京电信
	'202.96.0.133'  	#北京联通
	'221.183.67.193'	#北京移动
)
echo '---------------------------------------------------------------------------'
function mping(){
	num=0
	#Ping次数
	pnum=$1

	#echo '---------------------------------------------------------------------------'
	echo "正在进行Ping测试100次..."
	echo "提示：测试过程需要15-20分钟，请耐心等待..."
	echo '---------------------------------------------------------------------------'

	while(( $num<9 ))
	do
		ping ${dnsip[$num]} -c $pnum > /tmp/${dnsip[$num]}.txt
		echo 【${location[$num]}】 - ${dnsip[$num]}
		echo ''
		tail -2 /tmp/${dnsip[$num]}.txt
		echo '---------------------------------------------------------------------------'
		let "num++"
	done
	echo "【参数说明】"
	echo "x% packet loss: 丢包率"
	echo "min: 最低延迟"
	echo "avg: 平均延迟"
	echo "max: 最高延迟"
	echo "mdev: 平均偏差"

	echo '---------------------------------------------------------------------------'
}

function moretrace(){
	#检查besttrace是否存在
	if [ ! -f "./besttrace" ]
	then
		#下载besttrace
		wget -q http://soft.xiaoz.org/linux/besttrace
		#添加执行权限
		chmod +x ./besttrace
	fi

	#进行路由跟踪
	echo '---------------------------------------------------------------------------'
	echo '正在进行路由跟踪，请稍后...'
	echo '---------------------------------------------------------------------------'
	echo '【广州电信】 - 202.96.128.166'
	echo ''
	./besttrace -q 1 202.96.128.166
	echo '---------------------------------------------------------------------------'

	echo '【广州联通】- 221.5.88.88'
	echo ''
	./besttrace -q 1 221.5.88.88
	echo '---------------------------------------------------------------------------'

	echo '【广州移动】 - 211.136.20.203'
	echo ''
	./besttrace -q 1 211.136.20.203
	echo '---------------------------------------------------------------------------'
	
	
	
	echo '【上海电信】 - 202.96.199.133'
	echo ''
	./besttrace -q 1 202.96.199.133
	echo '---------------------------------------------------------------------------'

	echo '【上海联通】- 139.227.180.216'
	echo ''
	./besttrace -q 1 139.227.180.216
	echo '---------------------------------------------------------------------------'

	echo '【上海移动】 - 211.136.150.66'
	echo ''
	./besttrace -q 1 211.136.150.66
	echo '---------------------------------------------------------------------------'
	
	
	
	echo '【北京电信】 - 220.181.17.1'
	echo ''
	./besttrace -q 1 220.181.17.1
	echo '---------------------------------------------------------------------------'

	echo '【北京联通】- 202.96.0.133'
	echo ''
	./besttrace -q 1 202.96.0.133
	echo '---------------------------------------------------------------------------'

	echo '【北京移动】 - 221.183.67.193'
	echo ''
	./besttrace -q 1 221.183.67.193
	echo '---------------------------------------------------------------------------'
}

mping 10
echo ''
moretrace
echo ''
echo '原作者帖子:https://www.xiaoz.me/archives/13044'
echo ''