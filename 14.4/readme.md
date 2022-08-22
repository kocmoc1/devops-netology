# Домашнее задание к занятию "14.4 Сервис-аккаунты"

## Задача 1: Работа с сервис-аккаунтами через утилиту kubectl в установленном minikube
Создание и смена namespace
```
cluster-admin@node1:~/Desktop/14.4$ kubectl create namespace netology
cluster-admin@node1:~/Desktop/14.4$ kubectl config set-context --current --namespace=netology
Context "kubernetes-admin@cluster.local" modified.
```
Создание сервис-аккаунта
```
cluster-admin@node1:~/Desktop/14.4$ kubectl create serviceaccount netology
serviceaccount/netology created
```
Просмотр списков сервис-акаунтов
```
cluster-admin@node1:~/Desktop/14.4$ kubectl get serviceaccounts
NAME       SECRETS   AGE
default    0         2m4s
netology   0         9s
cluster-admin@node1:~/Desktop/14.4$ kubectl get serviceaccount
NAME       SECRETS   AGE
default    0         2m11s
netology   0         16s
```
Получение информации в формате YAML/JSON
```
cluster-admin@node1:~/Desktop/14.4$ kubectl get serviceaccount netology -o yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  creationTimestamp: "2022-08-21T14:59:00Z"
  name: netology
  namespace: netology
  resourceVersion: "1369503"
  uid: a65c5d07-c58c-4046-9df7-5f8539442462
  
  
cluster-admin@node1:~/Desktop/14.4$ kubectl get serviceaccount default -o json
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
```

Сохранение в файл JSON/YAML
```
cluster-admin@node1:~/Desktop/14.4$ kubectl get serviceaccounts -o json > serviceaccounts-$(date +%Y%m%d).json
cluster-admin@node1:~/Desktop/14.4$ ls
configmaps-20220817.json  generator.py   nginx.conf                 serviceaccounts-20220821.json
configmaps.json           myapp-pod.yml  nginx-config-20220817.yml  templates


cluster-admin@node1:~/Desktop/14.4$ kubectl get serviceaccount netology -o yaml > netology-$(date +%Y%m%d).yml
cluster-admin@node1:~/Desktop/14.4$ ls
configmaps-20220817.json  generator.py   netology-20220821.yml  nginx-config-20220817.yml      templates
configmaps.json           myapp-pod.yml  nginx.conf             serviceaccounts-20220821.json
```
Удаление сервис-акаунта?
```
cluster-admin@node1:~/Desktop/14.4$ kubectl delete serviceaccount netology
serviceaccount "netology" deleted
```
Загрузка и файла

```
cluster-admin@node1:~/Desktop/14.4$ kubectl apply -f netology-20220821.yml 
serviceaccount/netology created
```

## Задача 2 (*): Работа с сервис-акаунтами внутри модуля

Создаем SA и SECRET:
```
cluster-admin@node1:~/Desktop/14.4$ kubectl create serviceaccount ubuntu-sa

cluster-admin@node1:~/Desktop/14.4$ kubectl apply -f secret-for-sa.yaml 
secret/secret-ubuntu-sa created

cluster-admin@node1:~/Desktop/14.4$ kubectl describe serviceaccount ubuntu-sa
Name:                ubuntu-sa
Namespace:           netology
Labels:              <none>
Annotations:         <none>
Image pull secrets:  <none>
Mountable secrets:   <none>
Tokens:              secret-ubuntu-sa
Events:              <none>
```

Устанавливаем переменные:
```
cluster-admin@node1:~/Desktop/14.4$ ROLENAME=read-exec-pods-netology
cluster-admin@node1:~/Desktop/14.4$ ACCOUNT_NAME=ubuntu-sa
cluster-admin@node1:~/Desktop/14.4$ NAMESPACE=netology
cluster-admin@node1:~/Desktop/14.4$ TOKEN_NAME=secret-ubuntu-sa
cluster-admin@node1:~/Desktop/14.4$ TOKEN=$(kubectl describe secrets $TOKEN_NAME --namespace $NAMESPACE | grep 'token:' | rev | cut -d ' ' -f1 | rev)
cluster-admin@node1:~/Desktop/14.4$ CERTIFICATE_AUTHORITY_DATA=$(kubectl config view --flatten --minify -o jsonpath="{.clusters[0].cluster.certificate-authority-data}")
cluster-admin@node1:~/Desktop/14.4$ SERVER_URL=$(kubectl config view --flatten --minify -o jsonpath="{.clusters[0].cluster.server}")
cluster-admin@node1:~/Desktop/14.4$ CLUSTER_NAME=$(kubectl config view --flatten --minify -o jsonpath="{.clusters[0].name}")
```

