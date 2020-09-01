resultFile=result/result_`date '+%Y%m%d%H%M%S'`.txt

# POD1 부하 생성
l1.sh

# 부하검증 전 시스템 안정화
sleep 5

# POD1 pid 획득
getpid.sh > pid

