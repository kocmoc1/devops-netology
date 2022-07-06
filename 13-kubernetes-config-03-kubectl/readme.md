# Домашнее задание к занятию "13.3 работа с kubectl"
1.   
    Frontend
    ```
    user@node1:~/Desktop$ kubectl get pod
    NAME             READY   STATUS    RESTARTS   AGE
    13-kube-01       2/2     Running   0          104s
    postgres-sts-0   1/1     Running   0          4h31m

    user@node1:~/Desktop$ kubectl port-forward pods/13-kube-01 :80
    Forwarding from 127.0.0.1:34803 -> 80
    Forwarding from [::1]:34803 -> 80
    Handling connection for 34803

    user@node1:~$ curl 127.0.0.1:34803
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <title>Список</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="/build/main.css" rel="stylesheet">
    </head>
    <body>
        <main class="b-page">
            <h1 class="b-page__title">Список</h1>
            <div class="b-page__content b-items js-list"></div>
        </main>
        <script src="/build/main.js"></script>
    </body>
    </html>
    ```
    Backend

    ```
    user@node1:~/Desktop$ kubectl logs 13-kube-01 -c backend
    INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
    INFO:     Started reloader process [7] using statreload
    INFO:     Started server process [9]
    INFO:     Waiting for application startup.
    INFO:     Application startup complete.
    user@node1:~/Desktop$ kubectl port-forward pods/13-kube-01 :9000
    Forwarding from 127.0.0.1:38029 -> 9000
    Forwarding from [::1]:38029 -> 9000
    Handling connection for 38029


    user@node1:~/Desktop$ curl 127.0.0.1:38029
    {"detail":"Not Found"}
    ```

    postgres

    ```
    user@node1:~/Desktop$ kubectl exec --stdin --tty postgres-sts-0 -- /bin/bash
    bash-5.1# ps 
    PID   USER     TIME  COMMAND
    1 postgres  0:00 postgres
    22 postgres  0:00 postgres: checkpointer 
    23 postgres  0:00 postgres: background writer 
    24 postgres  0:00 postgres: walwriter 
    25 postgres  0:00 postgres: autovacuum launcher 
    26 postgres  0:00 postgres: stats collector 
    27 postgres  0:00 postgres: logical replication launcher 
    28 postgres  0:00 postgres: postgres news 10.233.90.13(36998) idle
    29 postgres  0:00 postgres: postgres news 10.233.90.13(37000) idle
    30 postgres  0:00 postgres: postgres news 10.233.90.13(37002) idle
    31 postgres  0:00 postgres: postgres news 10.233.90.13(37004) idle
    32 postgres  0:00 postgres: postgres news 10.233.90.13(37006) idle
    33 postgres  0:00 postgres: postgres news 10.233.90.13(37008) idle
    34 postgres  0:00 postgres: postgres news 10.233.90.13(37010) idle
    35 postgres  0:00 postgres: postgres news 10.233.90.13(37012) idle
    36 postgres  0:00 postgres: postgres news 10.233.90.13(37014) idle
    37 postgres  0:00 postgres: postgres news 10.233.90.13(37016) idle
    38 postgres  0:00 postgres: postgres news 10.233.90.13(37018) idle
    42 root      0:00 /bin/bash

    ```

1.  
    ```
    user@node1:~/Desktop$ kubectl get pod
    NAME                         READY   STATUS    RESTARTS   AGE
    13-kube-01-946944d77-pmmfp   2/2     Running   0          4s
    postgres-sts-0               1/1     Running   0          5h55m
    user@node1:~/Desktop$ kubectl scale --replicas=2 deployment/13-kube-01 
    deployment.apps/13-kube-01 scaled
    user@node1:~/Desktop$ kubectl get pods -o wide
    NAME                         READY   STATUS         RESTARTS   AGE     IP             NODE     NOMINATED NODE   READINESS GATES
    13-kube-01-946944d77-clrk9   2/2     Running        0          5s      10.233.90.15   node1    <none>           <none>
    13-kube-01-946944d77-pmmfp   2/2     Running        0          3m23s   10.233.90.14   node1    <none>   
    user@node1:~/Desktop$kubectl scale --replicas=1 deployment/13-kube-01 
    deployment.apps/13-kube-01 scaled
    user@node1:~/Desktop$ kubectl get pods -o wide
    NAME                         READY   STATUS        RESTARTS   AGE     IP             NODE     NOMINATED NODE   READINESS GATES
    13-kube-01-946944d77-clrk9   2/2     Terminating   0          26s     10.233.90.15   node1    <none>           <none>
    13-kube-01-946944d77-pmmfp   2/2     Running       0          3m44s   10.233.90.14   node1    <none>   
    ```