Создание ConfigMap:
```
cluster-admin@node1:~/Desktop/14.4$ cat <<EOF > $CLUSTER_NAME-$ACCOUNT_NAME-kube.conf
> apiVersion: v1
> kind: Config
> users:
> - name: $ACCOUNT_NAME
>   user:
>     token: $TOKEN
> clusters:
> - cluster:
>     certificate-authority-data: $CERTIFICATE_AUTHORITY_DATA    
>     server: $SERVER_URL
>   name: $CLUSTER_NAME
> contexts:
> - context:
>     cluster: $CLUSTER_NAME
>     user: $ACCOUNT_NAME
>   name: $CLUSTER_NAME-$ACCOUNT_NAME-context
> current-context: $CLUSTER_NAME-$ACCOUNT_NAME-context
> EOF
```

Попытка подключения без Role:
```
cluster-admin@node1:~/Desktop/14.4$ kubectl --kubeconfig=$CLUSTER_NAME-$ACCOUNT_NAME-kube.conf get po -n $NAMESPACE
Error from server (Forbidden): pods is forbidden: User "system:serviceaccount:netology:ubuntu-sa" cannot list resource "pods" in API group "" in the namespace "netology"
```

Создание ROLE
```
cluster-admin@node1:~/Desktop/14.4$ cat <<EOF > $ROLENAME-role.yaml ; kubectl apply -f $ROLENAME-role.yaml -n $NAMESPACE
> apiVersion: rbac.authorization.k8s.io/v1
> kind: Role
> metadata:
>   namespace: $NAMESPACE
>   name: $ROLENAME
> rules:
> - apiGroups: [""]
>   resources: ["pods", "pods/log", "services", "persistentvolumeclaims"]
>   verbs: ["get", "list", "watch", "describe"]
> - apiGroups: [""]
>   resources: ["pods/exec"]
>   verbs: ["create"]
> - apiGroups: ["extensions"]
>   resources: ["ingresses"]
>   verbs: ["get", "list", "watch"]
> EOF
role.rbac.authorization.k8s.io/read-exec-pods-netology created
```

Создание RoleBinding:
```
cluster-admin@node1:~/Desktop/14.4$ cat <<EOF > $ROLENAME-rolebinding.yaml ; kubectl apply -f $ROLENAME-rolebinding.yaml -n $NAMESPACE
> apiVersion: rbac.authorization.k8s.io/v1
> kind: RoleBinding
> metadata:
>   name: $ACCOUNT_NAME-$ROLENAME-rolebinding
>   namespace: $NAMESPACE
> subjects:
> - kind: User
>   name: system:serviceaccount:$NAMESPACE:$ACCOUNT_NAME # Name is case sensitive
>   apiGroup: rbac.authorization.k8s.io
> roleRef:
>   kind: Role #this must be Role or ClusterRole
>   name: $ROLENAME # this must match the name of the Role or ClusterRole you wish to bind to
>   apiGroup: rbac.authorization.k8s.io
> EOF
rolebinding.rbac.authorization.k8s.io/ubuntu-sa-read-exec-pods-netology-rolebinding created
```

Запуск пода, проверка соединения с кластером:
```
cluster-admin@node1:~/Desktop/14.4$ kubectl run -i --tty ubuntu --image=ubuntu --restart=Never -- sh 
If you don't see a command prompt, try pressing enter.
[root@ubuntu /]# env | grep KUBE
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_SERVICE_PORT=443
KUBERNETES_PORT_443_TCP=tcp://10.233.0.1:443
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_PORT_443_TCP_ADDR=10.233.0.1
KUBERNETES_SERVICE_HOST=10.233.0.1
KUBERNETES_PORT=tcp://10.233.0.1:443
KUBERNETES_PORT_443_TCP_PORT=443
[root@ubuntu /]# K8S=https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT
[root@ubuntu /]# SADIR=/var/run/secrets/kubernetes.io/serviceaccount
[root@ubuntu /]# TOKEN=$(cat $SADIR/token)
[root@ubuntu /]# CACERT=$SADIR/ca.crt
[root@ubuntu /]# NAMESPACE=$(cat $SADIR/namespace)
[root@ubuntu /]# curl -H "Authorization: Bearer $TOKEN" --cacert $CACERT $K8S/api/v1/
```

Результат запроса к кластеру
```
{
  "kind": "APIResourceList",
  "groupVersion": "v1",
  "resources": [
    {
      "name": "bindings",
      "singularName": "",
      "namespaced": true,
      "kind": "Binding",
      "verbs": [
        "create"
      ]
    },
    {
      "name": "componentstatuses",
      "singularName": "",
      "namespaced": false,
      "kind": "ComponentStatus",
      "verbs": [
        "get",
        "list"
      ],
      "shortNames": [
        "cs"
      ]
    },
    {
      "name": "configmaps",
      "singularName": "",
      "namespaced": true,
      "kind": "ConfigMap",
      "verbs": [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ],
      "shortNames": [
        "cm"
      ],
      "storageVersionHash": "qFsyl6wFWjQ="
    },
    {
      "name": "endpoints",
      "singularName": "",
      "namespaced": true,
      "kind": "Endpoints",
      "verbs": [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ],
      "shortNames": [
        "ep"
      ],
      "storageVersionHash": "fWeeMqaN/OA="
    },
    {
      "name": "events",
      "singularName": "",
      "namespaced": true,
      "kind": "Event",
      "verbs": [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ],
      "shortNames": [
        "ev"
      ],
      "storageVersionHash": "r2yiGXH7wu8="
    },
    {
      "name": "limitranges",
      "singularName": "",
      "namespaced": true,
      "kind": "LimitRange",
      "verbs": [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ],
      "shortNames": [
        "limits"
      ],
      "storageVersionHash": "EBKMFVe6cwo="
    },
    {
      "name": "namespaces",
      "singularName": "",
      "namespaced": false,
      "kind": "Namespace",
      "verbs": [
        "create",
        "delete",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ],
      "shortNames": [
        "ns"
      ],
      "storageVersionHash": "Q3oi5N2YM8M="
    },
    {
      "name": "namespaces/finalize",
      "singularName": "",
      "namespaced": false,
      "kind": "Namespace",
      "verbs": [
        "update"
      ]
    },
    {
      "name": "namespaces/status",
      "singularName": "",
      "namespaced": false,
      "kind": "Namespace",
      "verbs": [
        "get",
        "patch",
        "update"
      ]
    },
    {
      "name": "nodes",
      "singularName": "",
      "namespaced": false,
      "kind": "Node",
      "verbs": [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ],
      "shortNames": [
        "no"
      ],
      "storageVersionHash": "XwShjMxG9Fs="
    },
    {
      "name": "nodes/proxy",
      "singularName": "",
      "namespaced": false,
      "kind": "NodeProxyOptions",
      "verbs": [
        "create",
        "delete",
        "get",
        "patch",
        "update"
      ]
    },
    {
      "name": "nodes/status",
      "singularName": "",
      "namespaced": false,
      "kind": "Node",
      "verbs": [
        "get",
        "patch",
        "update"
      ]
    },
    {
      "name": "persistentvolumeclaims",
      "singularName": "",
      "namespaced": true,
      "kind": "PersistentVolumeClaim",
      "verbs": [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ],
      "shortNames": [
        "pvc"
      ],
      "storageVersionHash": "QWTyNDq0dC4="
    },
    {
      "name": "persistentvolumeclaims/status",
      "singularName": "",
      "namespaced": true,
      "kind": "PersistentVolumeClaim",
      "verbs": [
        "get",
        "patch",
        "update"
      ]
    },
    {
      "name": "persistentvolumes",
      "singularName": "",
      "namespaced": false,
      "kind": "PersistentVolume",
      "verbs": [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ],
      "shortNames": [
        "pv"
      ],
      "storageVersionHash": "HN/zwEC+JgM="
    },
    {
      "name": "persistentvolumes/status",
      "singularName": "",
      "namespaced": false,
      "kind": "PersistentVolume",
      "verbs": [
        "get",
        "patch",
        "update"
      ]
    },
    {
      "name": "pods",
      "singularName": "",
      "namespaced": true,
      "kind": "Pod",
      "verbs": [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ],
      "shortNames": [
        "po"
      ],
      "categories": [
        "all"
      ],
      "storageVersionHash": "xPOwRZ+Yhw8="
    },
    {
      "name": "pods/attach",
      "singularName": "",
      "namespaced": true,
      "kind": "PodAttachOptions",
      "verbs": [
        "create",
        "get"
      ]
    },
    {
      "name": "pods/binding",
      "singularName": "",
      "namespaced": true,
      "kind": "Binding",
      "verbs": [
        "create"
      ]
    },
    {
      "name": "pods/ephemeralcontainers",
      "singularName": "",
      "namespaced": true,
      "kind": "Pod",
      "verbs": [
        "get",
        "patch",
        "update"
      ]
    },
    {
      "name": "pods/eviction",
      "singularName": "",
      "namespaced": true,
      "group": "policy",
      "version": "v1",
      "kind": "Eviction",
      "verbs": [
        "create"
      ]
    },
    {
      "name": "pods/exec",
      "singularName": "",
      "namespaced": true,
      "kind": "PodExecOptions",
      "verbs": [
        "create",
        "get"
      ]
    },
    {
      "name": "pods/log",
      "singularName": "",
      "namespaced": true,
      "kind": "Pod",
      "verbs": [
        "get"
      ]
    },
    {
      "name": "pods/portforward",
      "singularName": "",
      "namespaced": true,
      "kind": "PodPortForwardOptions",
      "verbs": [
        "create",
        "get"
      ]
    },
    {
      "name": "pods/proxy",
      "singularName": "",
      "namespaced": true,
      "kind": "PodProxyOptions",
      "verbs": [
        "create",
        "delete",
        "get",
        "patch",
        "update"
      ]
    },
    {
      "name": "pods/status",
      "singularName": "",
      "namespaced": true,
      "kind": "Pod",
      "verbs": [
        "get",
        "patch",
        "update"
      ]
    },
    {
      "name": "podtemplates",
      "singularName": "",
      "namespaced": true,
      "kind": "PodTemplate",
      "verbs": [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ],
      "storageVersionHash": "LIXB2x4IFpk="
    },
    {
      "name": "replicationcontrollers",
      "singularName": "",
      "namespaced": true,
      "kind": "ReplicationController",
      "verbs": [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ],
      "shortNames": [
        "rc"
      ],
      "categories": [
        "all"
      ],
      "storageVersionHash": "Jond2If31h0="
    },
    {
      "name": "replicationcontrollers/scale",
      "singularName": "",
      "namespaced": true,
      "group": "autoscaling",
      "version": "v1",
      "kind": "Scale",
      "verbs": [
        "get",
        "patch",
        "update"
      ]
    },
    {
      "name": "replicationcontrollers/status",
      "singularName": "",
      "namespaced": true,
      "kind": "ReplicationController",
      "verbs": [
        "get",
        "patch",
        "update"
      ]
    },
    {
      "name": "resourcequotas",
      "singularName": "",
      "namespaced": true,
      "kind": "ResourceQuota",
      "verbs": [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ],
      "shortNames": [
        "quota"
      ],
      "storageVersionHash": "8uhSgffRX6w="
    },
    {
      "name": "resourcequotas/status",
      "singularName": "",
      "namespaced": true,
      "kind": "ResourceQuota",
      "verbs": [
        "get",
        "patch",
        "update"
      ]
    },
    {
      "name": "secrets",
      "singularName": "",
      "namespaced": true,
      "kind": "Secret",
      "verbs": [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ],
      "storageVersionHash": "S6u1pOWzb84="
    },
    {
      "name": "serviceaccounts",
      "singularName": "",
      "namespaced": true,
      "kind": "ServiceAccount",
      "verbs": [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ],
      "shortNames": [
        "sa"
      ],
      "storageVersionHash": "pbx9ZvyFpBE="
    },
    {
      "name": "serviceaccounts/token",
      "singularName": "",
      "namespaced": true,
      "group": "authentication.k8s.io",
      "version": "v1",
      "kind": "TokenRequest",
      "verbs": [
        "create"
      ]
    },
    {
      "name": "services",
      "singularName": "",
      "namespaced": true,
      "kind": "Service",
      "verbs": [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ],
      "shortNames": [
        "svc"
      ],
      "categories": [
        "all"
      ],
      "storageVersionHash": "0/CO1lhkEBI="
    },
    {
      "name": "services/proxy",
      "singularName": "",
      "namespaced": true,
      "kind": "ServiceProxyOptions",
      "verbs": [
        "create",
        "delete",
        "get",
        "patch",
        "update"
      ]
    },
    {
      "name": "services/status",
      "singularName": "",
      "namespaced": true,
      "kind": "Service",
      "verbs": [
        "get",
        "patch",
        "update"
      ]
    }
  ]
```
