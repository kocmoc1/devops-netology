# Домашнее задание к занятию "3.4. Операционные системы, лекция 2"
1. vagrant@vagrant:/etc$ systemctl cat node_exporter  
`# /etc/systemd/system/node_exporter.service`  
`[Unit]`  
`Description=Node Exporter`  
`[Service]`  
`User=node_exporter`  
`EnvironmentFile=/etc/sysconfig/node_exporter`  
`ExecStart=/usr/sbin/node_exporter $OPTIONS`  
`[Install]`  
`WantedBy=multi-user.target`  
vagrant@vagrant:/etc$ cat /etc/sysconfig/node_exporter  
`OPTIONS="--collector.cpu --collector.cpu.info --collector.meminfo --collector.diskstats  --collector.systemd --collector.netstat --collector.textfile.directory /var/log/node_exporter/textfile_collector"`

1. `--collector.cpu --collector.cpu.info --collector.meminfo --collector.diskstats  --collector.systemd --collector.netstat --collector.textfile.directory`

1. [Скриншот](https://drive.google.com/file/d/1NEiKc6fDuPX8RsO2RpIEib4N_1OWExmV/view?usp=sharing)
1. `dmesg | grep Hypervisor` >> [0.000000] Hypervisor detected: KVM  
1. `fs.nr_open = 1048576` - Обозначает максимальное количество файлов-дискрипторов которые может выделить процесс.  
`ulimit --help` >> open files (-n) 1048576, ничего не ограничивает, они равны.
1. Не совсем корректно выполнил задание. В Slack спрашивал, внятного ответа не получил.  

        Terminal 1:
            vagrant@vagrant:~$ sudo -i
            root@vagrant:~# screen
            root@vagrant:~#
            root@vagrant:~# unshare -f --pid --mount-proc sleep 1h

        Terminal 2:
        root@vagrant:/# ps aux | grep sleep
        root       14372  0.0  0.0   8080   528 pts/1    S+   08:31   0:00 unshare -f --pid --mount-proc sleep 1h
        root       14373  0.0  0.0   8076   596 pts/1    S+   08:31   0:00 sleep 1h
        root       14467  0.0  0.0   8900   736 pts/2    S+   08:37   0:00 grep --color=auto sleep
        root@vagrant:/# nsenter --target 14373 --pid --mount
        root@vagrant:/# ps
            PID TTY          TIME CMD
          14427 pts/2    00:00:00 sudo
          14428 pts/2    00:00:00 bash
          14438 pts/2    00:00:00 nsenter
          14439 pts/2    00:00:00 bash
          14453 pts/2    00:00:00 nsenter
          14454 pts/2    00:00:00 bash
          14463 pts/2    00:00:00 ps



 
1. `:(){ :|:& };:` Функция : которая вызывает сама себя 2 раза без вывода в pty.  
`[58918.941676] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-18.scope`  
`[58924.053954] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-20.scope`  
cgroup - механизм уровня ядра, позволяющий управлять использованием системных ресурсов  
по умолчанию, там же его можно изменить:  
cat /sys/fs/cgroup/pids/user.slice/user-1000.slice/pids.max   
`2356`
