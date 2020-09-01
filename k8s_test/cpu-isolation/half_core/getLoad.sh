PID=`cat pid`
SET=$(seq 0 5)
for i in $SET
do
    top -b -n 1 -p $PID |grep $PID
    sleep 10
done

