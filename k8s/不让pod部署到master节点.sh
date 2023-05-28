

kubectl describe pod/qa-env-script-2721-8467c68975-mqft9 -n namspace
使用rancher运行镜像时报以下错误



0/1 nodes are available: 1 node(s) had taints that the pod didn't tolerate.




是因为默认kubernetes默认不让pod部署到master节点，但是我在测试环境只有一个节点也是master节点，需要允许master节点部署pod

kubectl taint nodes --all node-role.kubernetes.io/master-



如果想要禁止，则执行以下命令

kubectl taint nodes k8s node-role.kubernetes.io/master=true:NoSchedule

