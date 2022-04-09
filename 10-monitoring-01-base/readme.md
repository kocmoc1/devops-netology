# Домашнее задание к занятию "10.01. Зачем и что нужно мониторить"  
1. Набор метрик: нагрузка СPU, нагрузка RAM, нагрузка на диски, остаток места на диске, показатель inode, и для просмотра нагрузки на http количество запросов в секунду/минуту, uptime
1. Добавить следующие мертики:  Requests per second, Average response time, Uptime - совсбственно относительно этих метрик и можно высчитать достпупность сервера
1. Самое просто бесплатное и быстро разворачиваоемое - стек ELK.
1. Не учитывается 3xx коды.


script.py

```

import json
from os import path
from datetime import datetime

class _data:
    def __init__(self, MemTotal, MemFree, MemAvailable, CPUNow):
        self.MemTotal = MemTotal
        self.MemFree = MemFree
        self.MemAvailable = MemAvailable
        self.CPUNow = CPUNow


filename = '/var/log/'+datetime.now().strftime("%y-%m-%d")+'-awesome-monitoring.log'
listObj = []
 
# Check if file exists
if path.isfile(filename):
# Read JSON file
    with open(filename) as fp:
        listObj = json.load(fp)
    
    # Verify existing list
    #print(listObj)

#print(type(listObj))
z.update(y)
meminfo = dict((i.split()[0].rstrip(':'),int(i.split()[1])) for i in open('/proc/meminfo').readlines())
cpu = open("/proc/loadavg").readline().split(" ")[:3]
listObj.append(json.dumps(_data(meminfo['MemTotal'], meminfo['MemFree'], meminfo['MemAvailable'], cpu[0]).__dict__))
 
# Verify updated list
print(listObj)
 
with open(filename, 'w') as json_file:
    json.dump(listObj, json_file, 
                        indent=4,  
                        separators=(',',': '))
 
print('Successfully appended to the JSON file')

```

crontab
```
1 * * * * python3 script.py
```

22-04-04-awesome-monitoring.log

```
['{"MemTotal": 13042996, "MemFree": 10380776, "MemAvailable": 12515760, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10380776, "MemAvailable": 12515772, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10380516, "MemAvailable": 12515520, "CPUNow": "0.00"}',
'{"MemTotal": 13042996, "MemFree": 10380280, "MemAvailable": 12515284, "CPUNow": "0.00"}',
'{"MemTotal": 13042996, "MemFree": 10380524, "MemAvailable": 12515528, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10380776, "MemAvailable": 12515780, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10379776, "MemAvailable": 12514780, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10380272, "MemAvailable": 12515276, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10379760, "MemAvailable": 12514764, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10380012, "MemAvailable": 12515016, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10379768, "MemAvailable": 12514772, "CPUNow": "0.00"}',
'{"MemTotal": 13042996, "MemFree": 10380272, "MemAvailable": 12515276, "CPUNow": "0.00"}',
'{"MemTotal": 13042996, "MemFree": 10380280, "MemAvailable": 12515284, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10380524, "MemAvailable": 12515528, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10380524, "MemAvailable": 12515528, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10380516, "MemAvailable": 12515520, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10380516, "MemAvailable": 12515520, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10381028, "MemAvailable": 12516032, "CPUNow": "0.00"}',
'{"MemTotal": 13042996, "MemFree": 10381020, "MemAvailable": 12516024, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10381028, "MemAvailable": 12516032, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10380776, "MemAvailable": 12515788, "CPUNow": "0.00"}', 
'{"MemTotal": 13042996, "MemFree": 10380264, "MemAvailable": 12515276, "CPUNow": "0.00"}']

```
