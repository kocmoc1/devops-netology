# Домашнее задание к занятию "08.03 Использование Yandex Cloud"
Playbook устанавливает Elastic и Kibana, также на эти же хосты устанавливается FileBeat.

Инвентори разделен на две группы elasticsearch - Elastic,  kibana - Kibana, filebeat -  него входят хосты elasticsearch, kibana
Vars all:
```
---
elk_stack_version: "7.14.0"
```
Vars elasticsearch:
```
elastic_version: "{{ elk_stack_version }}"
```
Vars kibana:
```
kibana_version: "{{ elk_stack_version }}" 
```
Vars filebeat:
```
filebeat_version: "{{ elk_stack_version }}"
```
Тегов нет.

