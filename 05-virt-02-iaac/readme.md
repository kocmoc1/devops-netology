# Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"

1.  Основные преимущества применения на практике IaaC паттернов: унификация методов разработки, тестирования, и развертывания разрабатываемых пробуктов. Возможность менять конфигурации серверной инфраструктуры на "лету". Минимизация недоступоности ПО и ошибок при проектировании.
Основопологающий принцип IaaC - иденпатентность - получение заранее известно результатат на всех этапах жизненного цикла разработки ПО.

1. Основные преимущества  Ansible - проще в использовании, простая установка и настройка, легкая система масштабирования и тирражирования.
На мой взгляд PUSH метоб более надежный, так как при использовании PULL метода неоходима постоянная связь клиента с сервером, что сложнее в отладке. 
При PUSH методе сервер конфигурации сначала связывается с серверами и в случае недоступности выдаст предупреждение.
1.    Задание 3

           nposk@userver-1:~$ ansible --version  
           ansible 2.9.9  
             config file = /etc/ansible/ansible.cfg  
              configured module search path = ['/home/nposk/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']  
              ansible python module location = /usr/lib/python3/dist-packages/ansible  
              executable location = /usr/bin/ansible  
              python version = 3.8.10 (default, Jun  2 2021, 10:49:15) [GCC 10.3.0]  
            nposk@userver-1:~$ vagrant -v  
            Vagrant 2.2.18  
            nposk@userver-1:~$ virtualbox -h  
            Oracle VM VirtualBox VM Selector v6.1.26    
        
1. Не смог запустить playbook, не могу найти ошибку.
        
        ERROR! We were unable to read either as JSON nor YAML, these are the errors we got from each:
        JSON: Expecting value: line 1 column 1 (char 0)
        
        Syntax Error while loading YAML.
          mapping values are not allowed in this context
        
        The error appears to be in '/home/nposk/Desktop/ansible/provision.yml': line 4, column 11, but may
        be elsewhere in the file depending on the exact syntax problem.
        
        The offending line appears to be:
        
        
            become: yes
                  ^ here
        Ansible failed to complete successfully. Any error output should be
        visible above. Please fix these errors and try again.