# Домашнее задание к занятию "6.4. PostgreSQL"

## 1
1. вывода списка БД - \l
1. подключения к БД - \c
1. вывода списка таблиц - \dt или SELECT * FROM pg_catalog.pg_tables;
1. вывода описания содержимого таблиц - \d table_name
1. выхода из psql - \q

## 2
```
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
```

```buildoutcfg
test_database=# select attname,tablename,avg_width from pg_stats where tablename = 'orders';
 attname | tablename | avg_width
---------+-----------+-----------
 id      | orders    |         4
 title   | orders    |        16
 price   | orders    |         4
(3 rows)

```
## 3

CREATE TABLE orders_1  (LIKE orders);
INSERT INTO orders_1 SELECT * FROM orders WHERE
	price>499;
DELETE FROM orders WHERE price>499;

CREATE TABLE orders_2   (LIKE orders);
INSERT INTO orders_2  SELECT * FROM orders WHERE
	price<=499;
DELETE FROM orders WHERE price<=499;

```buildoutcfg
test_database=# \dt+
                               List of relations
 Schema |   Name   | Type  |  Owner   | Persistence |    Size    | Description
--------+----------+-------+----------+-------------+------------+-------------
 public | orders   | table | postgres | permanent   | 8192 bytes |
 public | orders_1 | table | postgres | permanent   | 8192 bytes |
 public | orders_2 | table | postgres | permanent   | 8192 bytes |
(3 rows)

test_database=# select * from orders;
 id | title | price
----+-------+-------
(0 rows)

test_database=# select * from orders_1;
 id |       title        | price
----+--------------------+-------
  2 | My little database |   500
  6 | WAL never lies     |   900
  8 | Dbiezdmin          |   501
(3 rows)

test_database=# select * from orders_2;
 id |        title         | price
----+----------------------+-------
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
(5 rows)

```
На сколько я понял механизм шардирования можно реализовать тригером при INSERT.

## 4
Для уникальности можно добвить к title имя таблицы.
```buildoutcfg
postgres@af6c66c4cdce:~$ pg_dump test_database >> /backup/new_dump.sql
postgres@af6c66c4cdce:~$ ll /backup/
-bash: ll: command not found
postgres@af6c66c4cdce:~$ ls -la /backup/
total 12
drwxrwxrwx 1 root     root      512 Dec  5 17:56 .
drwxr-xr-x 1 root     root     4096 Dec  5 17:11 ..
-rw-r--r-- 1 postgres postgres 2846 Dec  5 17:56 new_dump.sql
-rwxrwxrwx 1 root     root     2082 Dec  5 17:10 test_dump.sql
postgres@af6c66c4cdce:~$

```