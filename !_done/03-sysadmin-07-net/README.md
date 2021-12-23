# Домашнее задание к занятию "3.7. Компьютерные сети, лекция 2"
1. Windows  
    
            ipconfig /all
 
    Linux
    
        ip a
        
        ifconfig
        
1. Linux
    
        ip neigh
        
        #пакет lldpd
        lldpcli show neighbors

1. Пакет vlan  
    пример конфигурации
    
        auto eth0.1400
            iface eth0.1400 inet static
            address 192.168.1.1
            netmask 255.255.255.0
            vlan_raw_device eth0
            
1. Типы агрегации (bonding mode=X):
        
        mode = 0 (round robin) 
        mode = 1 (active-backup)
        mode = 2 (balance-xor)
        mode = 3 (broadcast)
        mode = 4 (802.3ad)
        mode = 5 (balance-tlb)
        mode = 6 (balance-alb)
        
    Пример конфигурации
    
        bonding mode=0 miimon=100 max_bonds=2 # miimon - интервал мониторинга, max_bonds - количество интерфейсов
        
        # The bond0 network interface
            auto bond0
            allow-hotplug bond0
            iface bond0 inet static
            address <ip-address>
            netmask <netmask>
            network <network-address>
            broadcast <broadcast-address>
            gateway <gateway-address>
            dns-nameservers <nameserver-one> <nameserver-two>
            dns-search <domain-name>
            up /sbin/ifenslave bond0 eth0
            up /sbin/ifenslave bond0 eth1
        
1. Сколько IP адресов в сети с маской /29? - 7 адресов: 6 хосты + 1 broadcast  
   Сколько /29 подсетей можно получить из сети с маской /24? - 32  
   Примеры /29 подсетей внутри сети 10.10.10.0/24:    
    
        Network:   10.10.10.24/29        
        Broadcast: 10.10.10.31           
        HostMin:   10.10.10.25           
        HostMax:   10.10.10.30 
        
        Network:   10.10.10.192/29       
        Broadcast: 10.10.10.199         
        HostMin:   10.10.10.193          
        HostMax:   10.10.10.198    
        
1. можно взять адреса 100.64.0.0/26

        Network:   100.64.0.0/26         
        Broadcast: 100.64.0.63          
        HostMin:   100.64.0.1           
        HostMax:   100.64.0.62

1. Windows

        arp -a - посмотреть
        arp -d - удалить все 
        arp -d 192.168.1.1  - удалить по IP
        
   Linux
        
        arp -n - просмотреть
        ip -s -s neigh flush all - очистить cache ARP
        arp -d 192.168.1.1 - удалить по IP
        
         
