nposk@node1:~/Desktop$ kubectl apply -f 14-2/vault-pod.yaml


nposk@node1:~/Desktop$ kubectl describe pod 14.2-netology-vault
Name:         14.2-netology-vault
Namespace:    default
Priority:     0
Node:         node1/192.168.20.112
Start Time:   Wed, 10 Aug 2022 19:26:35 +0500
Labels:       <none>
Annotations:  cni.projectcalico.org/containerID: dcfd1c9dc637a58e6842612a5170791abeb6343af5ea81c768b026371b2f518c
              cni.projectcalico.org/podIP: 10.233.90.26/32
              cni.projectcalico.org/podIPs: 10.233.90.26/32
Status:       Running
IP:           10.233.90.26
IPs:
  IP:  10.233.90.26
Containers:
  vault:
    Container ID:   containerd://243b4cf461f8f3e521a69101a399953e440b49a1a0e8fdf4a56caafa99e40112
    Image:          vault
    Image ID:       docker.io/library/vault@sha256:a21876d5fe555d7369084ec3216a38b927da8f9c845d383586c7f54236413ad2
    Port:           8200/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Wed, 10 Aug 2022 19:26:54 +0500
    Ready:          True
    Restart Count:  0
    Environment:
      VAULT_DEV_ROOT_TOKEN_ID:   aiphohTaa0eeHei
      VAULT_DEV_LISTEN_ADDRESS:  0.0.0.0:8200
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-w8jwf (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-w8jwf:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  48s   default-scheduler  Successfully assigned default/14.2-netology-vault to node1
  Normal  Pulling    44s   kubelet            Pulling image "vault"
  Normal  Pulled     29s   kubelet            Successfully pulled image "vault" in 14.606055727s
  Normal  Created    29s   kubelet            Created container vault
  Normal  Started    29s   kubelet            Started container vault
  
  
  nposk@node1:~/Desktop$ kubectl get pod 14.2-netology-vault -o json | jq -c '.status.podIPs'
[{"ip":"10.233.90.26"}]



python


>>> client = hvac.Client(
...     url='http://10.233.90.26:8200',
...     token='aiphohTaa0eeHei'
... )
>>> client.is_authenticated()
True
>>> client.secrets.kv.v2.create_or_update_secret(
...     path='hvac',
...     secret=dict(netology='Big secret!!!'),
... )
{'request_id': 'd56272aa-f21e-8257-9ba6-0582b6f320af', 'lease_id': '', 'renewable': False, 'lease_duration': 0, 'data': {'created_time': '2022-08-10T14:43:19.884204554Z', 'custom_metadata': None, 'deletion_time': '', 'destroyed': False, 'version': 1}, 'wrap_info': None, 'warnings': None, 'auth': None}
>>> client.secrets.kv.v2.read_secret_version(
...     path='hvac',
... )
{'request_id': '305ce4e6-32c0-7a22-f7f4-43b37ad68499', 'lease_id': '', 'renewable': False, 'lease_duration': 0, 'data': {'data': {'netology': 'Big secret!!!'}, 'metadata': {'created_time': '2022-08-10T14:43:19.884204554Z', 'custom_metadata': None, 'deletion_time': '', 'destroyed': False, 'version': 1}}, 'wrap_info': None, 'warnings': None, 'auth': None}
>>> 
