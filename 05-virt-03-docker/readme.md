#Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

## Задача 1
 [Docker hub](https://hub.docker.com/r/kocmoc1/netology/tags)

## Задача 2
- Высоконагруженное монолитное java веб-приложение - в данном случае лучше использовать виртальный или физически сервер. В JVM отсутствует механизм определения в какой среде он запускается в связи с этим могут возникнуть ряд проблем, например с лимитами по ресурсам.
- Nodejs веб-приложение - вполне может быть запущен в Docker.
- Мобильное приложение c версиями для Android и iOS - скорее всего подразумевается backend приложения. Так как в большинстве случаев работа можбильных приложениий организована по API, а оно будет состоять и нескольких серверов - то вподне весь этот набор можно контейнеризировать.
- Шина данных на базе Apache Kafka - все зависит от объема передаваемых данных. В случае небольшого объема думаю можно запустить и в Docker.
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana - так же зависит от обьема данных, всю связку возможно реализовать в Docker.
- Мониторинг-стек на базе Prometheus и Grafana - Docker.
- MongoDB, как основное хранилище данных для java-приложения - в данному случе я бы выбрал виртуальный сервер. 
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry - так как предполагается хранение больших объемов логичнее выбрать вируальный\физический сервер.

## Задача 3
Debian

```
# bash
root@0ff53f15cac2:/# cd /mnt/data/
root@0ff53f15cac2:/mnt/data# ls
123.txt  newfile.txt
root@0ff53f15cac2:/mnt/data# echo "File from host" >> 123.txt
root@0ff53f15cac2:/mnt/data# echo "Hello from debian" >> newfile.txt
root@0ff53f15cac2:/mnt/data# cat 123.txt
File from host
root@0ff53f15cac2:/mnt/data# cat newfile.txt
Privet from Centos 7\!
Privet from Centos 7!
Hello from debian
root@0ff53f15cac2:/mnt/data#
```
Centos 
```
sh-4.2# bash
[root@1f6f6f48a1a0 /]# cd /mnt/data/
[root@1f6f6f48a1a0 data]# ls
123.txt
[root@1f6f6f48a1a0 data]# touch newfile.txt
[root@1f6f6f48a1a0 data]# echo "Privet from Centos 7\!" >> newfile.txt
[root@1f6f6f48a1a0 data]# cat newfile.txt
Privet from Centos 7\!
[root@1f6f6f48a1a0 data]# echo "Privet from Centos 7! " >> newfile.txt
[root@1f6f6f48a1a0 data]#
```

## Задача 4
[docker hub](https://hub.docker.com/r/kocmoc1/ansible)
