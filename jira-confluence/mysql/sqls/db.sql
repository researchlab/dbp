--创建jira数据库及用户
--drop database jira;
create database jira character set 'UTF8';
create user jira identified by 'jira';
grant all privileges on `jira`.* to 'jira'@'172.%' identified by 'jira' with grant option;
grant all privileges on `jira`.* to 'jira'@'localhost' identified by 'jira' with grant option;
flush privileges;

--创建confluence数据库及用户
--drop database confluence;
create database confluence character set 'UTF8';
create user confluence identified by 'confluence';
grant all privileges on `confluence`.* to 'confluence'@'%' identified by 'confluence' with grant option;
grant all privileges on `confluence`.* to 'confluence'@'localhost' identified by 'confluence' with grant option;
flush privileges;
--设置confluence字符集
alter database confluence character set utf8 collate utf8_bin;
-- confluence要求设置事务级别为READ-COMMITTED
set global tx_isolation='READ-COMMITTED';
--set session transaction isolation level read committed;
--show variables like 'tx%';
