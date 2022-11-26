1，问题描述
（1）最近发现咋 Kubernetes 集群上有个处于 Terminating 状态的 Pod：
原文:k8s - 解决Terminating状态的Pod删不掉的问题（强行kubectl delete pod）

（2）但通过 kubectl delete pods 命令却死活无法将其删除：
kubectl delete pods httpd-app-6df58645c6-cxgcm

2，解决办法
（1）无论各种方式生成的 pod, 均可以使用如下命令强制删除：
kubectl delete pods <pod> --grace-period=0 --force


（2）因此对于上面的 pod，我们只要执行如下命令即可删除：
kubectl delete pods httpd-app-6df58645c6-cxgcm --grace-period=0 --force