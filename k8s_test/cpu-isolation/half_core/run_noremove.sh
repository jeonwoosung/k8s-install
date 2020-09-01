resultFile=result/result_`date '+%Y%m%d%H%M%S'`.txt

# POD1 부하 생성
l1.sh

# 부하검증 전 시스템 안정화
sleep 5

# POD1 pid 획득
getpid.sh > pid

# POD1 단독부하 검증
echo "====" > $resultFile
echo Standalone >> $resultFile
echo "====" >> $resultFile
getLoad.sh >> $resultFile

# POD2 부하 생성(1개)
l2.sh

# 부하검증 전 시스템 안정화
sleep 10

# POD2 부하1 검증
echo "====" >> $resultFile
echo "Load Level1" >> $resultFile
echo "====" >> $resultFile
getLoad.sh >> $resultFile

# POD2 부하 생성(4개 추가, 총 5개)
l2.sh
l2.sh
l2.sh
l2.sh

# 부하검증 전 시스템 안정화
sleep 5

# POD2 부하5 검증
echo "====" >> $resultFile
echo "Load Level5" >> $resultFile
echo "====" >> $resultFile
getLoad.sh >> $resultFile

# POD2 부하 생성(5개 추가, 총 10개)
l2.sh
l2.sh
l2.sh
l2.sh
l2.sh

# 부하검증 전 시스템 안정화
sleep 5

# POD2 부하10 검증
echo "====" >> $resultFile
echo "Load Level10" >> $resultFile
echo "====" >> $resultFile
getLoad.sh >> $resultFile

## 종료(모든 부하 삭제)
