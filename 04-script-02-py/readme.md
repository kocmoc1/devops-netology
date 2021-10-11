

1. Какое значение будет присвоено переменной c?

        >>> a = 1
        >>> b = '2'
        >>> c = a + b
        Traceback (most recent call last):
          File "<stdin>", line 1, in <module>
        TypeError: unsupported operand type(s) for +: 'int' and 'str'
        >>> c
        Traceback (most recent call last):
          File "<stdin>", line 1, in <module>
        NameError: name 'c' is not defined  

    Как получить для переменной c значение 12?

        >>> c = str(a)+b
        >>> print(c)
        12
     
    Как получить для переменной c значение 3?
    
        >>> c = a+int(b)
        >>> print(c)
        3
        >>>
        
1. Обновленный скрипт

        #!/usr/bin/env python3

        import os
        bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
        result_os = os.popen(' && '.join(bash_command)).read()
        is_change = False
        for result in result_os.split('\n'):
            if result.find('modified') != -1:
                prepare_result = result.replace('\tmodified:   ', '')
                print(os.path.abspath(os.getcwd())) #добавлено
                print(prepare_result)
                #break - убрано

1. Скрипт 

        #!/usr/bin/env python3
        import argparse
        import os
        parser = argparse.ArgumentParser()
        parser.add_argument("--path", "-p", help="set git directory location")
        args = parser.parse_args()
        if args.path:
            if os.path.isdir(args.path):
                print("git dir is %s" % args.path)
                bash_command = ["cd " + args.path, "git status"]
                result_os = os.popen(' && '.join(bash_command)).read()
                is_change = False
                for result in result_os.split('\n'):
                    if result.find('modified') != -1:
                        prepare_result = result.replace('\tmodified:   ', '')
                        print(os.path.abspath(os.getcwd()))
                        print(prepare_result)
            else:
                print("Directory unavailable, Bye!")
                exit(0)

1. Скрипт

        #!/usr/bin/env python3

        import socket
        import time
        
        dict = {'drive.google.com':'', 'mail.google.com':'', 'google.com':''}
        while True:
            for name in dict.keys():
                ip = socket.gethostbyname(name)
                if dict[name]:
                    if dict[name] == ip:
                        print("http://%s - %s"% (name, ip))
                    else:
                        print("[ERROR]http://%s IP mistmatch %s > %s"% (name, dict[name],  ip))
                        dict[name] = ip
                else:
                    print("http://%s - %s" % (name, ip))
                    dict[name] = ip
                time.sleep(1)