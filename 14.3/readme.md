# Домашнее задание к занятию "14.3 Карты конфигураций"
1. 
Создание карту конфигураций
```
cluster-admin@node1:~/Desktop/14.3$ kubectl create configmap nginx-config --from-file=nginx.conf
configmap/nginx-config created
```

```
cluster-admin@node1:~/Desktop/14.3$ kubectl create configmap domain --from-literal=name=netology.ru
configmap/domain created
```
Список карт конфигураций
````
cluster-admin@node1:~/Desktop/14.3$ kubectl get configmaps
NAME               DATA   AGE
domain             1      9s
kube-root-ca.crt   1      54d
nginx-config       1      15s
```

```
cluster-admin@node1:~/Desktop/14.3$ kubectl get configmap
NAME               DATA   AGE
domain             1      17s
kube-root-ca.crt   1      54d
nginx-config       1      23s
```

Просмотр карт конфигураций
```
cluster-admin@node1:~/Desktop/14.3$ kubectl get configmap nginx-config
NAME           DATA   AGE
nginx-config   1      35s
```

```
cluster-admin@node1:~/Desktop/14.3$ kubectl describe configmap domain
Name:         domain
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
name:
----
netology.ru

BinaryData
====

Events:  <none>
cluster-admin@node1:~/Desktop/14.3$ kubectl get configmap nginx-config -o yaml
apiVersion: v1
data:
  nginx.conf: |
    server {
        listen 80;
        server_name  netology.ru www.netology.ru;
        access_log  /var/log/nginx/domains/netology.ru-access.log  main;
        error_log   /var/log/nginx/domains/netology.ru-error.log info;
        location / {
            include proxy_params;
            proxy_pass http://10.10.10.10:8080/;
        }
    }
kind: ConfigMap
metadata:
  creationTimestamp: "2022-08-17T14:31:11Z"
  name: nginx-config
  namespace: default
  resourceVersion: "1038973"
  uid: 87b93131-9595-47f8-8c6f-b1947f960245
cluster-admin@node1:~/Desktop/14.3$ kubectl get configmap domain -o json
{
    "apiVersion": "v1",
    "data": {
        "name": "netology.ru"
    },
    "kind": "ConfigMap",
    "metadata": {
        "creationTimestamp": "2022-08-17T14:31:17Z",
        "name": "domain",
        "namespace": "default",
        "resourceVersion": "1038987",
        "uid": "701e0d95-157b-4e73-8867-eecde22fb7a7"
    }
}
```
Экспорт в json
```
cluster-admin@node1:~/Desktop/14.3$ kubectl get configmaps -o json > configmaps-$(date +%Y%m%d).json
cluster-admin@node1:~/Desktop/14.3$ ls
configmaps-20220817.json  generator.py   nginx.conf
configmaps.json           myapp-pod.yml  templates
```

Экспорт в yml
```
cluster-admin@node1:~/Desktop/14.3$ kubectl get configmap nginx-config -o yaml > nginx-config-$(date +%Y%m%d).yml
cluster-admin@node1:~/Desktop/14.3$ ls
configmaps-20220817.json  generator.py   nginx.conf                 templates
configmaps.json           myapp-pod.yml  nginx-config-20220817.yml
```
Удаление карт конфигураций
```
cluster-admin@node1:~/Desktop/14.3$ kubectl delete configmap nginx-config
configmap "nginx-config" deleted
```
Загрузка карт конфигураций
```
cluster-admin@node1:~/Desktop/14.3$ kubectl apply -f nginx-config-20220817.yml
configmap/nginx-config created
cluster-admin@node1:~/Desktop/14.3$ kubectl get configmap
NAME               DATA   AGE
domain             1      6m20s
kube-root-ca.crt   1      54d
nginx-config       1      8s
```
