

# 모듈 설치

## Zabbix repository 설정

    # rpm -Uvh https://repo.zabbix.com/zabbix/5.0/rhel/7/x86_64/zabbix-release-5.0-1.el7.noarch.rpm
    # yum clean all

## Zabbix server, agent 설치
    # yum install -y zabbix-server-mysql zabbix-agent

### Frontend Repository 설정
Red Hat Software Collections 활성화

    # yum install -y centos-release-scl

### Frontend 설치

    # yum --enablerepo=zabbix-frontend install -y zabbix-web-mysql-scl zabbix-apache-conf-scl

# DB 설치

## MySQL Repository 설정

    rpm -Uvh https://repo.mysql.com/mysql80-community-release-el7-3.noarch.rpm
#    sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/mysql-community.repo

## MySQL 설치

    yum --enablerepo=mysql80-community install -y mysql-community-server

## 서비스 기동

    systemctl start mysqld
    systemctl enable mysqld


서비스 기동 시 임시 패스워드가 생성되는데,
아래의 경로에서 임시패스워드 확인 가능

    grep "A temporary password" /var/log/mysqld.log
    [Note] A temporary password is generated for root@localhost: hjkygMukj5+t783

MySQL에 접속해서 비밀번호 변경 필요

    [root@cb42b4da054a /]# mysql -uroot -p
    Enter password:      # 임시 패스워드 입력(e.g. hjkygMukj5+t783)
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 8
    Server version: 8.0.21

    Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

    Oracle is a registered trademark of Oracle Corporation and/or its
    affiliates. Other names may be trademarks of their respective
    owners.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

최초 root비밀번호 변경 필요

    mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'qwerASDF12#$';






## DB데이터 임포트

mysql> create database zabbix character set utf8 collate utf8_bin;
mysql> create user zabbix@localhost identified by 'qwerASDF12#$';
mysql> grant all privileges on zabbix.* to zabbix@localhost;
mysql> ALTER USER 'zabbix'@'localhost' IDENTIFIED WITH mysql_native_password BY 'qwerASDF12#$';
mysql> quit;

오래걸림

    zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix


아래와 같이 나올 경우

    [root@7cfce74bb082 mysql]# zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix
    Enter password: gzip: /usr/share/doc/zabbix-server-mysql*/create.sql.gz: No such file or directory

수동으로 압축 해제 후 재실행

    wget https://repo.zabbix.com/zabbix/5.0/rhel/7/x86_64/zabbix-server-mysql-5.0.3-1.el7.x86_64.rpm
    mkdir tmp
    cd tmp
    rpm2cpio ../zabbix-server-mysql-5.0.3-1.el7.x86_64.rpm | cpio -idv
    mv ./usr/share/doc/zabbix-server-mysql-5.0.3 /usr/share/doc
    cd ..
    rm -rf tmp



## 서버 설정 변경

    vi /etc/zabbix/zabbix_server.conf

    ### Option: DBPassword
    #       Database password.
    #       Comment this line if no password is used.
    #
    # Mandatory: no
    # Default:
    # DBPassword=
    DBPassword=qwerASDF12#$

    vi /etc/opt/rh/rh-php72/php-fpm.d/zabbix.conf

    php_value[date.timezone] = Asia/Seoul



## Zabbix 시작

    systemctl restart zabbix-server zabbix-agent httpd rh-php72-php-fpm
    systemctl enable zabbix-server zabbix-agent httpd rh-php72-php-fpm
