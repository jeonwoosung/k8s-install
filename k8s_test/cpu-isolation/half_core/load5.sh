#init.sh

# POD2 부하 생성(4개 추가, 총 5개)
l2.sh
l2.sh
l2.sh
l2.sh
l2.sh

# 부하검증 전 시스템 안정화
sleep 5

# POD2 부하5 검증
echo "====" >> $resultFile
echo "Load Level5" >> $resultFile
ps -eaf |grep urandom |grep -v grep| wc -l  >> $resultFile
echo "====" >> $resultFile
getLoad.sh >> $resultFile

remove.sh
