# Домашнее задание к занятию "6.3. MySQL"


## 1
```buildoutcfg
--------------
mysql  Ver 8.0.27 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:          13
Current database:
Current user:           root@localhost
SSL:                    Not in use
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         8.0.27 MySQL Community Server - GPL
Protocol version:       10
Connection:             Localhost via UNIX socket
Server characterset:    utf8mb4
Db     characterset:    utf8mb4
Client characterset:    latin1
Conn.  characterset:    latin1
UNIX socket:            /var/run/mysqld/mysqld.sock
Binary data as:         Hexadecimal
Uptime:                 10 min 48 sec

Threads: 2  Questions: 52  Slow queries: 0  Opens: 154  Flush tables: 3  Open tables: 72  Queries per second avg: 0.080
--------------

```
```buildoutcfg
mysql> select * from orders where price>300;
+----+----------------+-------+
| id | title          | price |
+----+----------------+-------+
|  2 | My little pony |   500 |
+----+----------------+-------+
1 row in set (0.00 sec)
```



## 2
```buildoutcfg
mysql>  SELECT *
    ->  FROM INFORMATION_SCHEMA.USER_ATTRIBUTES
    ->  WHERE USER='test' AND HOST='localhost'
    -> ;
+------+-----------+----------------------------------------+
| USER | HOST      | ATTRIBUTE                              |
+------+-----------+----------------------------------------+
| test | localhost | {"Name": "James", "Surname": "Pretty"} |
+------+-----------+----------------------------------------+
1 row in set (0.01 sec)
```
## 3
```buildoutcfg
mysql> SELECT @@profiling;
+-------------+
| @@profiling |
+-------------+
|           0 |
+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> SELECT @@profiling;
+-------------+
| @@profiling |
+-------------+
|           1 |
+-------------+
1 row in set, 1 warning (0.00 sec)


mysql> use test_db;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SHOW TABLE STATUS\G
*************************** 1. row ***************************
           Name: orders
         Engine: InnoDB
        Version: 10
     Row_format: Dynamic
           Rows: 5
 Avg_row_length: 3276
    Data_length: 16384
Max_data_length: 0
   Index_length: 0
      Data_free: 0
 Auto_increment: 6
    Create_time: 2021-11-28 16:59:16
    Update_time: NULL
     Check_time: NULL
      Collation: utf8mb4_0900_ai_ci
       Checksum: NULL
 Create_options:
        Comment:
1 row in set (0.04 sec)



mysql> SHOW PROFILES;
+----------+------------+------------------------------------------------------+
| Query_ID | Duration   | Query                                                |
+----------+------------+------------------------------------------------------+
|        1 | 0.00029875 | SELECT @@profiling                                   |
|        2 | 0.00133850 | SHOW TABLE STATUS LIKE 'table'                       |
|        3 | 0.00016200 | SHOW TABLE STATUS LIKE 'test_db'                     |
|        4 | 0.04721200 | SHOW DATABASES                                       |
|        5 | 0.00333175 | SELECT DATABASE()                                    |
|        6 | 0.00104025 | show databases                                       |
|        7 | 0.00986950 | show tables                                          |
|        8 | 0.03186200 | SHOW TABLE STATUS                                    |
|        9 | 0.01726150 | UPDATE `orders` SET title='Peace and War' where id=1 |
|       10 | 0.15428625 | ALTER TABLE orders ENGINE = MyISAM                   |
|       11 | 0.00725700 | UPDATE `orders` SET title='WAR and PEACE' where id=1 |
+----------+------------+------------------------------------------------------+
11 rows in set, 1 warning (0.00 sec)

```

## 4
```buildoutcfg
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

#Added
innodb_io_capacity      = 1000 
innodb_file_per_table   = 1
innodb_file_format      = Barracuda
innodb-log-buffer-size  = 1048576
innodb_buffer_pool_size = 1914888
max_binlog_size         = 100M     


```