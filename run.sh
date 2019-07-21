#! /bin/bash 
clear 
i="y"

while [ $i = "y" ] 
do
echo "====================================================" 
echo "1.uptime" 
echo "2.Last logins" 
echo "3.Disk and memory usage" 
echo "4.Utilization and most expensive processes" 
echo "5.Open TCP ports"
echo "6.Current connections"
echo "7.processes"
echo "8.vmstat"
echo "9.exit"
echo "======================================================" 
read ch
if [ $ch == "1" ] 
then
   echo "--------------------------uptime------------------------------------------------" 
   uptime
elif [ $ch == "2" ]; then
	echo "-------------------------Last logins--------------------------------------------"
	w
elif [ $ch == "3" ]; then
	echo "------------------------Disk and memory usage------------------------------------"
	last -a |head -3
	df -h | xargs | awk '{print "Free/totals disk: " $23 " / "$24}'
	echo "---------------------------------------------------------------------------------"
	free -m |xargs | awk '{print "free/total/used disk: "$10 "/" $8 "/" $9"  MB"}'
	echo "---------------------------------------------------------------------------------"
	start_log=`head -1 /var/log/messages |cut -c 1-12`
	oom=`grep -ci kill /var/log/messages`
	echo -n "OOM errors since $start_log :" $oom
	echo ""
	echo "----------------------------------------------------------------------------------"
elif [ $ch == "4" ]; then
	echo "----------------------Utilization and most expensive processes--------------------"
    top -b |head -3
	echo
	top -b |head -10 |tail -4
elif [ $ch == "5" ]; then
	echo "-------------------------Open TCP ports--------------------------------------------"
	nmap -p- -T4 127.0.0.1
	echo "-----------------------------------------------------------------------------------"
	#statements
elif [ $ch == "6" ]; then
	echo "------------------------Current connections----------------------------------------"
	ss -s
	echo "-----------------------------------------------------------------------------------"
elif [ $ch == "7" ]; then
	echo "------------------------processes-----------------------------------------------"
    ps auxf --width=200
    echo "--------------------------------------------------------------------------------"
elif [ $ch == "8" ]; then
	echo "------------------------vmstat-----------------------------------------------------"
	vmstat 1 5
	echo "-----------------------------------------------------------------------------------"
elif [ $ch == "9" ]; then
	clear;exit;
fi 
done



