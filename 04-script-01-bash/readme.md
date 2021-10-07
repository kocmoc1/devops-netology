# Домашнее задание к занятию "4.1. Командная оболочка Bash: Практические навыки"

1. c: a+b  - так как будет интерпритировано как строка "a+b"  
d: 1+2 - "+" - строка; $a и $b - переменные - в итоге получаем строку  
e: 3 - будет посчитан резултят сложения $a и $b

1. Скрипт изнавально не рабочий, не хватало ")" в строуе while
        
        #!/bin/bash

        while ((1==1))
        do
         curl https://localhost:4757
         if (($? != 0))
          then
            date >> curl.log
          else
            exit 0
         fi
        done

1.  Скрипт
    
        #!/bin/bash
        ip=('192.168.200.1' '173.194.222.113' '87.250.250.242')
        for item in ${ip[*]}
         do
         res=0
            for ((i=1;i<=5;i++))
            do
                timeout 2 bash -c "</dev/tcp/$item/80" &>> /dev/null
                if [ $? -gt 0 ]
                then
                 ((res=res+1))
                fi
            done
              if [ $res -gt 0 ]
              then
               echo '[INFO]: Host ' $item ' is availiable. ' >> work3.log
              else
               echo '[ERROR]: Host ' $item ' unreachable' >> work3.log
              fi
        done
        exit 0

1. Скрипт

        #!/bin/bash
        ip=('192.168.200.1' '173.194.222.113' '87.250.250.242')
        for item in ${ip[*]}
         do
         res=0
            timeout 2 bash -c "</dev/tcp/$item/80" &>> /dev/null
            if [ $? -gt 0 ]
            then
             ((res=res+1))
            fi
              if [ $res -gt 0 ]
              then
               echo '[INFO]: Host ' $item ' is availiable. ' >> work3.log
              else
               echo '[ERROR]: Host ' $item ' unreachable' >> work3.log
               exit 0
              fi
        done
        exit 0