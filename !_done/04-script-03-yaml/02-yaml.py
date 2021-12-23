#!/usr/bin/env python3

import socket
import time
import argparse
import os
import json
import yaml
parser = argparse.ArgumentParser()
parser.add_argument("--output", "-w", help="set output format: yml, json")
args = parser.parse_args()
# with open('data.json', 'w') as f:
#     json.dump(data, f)

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

    if args.output == "yml":
        with open('data.yml', 'w') as outfile:
            yaml.dump(dict, outfile)
        print("Saved to data.yml")
    elif args.output == "json":
        with open('data.json', 'w') as f:
            json.dump(dict, f)
        print("Saved to data.json")
    else:
        print("================================================")
        print("Output format didn\'t set!")
    time.sleep(1)


