# Домашнее задание к занятию "12.5 Сетевые решения CNI"

1. Calico устанавливается в кластере по-умолчанию.

    Доступ извне 
    ```
    kind: NetworkPolicy
    apiVersion: networking.k8s.io/v1
    metadata:
      name: hello-world
      namespace: hello-world
    spec:
      podSelector:
        matchLabels:
          app: hello-world
      ingress:
        - from:
          - podSelector:
              matchLabels:
                app: front-end
        ports:
        - protocol: TCP
          port: 80
    ```

1. 
    ```
    user@user-VirtualBox:~/Desktop$ kubectl calico get node --allow-version-mismatch
    NAME    
    node1   
    node2   

    user@user-VirtualBox:~/Desktop$ kubectl calico get ipPool --allow-version-mismatch
    NAME           CIDR             SELECTOR   
    default-pool   10.233.64.0/18   all()      

    user@user-VirtualBox:~/Desktop$ kubectl calico get profile --allow-version-mismatch
    NAME                                                 
    projectcalico-default-allow                          
    kns.default                                          
    kns.kube-node-lease                                  
    kns.kube-public                                      
    kns.kube-system                                      
    ksa.default.default                                  
    ksa.kube-node-lease.default                          
    ksa.kube-public.default                              
    ksa.kube-system.attachdetach-controller              
    ksa.kube-system.bootstrap-signer                     
    ksa.kube-system.calico-node                          
    ksa.kube-system.certificate-controller               
    ksa.kube-system.clusterrole-aggregation-controller   
    ksa.kube-system.coredns                              
    ksa.kube-system.cronjob-controller                   
    ksa.kube-system.daemon-set-controller                
    ksa.kube-system.default                              
    ksa.kube-system.deployment-controller                
    ksa.kube-system.disruption-controller                
    ksa.kube-system.dns-autoscaler                       
    ksa.kube-system.endpoint-controller                  
    ksa.kube-system.endpointslice-controller             
    ksa.kube-system.endpointslicemirroring-controller    
    ksa.kube-system.ephemeral-volume-controller          
    ksa.kube-system.expand-controller                    
    ksa.kube-system.generic-garbage-collector            
    ksa.kube-system.horizontal-pod-autoscaler            
    ksa.kube-system.job-controller                       
    ksa.kube-system.kube-proxy                           
    ksa.kube-system.namespace-controller                 
    ksa.kube-system.node-controller                      
    ksa.kube-system.nodelocaldns                         
    ksa.kube-system.persistent-volume-binder             
    ksa.kube-system.pod-garbage-collector                
    ksa.kube-system.pv-protection-controller             
    ksa.kube-system.pvc-protection-controller            
    ksa.kube-system.replicaset-controller                
    ksa.kube-system.replication-controller               
    ksa.kube-system.resourcequota-controller             
    ksa.kube-system.root-ca-cert-publisher               
    ksa.kube-system.service-account-controller           
    ksa.kube-system.service-controller                   
    ksa.kube-system.statefulset-controller               
    ksa.kube-system.token-cleaner                        
    ksa.kube-system.ttl-after-finished-controller        
    ksa.kube-system.ttl-controller
    ```
