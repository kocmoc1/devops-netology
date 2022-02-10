# Домашнее задание к занятию "08.01 Введение в Ansible"

## 1
group_vars/all/examp.yml
## 2
ansible-playbook site.yml -i inventory/test.yml

## 3
```buildoutcfg
ansible-vault create group_vars/deb/examp.yml
```

## 4 
```buildoutcfg
ansible-vault decrypt group_vars/deb/examp.yml
```

## 5 
ansible localhost -m ansible.builtin.debug -a var="some_fact" -e "group_vars/deb/examp.yml" --ask-vault-pass

## 6
```buildoutcfg
ansible-playbook site.yml -i inventory/prod.yml --ask-vault-pass
```
## 7
winrm

## 8 
```
ansible-doc -t connection ssh
```

## 9
```buildoutcfg
- remote_user
        User name with which to login to the remote server, normally set by the remote_user
        keyword.
```

## 3*
```buildoutcfg
ansible-playbook site.yml -i inventory/prod.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [locahost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ********************************************************************************************************
ok: [locahost] => {
    "msg": "Ubuntu"
}
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [locahost] => {
    "msg": "PaSSw0rd"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [centos7] => {
    "msg": "el default fact"
}

PLAY RECAP *************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
locahost                   : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

## 4*
```buildoutcfg
ansible-playbook site.yml -i inventory/prod.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [locahost]
ok: [ubuntu]
ok: [fedora]
ok: [centos7]

TASK [Print OS] ********************************************************************************************************
ok: [locahost] => {
    "msg": "Ubuntu"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [fedora] => {
    "msg": "Fedora"
}

TASK [Print fact] ******************************************************************************************************
ok: [locahost] => {
    "msg": "PaSSw0rd"
}
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [fedora] => {
    "msg": "fed new fact"
}

PLAY RECAP *************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
fedora                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
locahost                   : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

## 5*
[run_docker.sh](run_docker.sh) 
