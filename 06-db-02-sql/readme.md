# Домашнее задание к занятию "6.2. SQL"

## 1

[docker compose](docker-compose.yml)
## 2

```buildoutcfg
postgres=# \l
                                       List of databases
     Name     |  Owner   | Encoding |  Collate   |   Ctype    |       Access privileges
--------------+----------+----------+------------+------------+--------------------------------
 06-db-02-sql | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 postgres     | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0    | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                   +
              |          |          |            |            | postgres=CTc/postgres
 template1    | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                   +
              |          |          |            |            | postgres=CTc/postgres
 test_db      | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/postgres                  +
              |          |          |            |            | postgres=CTc/postgres         +
              |          |          |            |            | "test-admin-user"=CTc/postgres
(5 rows)


test_db=# \d+ clients
                                                              Table "public.clients"
          Column          |       Type        | Collation | Nullable |               Default               | Storage  | Stats target | Description
--------------------------+-------------------+-----------+----------+-------------------------------------+----------+--------------+-------------
 id                       | integer           |           | not null | nextval('clients_id_seq'::regclass) | plain    |              |
 наименование             | character varying |           |          |                                     | extended |              |
 цена                     | integer           |           |          |                                     | plain    |              |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "orders" CONSTRAINT "orders_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES clients(id)
Access method: heap

test_db=# \d+ clients
                                                              Table "public.clients"
          Column          |       Type        | Collation | Nullable |               Default               | Storage  | Stats target | Description
--------------------------+-------------------+-----------+----------+-------------------------------------+----------+--------------+-------------
 id                       | integer           |           | not null | nextval('clients_id_seq'::regclass) | plain    |              |
 наименование             | character varying |           |          |                                     | extended |              |
 цена                     | integer           |           |          |                                     | plain    |              |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "orders" CONSTRAINT "orders_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES clients(id)
Access method: heap



postgres=# \du+
                                              List of roles
    Role name     |                         Attributes                         | Member of | Description
------------------+------------------------------------------------------------+-----------+-------------
 postgres         | Superuser, Create role, Create DB, Replication, Bypass RLS | {}        |
 test-admin-user  |                                                            | {}        |
 test-simple-user |                                                            | {}        |
```

Явно что не правильно, но 

```buildoutcfg
postgres=# select grantee, privilege_type from information_schema.role_table_grants where table_name='orders';
 grantee | privilege_type
---------+----------------
(0 rows)

postgres=# select grantee, privilege_type from information_schema.role_table_grants where table_name='clients';
 grantee | privilege_type
---------+----------------
(0 rows)

```

## 3 
```buildoutcfg
INSERT INTO orders (наименование, цена) VALUES ('Шоколад', 10);
INSERT INTO orders (наименование, цена) VALUES ('Принтер', 3000);
INSERT INTO orders (наименование, цена) VALUES ('Книга', 500);
INSERT INTO orders (наименование, цена) VALUES ('Монитор', 7000);
INSERT INTO orders (наименование, цена) VALUES ('Гитара', 4000);


INSERT INTO clients (фамилия, "страна проживания") VALUES ('Иванов Иван Иванович', 'USA');
INSERT INTO clients (фамилия, "страна проживания") VALUES ('Петров Петр Петрович', 'Canada');
INSERT INTO clients (фамилия, "страна проживания") VALUES ('Иоганн Себастьян Бах', 'Japan');
INSERT INTO clients (фамилия, "страна проживания") VALUES ('Ронни Джеймс Дио', 'Russia');
INSERT INTO clients (фамилия, "страна проживания") VALUES ('Иванов Иван Иванович', 'Russia');

```

```buildoutcfg
test_db=# SELECT  COUNT(*) FROM orders;  
 count
-------
     6
(1 row)

test_db=# SELECT COUNT(*) FROM clients;
 count
-------
     5
(1 row)
```

## 4
```
test_db=# INSERT INTO clients (фамилия, "страна проживания") VALUES ('Ritchie Blackmore', 'Russia');
INSERT 0 1
 UPDATE clients SET заказ = orders.id FROM orders WHERE orders.наименование='Монитор'  AND  clients.фамилия='Петров Петр Петрович' ;
UPDATE 1
 UPDATE clients SET заказ = orders.id FROM orders WHERE orders.наименование='Гитара'  AND  clients.фамилия='Иоганн Себастьян Бах');
UPDATE 1
```

```buildoutcfg
test_db=# select * from clients where заказ IS NOT NULL;
 id |             фамилия             | страна проживания | заказ
----+----------------------------------------+-----------------------------------+------------
  1 | Иванов Иван Иванович | USA                               |          4
  2 | Петров Петр Петрович | Canada                            |          5
  3 | Иоганн Себастьян Бах | Japan                             |          6
(3 rows)


```
Или

```buildoutcfg
test_db=# select clients.фамилия, orders.наименование from clients INNER JOIN orders ON clients.заказ=orders.id;
             фамилия             | наименование
----------------------------------------+--------------------------
 Иванов Иван Иванович | Книга
 Петров Петр Петрович | Монитор
 Иоганн Себастьян Бах | Гитара
(3 rows)

```

## 5
```buildoutcfg
test_db=# EXPLAIN select clients.фамилия, orders.наименование from clients INNER JOIN orders ON clients.заказ=orders.id;
                              QUERY PLAN
-----------------------------------------------------------------------
 Hash Join  (cost=37.00..57.24 rows=810 width=64)
   Hash Cond: (clients."заказ" = orders.id)
   ->  Seq Scan on clients  (cost=0.00..18.10 rows=810 width=36)
   ->  Hash  (cost=22.00..22.00 rows=1200 width=36)
         ->  Seq Scan on orders  (cost=0.00..22.00 rows=1200 width=36)
(5 rows)

```
Планировщик выбирает соединение по хешу, при котором строки одной таблицы записываются в хеш-таблицу в памяти, после чего сканируется другая таблица и для каждой её строки проверяется соответствие по хеш-таблице.
Затем она передаётся узлу Hash Join, который читает строки из узла внешнего потомка и проверяет их по этой хеш-таблице


## 6
Бекап
```buildoutcfg
 pg_dump test_db > test_db-$(date '+%Y-%m-%d').sql

postgres@c23de5cadf10:~$ ls /backup/
test_db-2021-11-26.sql
```

Восстановление
```buildoutcfg
psql test_db < test_db-2021-11-26.sql

```