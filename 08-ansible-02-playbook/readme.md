# Домашнее задание к занятию "08.02 Работа с Playbook"
Playbook устанавливает Elastic и Kibana на managed хосты.
Так как инвентори написан для docker контейнеров, то become: true закоментировано.
Для корректной работы необходимо положить jdk-{{ java_jdk_version }}_linux-x64_bin.tar.gz в коорень директории.
Инвентори разделен на две группы ubuntu-el - Elastic, ubuntu-ki - Kibana
Vars all:
```
java_jdk_version: 11.0.13
java_oracle_jdk_package: "jdk-{{ java_jdk_version }}_linux-x64_bin.tar.gz"
```
Vars ubuntu-el:
```
elastic_version: "7.17.0"
elastic_home: "/opt/elastic/{{ elastic_version }}"
```
Vars ubuntu-ki:
```
kibana_version: "7.17.0"
kibana_home: "/opt/kibana/{{ kibana_version }}"
elastik_host: "ubuntu-el"
```
tags: elastic, kibana

##Основная часть

### "Запустите ansible-lint site.yml и исправьте ошибки, если они есть."
```
nposk@prm-niuposkr:/mnt/d/netology/08-ansible-02-playbook$ ansible-lint site.yml
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml
WARNING  Listing 11 violation(s) that are fatal
risky-file-permissions: File permissions unset or incorrect
site.yml:9 Task/Handler: Upload .tar.gz file containing binaries from local storage

risky-file-permissions: File permissions unset or incorrect
site.yml:16 Task/Handler: Ensure installation dir exists

risky-file-permissions: File permissions unset or incorrect
site.yml:32 Task/Handler: Export environment variables

risky-file-permissions: File permissions unset or incorrect
site.yml:52 Task/Handler: Create directrory for Elasticsearch

risky-file-permissions: File permissions unset or incorrect
site.yml:67 Task/Handler: Set environment Elastic

risky-file-permissions: File permissions unset or incorrect
site.yml:73 Task/Handler: Set Elastic Config

yaml: missing starting space in comment (comments)
site.yml:85

risky-file-permissions: File permissions unset or incorrect
site.yml:95 Task/Handler: Create directrory for Kibana

risky-file-permissions: File permissions unset or incorrect
site.yml:110 Task/Handler: Set environment kibana

risky-file-permissions: File permissions unset or incorrect
site.yml:116 Task/Handler: Set kibana Config

yaml: no new line character at the end of file (new-line-at-end-of-file)
site.yml:121
```

### "Попробуйте запустить playbook на этом окружении с флагом --check."
```buildoutcfg
ansible-playbook site.yml -i inventory/prod.yml --check

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [ubuntu-el]
ok: [ubuntu-ki]

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [ubuntu-el]
ok: [ubuntu-ki]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
ok: [ubuntu-ki]
ok: [ubuntu-el]

TASK [Ensure installation dir exists] **********************************************************************************
ok: [ubuntu-ki]
ok: [ubuntu-el]

TASK [Extract java in the installation directory] **********************************************************************
skipping: [ubuntu-el]
skipping: [ubuntu-ki]

TASK [Export environment variables] ************************************************************************************
ok: [ubuntu-el]
ok: [ubuntu-ki]

PLAY [Install Elasticsearch] *******************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [ubuntu-el]

TASK [Upload tar.gz Elasticsearch from remote URL] *********************************************************************
changed: [ubuntu-el]

TASK [Create directrory for Elasticsearch] *****************************************************************************
ok: [ubuntu-el]

TASK [Extract Elasticsearch in the installation directory] *************************************************************
skipping: [ubuntu-el]

TASK [Set environment Elastic] *****************************************************************************************
ok: [ubuntu-el]

TASK [Set Elastic Config] **********************************************************************************************
ok: [ubuntu-el]

PLAY [Install Kibana] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [ubuntu-ki]

TASK [Upload tar.gz Kibana from remote URL] ****************************************************************************
changed: [ubuntu-ki]

TASK [Create directrory for Kibana] ************************************************************************************
ok: [ubuntu-ki]

TASK [Extract Kibana in the installation directory] ********************************************************************
skipping: [ubuntu-ki]

TASK [Set environment kibana] ******************************************************************************************
ok: [ubuntu-ki]

TASK [Set kibana Config] ***********************************************************************************************
ok: [ubuntu-ki]

PLAY RECAP *************************************************************************************************************
ubuntu-el                  : ok=10   changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
ubuntu-ki                  : ok=10   changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
```
### "Запустите playbook на prod.yml окружении с флагом --diff"
```buildoutcfg
ansible-playbook site.yml -i inventory/prod.yml --diff
[WARNING]: Invalid characters were found in group names but not replaced, use -vvvv to see details
[WARNING]: Found both group and host with same name: ubuntu-ki
[WARNING]: Found both group and host with same name: ubuntu-el

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [ubuntu-el]
ok: [ubuntu-ki]

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [ubuntu-el]
ok: [ubuntu-ki]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
ok: [ubuntu-el]
ok: [ubuntu-ki]

TASK [Ensure installation dir exists] **********************************************************************************
ok: [ubuntu-ki]
ok: [ubuntu-el]

TASK [Extract java in the installation directory] **********************************************************************
skipping: [ubuntu-el]
skipping: [ubuntu-ki]

TASK [Export environment variables] ************************************************************************************
ok: [ubuntu-el]
ok: [ubuntu-ki]

PLAY [Install Elasticsearch] *******************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [ubuntu-el]

TASK [Upload tar.gz Elasticsearch from remote URL] *********************************************************************
ok: [ubuntu-el]

TASK [Create directrory for Elasticsearch] *****************************************************************************
ok: [ubuntu-el]

TASK [Extract Elasticsearch in the installation directory] *************************************************************
skipping: [ubuntu-el]

TASK [Set environment Elastic] *****************************************************************************************
ok: [ubuntu-el]

TASK [Set Elastic Config] **********************************************************************************************
ok: [ubuntu-el]

PLAY [Install Kibana] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [ubuntu-ki]

TASK [Upload tar.gz Kibana from remote URL] ****************************************************************************
ok: [ubuntu-ki]

TASK [Create directrory for Kibana] ************************************************************************************
ok: [ubuntu-ki]

TASK [Extract Kibana in the installation directory] ********************************************************************
skipping: [ubuntu-ki]

TASK [Set environment kibana] ******************************************************************************************
ok: [ubuntu-ki]

TASK [Set kibana Config] ***********************************************************************************************
ok: [ubuntu-ki]

PLAY RECAP *************************************************************************************************************
ubuntu-el                  : ok=10   changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
ubuntu-ki                  : ok=10   changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

```

