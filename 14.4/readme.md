# Домашнее задание к занятию "14.4 Сервис-аккаунты"

## Задача 1: Работа с сервис-аккаунтами через утилиту kubectl в установленном minikube

cluster-admin@node1:~/Desktop/14.3$ kubectl config set-context --current --namespace=netology
Context "kubernetes-admin@cluster.local" modified.
cluster-admin@node1:~/Desktop/14.3$ kubectl get configmap
NAME               DATA   AGE
kube-root-ca.crt   1      91s
cluster-admin@node1:~/Desktop/14.3$ kubectl get pod
No resources found in netology namespace.
cluster-admin@node1:~/Desktop/14.3$ kubectl create serviceaccount netology
serviceaccount/netology created
cluster-admin@node1:~/Desktop/14.3$ kubectl get serviceaccounts
NAME       SECRETS   AGE
default    0         2m4s
netology   0         9s
cluster-admin@node1:~/Desktop/14.3$ kubectl get serviceaccount
NAME       SECRETS   AGE
default    0         2m11s
netology   0         16s
cluster-admin@node1:~/Desktop/14.3$ history | grep date
  173  kubectl get configmaps -o json > configmaps-$(date +%Y%m%d).json
  175  kubectl get configmap nginx-config -o yaml > nginx-config-$(date +%Y%m%d).yml
  191  history | grep date
cluster-admin@node1:~/Desktop/14.3$ kubectl get serviceaccount netology -o yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  creationTimestamp: "2022-08-21T14:59:00Z"
  name: netology
  namespace: netology
  resourceVersion: "1369503"
  uid: a65c5d07-c58c-4046-9df7-5f8539442462
cluster-admin@node1:~/Desktop/14.3$ kubectl get serviceaccount default -o json
{
    "apiVersion": "v1",
    "kind": "ServiceAccount",
    "metadata": {
        "creationTimestamp": "2022-08-21T14:57:05Z",
        "name": "default",
        "namespace": "netology",
        "resourceVersion": "1369254",
        "uid": "23fdc627-08bb-4347-af36-96a97201ef85"
    }
}
cluster-admin@node1:~/Desktop/14.3$ kubectl get serviceaccounts -o json > serviceaccounts-$(date +%Y%m%d).json
cluster-admin@node1:~/Desktop/14.3$ ls
configmaps-20220817.json  generator.py   nginx.conf                 serviceaccounts-20220821.json
configmaps.json           myapp-pod.yml  nginx-config-20220817.yml  templates
cluster-admin@node1:~/Desktop/14.3$ kubectl get serviceaccount netology -o yaml > netology-$(date +%Y%m%d).yml
cluster-admin@node1:~/Desktop/14.3$ ls
configmaps-20220817.json  generator.py   netology-20220821.yml  nginx-config-20220817.yml      templates
configmaps.json           myapp-pod.yml  nginx.conf             serviceaccounts-20220821.json
cluster-admin@node1:~/Desktop/14.3$ kubectl delete serviceaccount netology
serviceaccount "netology" deleted
cluster-admin@node1:~/Desktop/14.3$ kubectl apply -f netology-20220821.yml 
serviceaccount/netology created


## Задача 2 (*): Работа с сервис-акаунтами внутри модуля
