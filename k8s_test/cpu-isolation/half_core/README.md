# 격리테스트

## 준비단계

    # POD생성
    kubectl apply -f loadtest1.yaml
    kubectl apply -f loadtest2.yaml

    # 부하 파일 주입
    cp.sh(stress.sh to pods(loadtest1, loadtest2))

## 성능 검증

### POD1 생성

    resultFile=result/result_`date '+%Y%m%d%H%M%S'`.txt

    # POD1 부하 생성
    l1.sh

    # 부하검증 전 시스템 안정화
    sleep 60

### POD1 단독 부하 검증

    # POD1 pid 획득
    getpid.sh > pid

    # POD1 단독부하 검증
    echo "====" > $resultFile
    echo Standalone >> $resultFile
    ps -eaf |grep urandom |grep -v grep| wc -l  >> $resultFile
    echo "====" >> $resultFile
    getLoad.sh >> $resultFile

### POD2 생성(1개)

    # POD2 부하 생성(1개)
    l2.sh

    # 생성완료시 까지 대기
    pcnt=`p.sh`
    echo $pcnt
    while [ $pcnt -ne 2 ]
    do
      echo $pcnt is not 2, wait 3 second
      pcnt=`p.sh`
      sleep 3
    done

### POD1(1개)-POD2(1개) 부하 검증

    # 부하검증 전 시스템 안정화
    sleep 60

    # POD2 부하1 검증
    echo "====" >> $resultFile
    echo "Load Level1" >> $resultFile
    ps -eaf |grep urandom |grep -v grep| wc -l  >> $resultFile
    echo "====" >> $resultFile
    getLoad.sh >> $resultFile


### POD2 생성(4개 추가, 총 5개)

    # POD2 부하 생성(4개 추가, 총 5개)
    l2.sh
    l2.sh
    l2.sh
    l2.sh

    pcnt=`p.sh`
    echo $pcnt
    while [ $pcnt -ne 6 ]
    do
      echo $pcnt is not 6, wait 3 second
      pcnt=`p.sh`
      sleep 3
    done

### POD1(1개)-POD2(5개) 부하 검증

    # 부하검증 전 시스템 안정화
    sleep 60

    # POD2 부하5 검증
    echo "====" >> $resultFile
    echo "Load Level5" >> $resultFile
    ps -eaf |grep urandom |grep -v grep| wc -l  >> $resultFile
    echo "====" >> $resultFile
    getLoad.sh >> $resultFile

### POD2 생성(5개 추가, 총 10개)

    # POD2 부하 생성(5개 추가, 총 10개)
    l2.sh
    l2.sh
    l2.sh
    l2.sh
    l2.sh

    pcnt=`p.sh`
    echo $pcnt
    while [ $pcnt -ne 11 ]
    do
      echo $pcnt is not 11, wait 3 second
      pcnt=`p.sh`
      sleep 3
    done

### POD1(1개)-POD2(10개) 부하 검증

    # 부하검증 전 시스템 안정화
    sleep 120

    # POD2 부하10 검증
    echo "====" >> $resultFile
    echo "Load Level10" >> $resultFile
    ps -eaf |grep urandom |grep -v grep| wc -l  >> $resultFile
    echo "====" >> $resultFile
    getLoad.sh >> $resultFile

    ## 종료(모든 부하 삭제)
    getpid.sh |xargs kill
    rm -f pid

## 종료(모든 부하 삭제)

    remove.sh
    # getpid.sh |xargs kill
    # rm pid
