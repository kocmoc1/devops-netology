# Домашнее задание к занятию "13.2 разделы и монтирование"

Если честно - не понял чем отличается задание 1 от задания 2.
[stage-prod.yaml](./stage-prod.yaml)


```
user@node1:~/Desktop$ kubectl exec -i -t 13-kube-01-7459b64cc9-2lc6n --container frontend -- /bin/bash
root@13-kube-01-7459b64cc9-2lc6n:/app# cd /static/
root@13-kube-01-7459b64cc9-2lc6n:/static# ls
root@13-kube-01-7459b64cc9-2lc6n:/static# echo "Text from frontend!" >> test.txt
root@13-kube-01-7459b64cc9-2lc6n:/static# exit
exit
user@node1:~/Desktop$ kubectl exec -i -t 13-kube-01-7459b64cc9-2lc6n --container backend -- /bin/bash
root@13-kube-01-7459b64cc9-2lc6n:/app# cat /static/test.txt 
Text from frontend!
root@13-kube-01-7459b64cc9-2lc6n:/app# echo "Text from backend!" >> /static/test.txt 
root@13-kube-01-7459b64cc9-2lc6n:/app# 
```
