# PID=`cat pid`
# SET=$(seq 0 5)
# for i in $SET
# do
#     top -b -n 1 -p $PID |grep $PID
#     sleep 10
# done


PID=`cat pid`
top -b -n 7 -d 10.0 -p $PID |grep $PID
