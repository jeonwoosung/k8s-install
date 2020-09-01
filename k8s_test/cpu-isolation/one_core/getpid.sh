ps -eaf |grep /dev/urandom |grep -v grep |awk '{print $2}' 
