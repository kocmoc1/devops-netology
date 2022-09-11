# Домашнее задание к занятию "15.1. Организация сети"

Создание инфраструктуры на основани [main.tf](main.tf)
```
yandex_vpc_subnet.public-subnet-a: Creating...
yandex_vpc_subnet.private-subnet-a: Creating...
yandex_vpc_subnet.private-subnet-a: Creation complete after 1s [id=e9bgfvt8o578kbpk08g9]
yandex_compute_instance.private-subnet-ubuntu: Creating...
yandex_vpc_subnet.public-subnet-a: Creation complete after 2s [id=e9bljmn5kf8jar5pno9m]
yandex_compute_instance.public-subnet-ubuntu: Creating...
yandex_compute_instance.nat-instance: Creating...
yandex_compute_instance.private-subnet-ubuntu: Still creating... [10s elapsed]
yandex_compute_instance.public-subnet-ubuntu: Still creating... [10s elapsed]
yandex_compute_instance.nat-instance: Still creating... [10s elapsed]
yandex_compute_instance.private-subnet-ubuntu: Still creating... [20s elapsed]
yandex_compute_instance.public-subnet-ubuntu: Still creating... [20s elapsed]
yandex_compute_instance.nat-instance: Still creating... [20s elapsed]
yandex_compute_instance.private-subnet-ubuntu: Creation complete after 30s [id=fhm08ibd353hnbnekdu5]
yandex_compute_instance.public-subnet-ubuntu: Still creating... [30s elapsed]
yandex_compute_instance.nat-instance: Still creating... [30s elapsed]
yandex_compute_instance.public-subnet-ubuntu: Creation complete after 34s [id=fhmqpu5c5ljlmme1i4be]
yandex_compute_instance.nat-instance: Still creating... [40s elapsed]
yandex_compute_instance.nat-instance: Still creating... [50s elapsed]
yandex_compute_instance.nat-instance: Creation complete after 51s [id=fhm640rqis83as9jb1re]
yandex_vpc_route_table.private-rt-a: Creating...
yandex_vpc_route_table.private-rt-a: Creation complete after 1s [id=enpf5vnvoa3lncvp1gph]
Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
```
Подключение к public-instance
```
nposk@prm-niuposkr:/mnt/d/netology/15-1$ ssh ubuntu@51.250.84.101
The authenticity of host '51.250.84.101 (51.250.84.101)' can't be established.
ECDSA key fingerprint is SHA256:MSGp3tZK9nHbb/wrrvsL3lVyoHPV6lZBla01myXlpZI.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '51.250.84.101' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.13.0-40-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.
```
Проверка доступа в интернет - ok
```
ubuntu@fhmqpu5c5ljlmme1i4be:~$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=61 time=19.0 ms

--- 8.8.8.8 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 19.002/19.002/19.002/0.000 ms
```

Подключение к private-instance
```
ubuntu@fhmqpu5c5ljlmme1i4be:~$ ssh ubuntu@192.168.20.13
The authenticity of host '192.168.20.13 (192.168.20.13)' can't be established.
ECDSA key fingerprint is SHA256:y7jRi5Zx7CGU47/EXvSy1rdGx3IOoOA7bTMhJQVSw6I.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.20.13' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.13.0-40-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.
```
Проверка доступа в интернет - не ok
```
ubuntu@fhm08ibd353hnbnekdu5:~$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
^C
--- 8.8.8.8 ping statistics ---
4 packets transmitted, 0 received, 100% packet loss, time 3078ms

ubuntu@fhm08ibd353hnbnekdu5:~$ ip route
default via 192.168.20.1 dev eth0 proto dhcp src 192.168.20.13 metric 100
172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown
192.168.20.0/24 dev eth0 proto kernel scope link src 192.168.20.13
192.168.20.1 dev eth0 proto dhcp scope link src 192.168.20.13 metric 100
ubuntu@fhm08ibd353hnbnekdu5:~$
```
