
## repository install

    rpm -Uvh https://repo.zabbix.com/zabbix/5.0/rhel/7/x86_64/zabbix-release-5.0-1.el7.noarch.rpm
    yum clean all

## Install Zabbix server and agent
    # yum install -y zabbix-server-mysql zabbix-agent

## c. Install Zabbix frontend
### Repository 설정

    # yum install -y centos-release-scl

vi  /etc/yum.repos.d/zabbix.repo
"enabled=1" 0에서 1로 변경

    [zabbix-frontend]
    name=Zabbix Official Repository frontend - $basearch
    baseurl=http://repo.zabbix.com/zabbix/5.0/rhel/7/$basearch/frontend
    enabled=1

### Frontend 설치

    # yum install zabbix-web-mysql-scl zabbix-apache-conf-scl


## MySQL 설치



# mysql -uroot -p
password
mysql> create database zabbix character set utf8 collate utf8_bin;
mysql> create user zabbix@localhost identified by 'qwerASDF12#$';
mysql> grant all privileges on zabbix.* to zabbix@localhost;
mysql> ALTER USER 'zabbix'@'localhost' IDENTIFIED WITH mysql_native_password BY 'qwerASDF12#$';
mysql> quit;

오래걸림

    zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix
