# Домашнее задание к занятию "12.2 Команды для работы с Kubernetes"

1.  
    ``` 
    PS C:\~\12-kubernetes-02-commands> kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.10 --replicas=2
    deployment.apps/hello-minikube created
    PS C:\~\12-kubernetes-02-commands> kubectl.exe get deployment
    NAME             READY   UP-TO-DATE   AVAILABLE   AGE
    hello-minikube   2/2     2            2           18s
    hello-node       1/1     1            1           13d
    PS C:\~\12-kubernetes-02-commands> kubectl.exe get pod
    NAME                              READY   STATUS    RESTARTS        AGE
    hello-minikube-7bfc84c94b-857x5   1/1     Running   0               25s
    hello-minikube-7bfc84c94b-9rs94   1/1     Running   0               25s
    hello-node-6b89d599b9-rqb5f       1/1     Running   1 (4m36s ago)   13d
    ```


2.
    [rbac.yaml](./rbac.yaml)
    ```
    PS C:\Users\User\.kube> kubectl  config set-credentials log-user --token=log-token
    User "log-user" set.
    PS C:\Users\User\.kube> cat .\config
    apiVersion: v1
    clusters:
    - cluster:
        certificate-authority: C:\Users\User\.minikube\ca.crt
        extensions:
        - extension:
            last-update: Tue, 14 Jun 2022 19:54:33 +05
            provider: minikube.sigs.k8s.io
            version: v1.25.2
        name: cluster_info
        server: https://127.0.0.1:63774
    name: minikube
    contexts:
    - context:
        cluster: minikube
        extensions:
        - extension:
            last-update: Tue, 14 Jun 2022 19:54:33 +05
            provider: minikube.sigs.k8s.io
            version: v1.25.2
        name: context_info
        namespace: default
        user: minikube
    name: minikube
    current-context: minikube
    kind: Config
    preferences: {}
    users:
    - name: log-user
    user:
        token: log-token
    - name: minikube
    user:
        client-certificate: C:\Users\User\.minikube\profiles\minikube\client.crt
        client-key: C:\Users\User\.minikube\profiles\minikube\client.key
    PS C:\Users\User\.kube> kubectl.exe apply -f C:\~\12-kubernetes-02-commands\rbac.yaml
    role.rbac.authorization.k8s.io/kube-saas:list-and-logs created
    PS C:\Users\User\.kube> kubectl.exe apply -f C:\~\12-kubernetes-02-commands\rbac.yaml
    role.rbac.authorization.k8s.io/kube-saas:list-and-logs unchanged
    rolebinding.rbac.authorization.k8s.io/read-pods-logs created
    ```

3. 
    ```
    PS C:\Users\User\.kube> kubectl scale --current-replicas=2 --replicas=5 deployment/hello-minikube
    deployment.apps/hello-minikube scaled
    PS C:\Users\User\.kube> kubectl.exe get pod
    NAME                              READY   STATUS    RESTARTS      AGE
    hello-minikube-7bfc84c94b-2b2dz   1/1     Running   0             8s
    hello-minikube-7bfc84c94b-85782   1/1     Running   0             8s
    hello-minikube-7bfc84c94b-857x5   1/1     Running   0             30m
    hello-minikube-7bfc84c94b-9rs94   1/1     Running   0             30m
    hello-minikube-7bfc84c94b-tn74s   1/1     Running   0             8s
    hello-node-6b89d599b9-rqb5f       1/1     Running   1 (34m ago)   13d
    PS C:\Users\User\.kube> 
    ```
