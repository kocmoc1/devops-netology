# Домашнее задание к занятию "3.6. Компьютерные сети, лекция 1"
1. `HTTP/1.1 301 Moved Permanently` - ответ от сервера в ситуации, когда запрошенный ресурс был на постоянной основе перемещён в новое месторасположение, и указывающий на то, что текущие ссылки, использующие данный URL, должны быть обновлены.
1. `Status Code: 307 Internal Redirect`   
    Дольше всего выполнялся запрос на https://www.google-analytics.com/analytics.js - результат failed, время 2.06s  
    [Скриншот](https://drive.google.com/file/d/1-qNXNqzPhTcf4thawx8XiJNmb4j8s_fn/view?usp=sharing)
1. IP 178.47.1x0.1x0 (не хочу публиковать статичный ip)
1. Ростелеком - PJSC Rostelecom, AS12389
1.  traceroute 8.8.8.8

        traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets 
         1  _gateway (172.16.0.1)  0.238 ms  0.178 ms  0.159 ms - local network
         2  192.168.254.1 (192.168.254.1)  0.265 ms  0.304 ms  0.239 ms - local network
         3  dsl-178-47-130-129.permonline.ru (178.47.130.129)  0.892 ms  0.863 ms  0.863  - AS12389                                                                 ms
         4  90.150.2.25 (90.150.2.25)  0.766 ms  0.786 ms  0.718 ms  - AS12389 
         5  90.150.2.26 (90.150.2.26)  1.884 ms  1.921 ms  1.589 ms  - AS12389 
         6  87.226.181.89 (87.226.181.89)  21.740 ms  22.337 ms  21.757 ms  - AS12389
         7  74.125.52.232 (74.125.52.232)  21.892 ms 74.125.51.172 (74.125.51.172)  21.7  - AS15169                                                                69 ms 74.125.52.232 (74.125.52.232)  21.828 ms
         8  108.170.250.34 (108.170.250.34)  22.324 ms 108.170.250.99 (108.170.250.99)      - AS15169                                                                22.528 ms 108.170.250.146 (108.170.250.146)  23.555 ms
         9  * 142.251.49.24 (142.251.49.24)  37.015 ms 172.253.66.116 (172.253.66.116)      - AS15169                                                             37.299 ms
        10  172.253.66.108 (172.253.66.108)  40.591 ms 216.239.57.222 (216.239.57.222)       - AS15169                                                            35.052 ms 108.170.235.204 (108.170.235.204)  41.303 ms
        11  172.253.70.47 (172.253.70.47)  37.116 ms 142.250.56.15 (142.250.56.15)  34.2       - AS15169                                                          01 ms 172.253.64.57 (172.253.64.57)  40.703 ms
        12  * * *
        13  * * *
        14  * * *
        15  * * *
        16  * * *
        17  * * *
        18  * * *
        19  * * *
        20  * * *
        21  dns.google (8.8.8.8)  37.573 ms * *   LUMEN ASN

1. mtr 8.8.8.8

        Packets               Pings
        Host                                                                                                 Loss%   Snt   Last   Avg  Best  Wrst StDev
        ...
        9. 142.251.49.24                                                                                      0.0%     9   37.0  37.1  36.9  37.4   0.2
        ....

1.  user@userver-1:~$ dig -x 8.8.8.8
       
        ; <<>> DiG 9.16.6-Ubuntu <<>> -x 8.8.8.8
        ;; global options: +cmd
        ;; Got answer:
        ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 19873
        ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1
        
        ;; OPT PSEUDOSECTION:
        ; EDNS: version: 0, flags:; udp: 65494
        ;; QUESTION SECTION:
        ;8.8.8.8.in-addr.arpa.          IN      PTR
        
        ;; ANSWER SECTION:
        8.8.8.8.in-addr.arpa.   5160    IN      PTR     dns.google.
        
        ;; Query time: 0 msec
        ;; SERVER: 127.0.0.53#53(127.0.0.53)
        ;; WHEN: Thu Sep 16 06:48:47 UTC 2021
        ;; MSG SIZE  rcvd: 73
        
       user@userver-1:~$ dig -x 8.8.4.4
        
        ; <<>> DiG 9.16.6-Ubuntu <<>> -x 8.8.4.4
        ;; global options: +cmd
        ;; Got answer:
        ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 64690
        ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1
        
        ;; OPT PSEUDOSECTION:
        ; EDNS: version: 0, flags:; udp: 65494
        ;; QUESTION SECTION:
        ;4.4.8.8.in-addr.arpa.          IN      PTR
        
        ;; ANSWER SECTION:
        4.4.8.8.in-addr.arpa.   21331   IN      PTR     dns.google.
        
        ;; Query time: 35 msec
        ;; SERVER: 127.0.0.53#53(127.0.0.53)
        ;; WHEN: Thu Sep 16 06:49:12 UTC 2021
        ;; MSG SIZE  rcvd: 73





