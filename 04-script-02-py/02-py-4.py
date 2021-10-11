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