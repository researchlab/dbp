## 登录root 账号
```
docker exec -it 414073e2f735 mysql -uroot -p
密码就是MYSQL_ROOT_PASSWORD=dev123456
```

通过root账号创建数据库
```
--- 创建数据库
create database confluence default charset utf8;

--- 修改排序规则;
alter database confluence collate utf8_bin;

--- 修改默认隔离级别;
set global transaction isolation level READ COMMITTED;
```

## More 

1.mysql创建数据库指定utf8编码
```
CREATE DATABASE IF NOT EXISTS dbname DEFAULT CHARSET utf8;

```

2.MySql授予用户指定数据库权限
```
/*授予用户通过外网IP对于该数据库的全部权限*/

　　grant all privileges on `test`.* to 'test'@'%' ;

　 /*授予用户在本地服务器对该数据库的全部权限*/

　　grant all privileges on `test`.* to 'test'@'localhost';

   grant select on test.* to 'user1'@'localhost';  /*给予查询权限*/

   grant insert on test.* to 'user1'@'localhost'; /*添加插入权限*/

   grant delete on test.* to 'user1'@'localhost'; /*添加删除权限*/

   grant update on test.* to 'user1'@'localhost'; /*添加权限*/

　 flush privileges; /*刷新权限*/

```

3.修改数据库字符集和排序规则

数据库字符集 》表的字符集 》 字段的字符集 （从前往后优先级由低到高，从左往右继承，如果表没设置字符集，继承数据库的，如果字段没设置，继承表的）

数据库的字符集如果是utf8，表和字段的字符集继承

字段的字符集和排序规则继承自表，例如表的字符集为latin1,那表的字段（字符型）都是latin1

修改表的字符集对新增加字段有用，但是老字段字符集不变，应再编写脚本修改老数据的字符集

show variableslike "%char%" ;显示 character_set_database 为 latin1，如果想显示utf8，应该修改所有数据库的默认字符集为utf8

```
--- 修改数据库字符集和排序规则
alter database xc  character set utf8 collate utf8_general_ci;
--- 查看数据库的字符集
select * from information_schema.schemata where schema_name = 'db_name';
--- 修改表默认的字符集
alter table table_name character set gbk collate gbk_bin;
--- 修改表数据的字符集
alter table table_name convert to character set gbk collate gbk_bin; 
--- 查看表的字符集
select * from information_schema.tables where table_schema = 'db_name' and table_name = 'table_name';
--- 修改字段的字符集
alter table table_name change column_name varchar(50) character set gbk collate gbk_bin;
--- 查看字段的字符集
select * from information_schema.columns where table_schema = 'db_name' and table_name = 'table_name';
```

4.MySQL设置数据库隔离级别
```
可以通过命令行设置全局 或 会话的隔离级别。重启或者退出会话失效

SET [SESSION | GLOBAL] TRANSACTION ISOLATION LEVEL {READ UNCOMMITTED | READ COMMITTED | REPEATABLE READ | SERIALIZABLE}
 具体命令

# 设置全局隔离级别

set global transaction isolation level REPEATABLE READ;
set global transaction isolation level  READ COMMITTED;
set global transaction isolation level READ UNCOMMITTED;
set global transaction isolation level SERIALIZABLE;

#设置会话隔离级别

set session transaction isolation level REPEATABLE READ;
set session transaction isolation level READ COMMITTED;
set session transaction isolation level READ UNCOMMITTED;
set session transaction isolation level SERIALIZABLE;
通过配置文件设置隔离级别

[mysqld]
transaction-isolation = REPEATABLE-READ
transaction-isolation = READ-COMMITTED
transaction-isolation = READ-UNCOMMITTED
transaction-isolation = SERIALIZABLE
查看隔离级别

SELECT @@GLOBAL.transaction_isolation
SELECT @@SESSION.transaction_isolation
show variables like '%iso%';
```

5.设置充许的最大数据包 为34M
```
mysql> show variables like '%max_allowed_packet%';
+--------------------------+------------+
| Variable_name            | Value      |
+--------------------------+------------+
| max_allowed_packet       | 4194304    |
| slave_max_allowed_packet | 1073741824 |
+--------------------------+------------+
2 rows in set (0.01 sec)

mysql> set global max_allowed_packet= 34 * 1024 *1024;
Query OK, 0 rows affected (0.00 sec)

然后重启mysql
```
