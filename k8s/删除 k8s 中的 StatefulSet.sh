可以像删除 Kubernetes 中的其他资源一样删除 StatefulSet，使用 kubectl delete 命令，可以通过文件或者名字指定来删除 StatefulSet。

通过文件

1
kubectl delete -f <file.yaml>
通过名称

1
kubectl delete statefulsets <statefulset-name>