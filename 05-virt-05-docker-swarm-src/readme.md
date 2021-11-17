#


## Задача 1
- В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?  
replication - указываем кодличество реплик которое нужно запустить для сервиса  
global - на каждой ноде роя будет запущена одна реплика сервиса.
- Какой алгоритм выбора лидера используется в Docker Swarm кластере?
Raft — алгоритм.   
Если обычный узел долго не получает сообщений от лидера, то он переходит в состояние «кандидат» и посылает другим узлам запрос на голосование. Другие узлы голосуют за того кандидата, от которого они получили первый запрос. Если кандидат получает сообщение от лидера, то он снимает свою кандидатуру и возвращается в обычное состояние. Если кандидат получает большинство голосов, то он становится лидером. Если же он не получил большинства (это случай, когда на кластере возникли сразу несколько кандидатов и голоса разделились), то кандидат ждёт случайное время и инициирует новую процедуру голосования.

Процедура голосования повторяется, пока не будет выбран лидер.
- Что такое Overlay Network?  
Сеть для взаиможествия сервисов расположенных в разных нодах.
## Задача 2

```buildoutcfg
external_ip_address_node01 = "51.250.0.224"
external_ip_address_node02 = "51.250.9.38"
external_ip_address_node03 = "51.250.7.246"
external_ip_address_node04 = "51.250.2.226"
external_ip_address_node05 = "51.250.10.145"
external_ip_address_node06 = "51.250.10.120"
internal_ip_address_node01 = "192.168.101.11"
internal_ip_address_node02 = "192.168.101.12"
internal_ip_address_node03 = "192.168.101.13"
internal_ip_address_node04 = "192.168.101.14"
internal_ip_address_node05 = "192.168.101.15"
internal_ip_address_node06 = "192.168.101.16"
nposk@userver-1:~/05-virt-05-docker-swarm-src/terraform$ ssh centos@51.250.0.224
[centos@node01 ~]$ sudo -i
[root@node01 ~]# docker node ls
ID                            HOSTNAME             STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
fb8vnyw1qy9s4n5fwte2uu0ss *   node01.netology.yc   Ready     Active         Leader           20.10.10
kropprq61zf4wuzknke6nxwew     node02.netology.yc   Ready     Active         Reachable        20.10.10
lrx2y9q8l3d7u9w94oktyw959     node03.netology.yc   Ready     Active         Reachable        20.10.10
kvf5qzlyevpavyn12bg03f0yo     node04.netology.yc   Ready     Active                          20.10.10
i7cnxjluba3i0l6no3h6lrdb2     node05.netology.yc   Ready     Active                          20.10.10
ou2y7vrejqjwl0zoo401kysoe     node06.netology.yc   Ready     Active                          20.10.10
[root@node01 ~]#
```


## Задача 3
```

[root@node01 ~]# docker service ls
ID             NAME                                MODE         REPLICAS   IMAGE                                          PORTS
uf8r18u503gx   swarm_monitoring_alertmanager       replicated   1/1        stefanprodan/swarmprom-alertmanager:v0.14.0
quy8bjnaocq8   swarm_monitoring_caddy              replicated   1/1        stefanprodan/caddy:latest                      *:3000->3000/tcp, *:9090->9090/tcp, *:9093-9094->9093-9094/tcp
8y25shnhwztk   swarm_monitoring_cadvisor           global       6/6        google/cadvisor:latest
adz297rt9hzz   swarm_monitoring_dockerd-exporter   global       6/6        stefanprodan/caddy:latest
bgiqma0vo05r   swarm_monitoring_grafana            replicated   1/1        stefanprodan/swarmprom-grafana:5.3.4
j33mbi3nwif8   swarm_monitoring_node-exporter      global       6/6        stefanprodan/swarmprom-node-exporter:v0.16.0
bc5nijp80ym0   swarm_monitoring_prometheus         replicated   1/1        stefanprodan/swarmprom-prometheus:v2.5.0
m7sx0dl9dtg4   swarm_monitoring_unsee              replicated   1/1        cloudflare/unsee:v0.8.0

```

## Задача 4
Данная команда включает функцию подтверждения изменения роя с помощью ключа шифрования.
```buildoutcfg
[root@node01 ~]# docker swarm update --autolock=true
Swarm updated.
To unlock a swarm manager after it restarts, run the `docker swarm unlock`
command and provide the following key:

    SWMKEY-1-mmxbVP762AWPGeJPMyCC/dI69FE4Ymg5s9J5AM3HmNc

Please remember to store this key in a password manager, since without it you
will not be able to restart the manager.
```