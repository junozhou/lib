##########查看集群资源状态
# 查看master组件状态
kubectl get cs

# 查看node状态
kubectl get node

# 查看Apiserver代理的url
kubectl cluster-info

# 查看集群详细信息
kubectl cluster-info dump

# 查看资源的详情
kubectl describe 资源类型 资源名称
## 查看node的详细信息
### 可以查看该node的cpu,内存分配情况
kubectl describe node master

# 查看资源信息
kubectl get 资源类型 资源名称

# 查看资源的详细信息
kubectl get 资源类型 资源名称 -o wide # 查看基本信息,ip,所在node等
kubectl get 资源类型 资源名称 -o yaml # 以yaml格式输出详细信息


##########使用kubectl top命令查看资源消耗

# 查看pod资源消耗
kubectl top po pod名 -n namespace名
[root@master k8syaml]# kubectl top po
NAME                          CPU(cores)   MEMORY(bytes)
tomcatdemo-69b5598f69-4vzn6   2m           211Mi

# 查看node资源消耗
kubectl top node node名 -n namespace名
[root@master k8syaml]# kubectl top node
NAME     CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
master   166m         8%     1869Mi          49%
node1    98m          4%     1477Mi          38%

#########资源占用排序-根据cpu
kubectl top pod -A -l app=flannel --sort-by='cpu'



#############k8s查看日志
# 查看pod日志
kubectl logs po pod名 -n namespace名称
# 获取容器实例的 pod 日志（标准输出）
kubectl logs my-pod --previous
# 流式输出 Pod 的日志（标准输出）
kubectl logs -f po pod名 -n namespace名称
# 获取含 name=myLabel 标签的 Pods 的日志（标准输出）
kubectl logs -l name=myLabel
# 流式输出含 name=myLabel 标签的 Pod 的所有日志（标准输出）
kubectl logs -f -l name=myLabel --all-containers

# 查看deployment日志
kubectl logs deploy deploy名称 -n namespace名称
kubectl logs -f deploy/my-deployment -n namespace名称
# 获取一个Deployment的Pod的日志（多容器例子）
kubectl logs deploy/my-deployment -c my-container
kubectl logs -f deploy/my-deployment -c my-container

# 查看service日志
kubectl logs svc svc名称 -n namespace名称

# 挂接到一个运行的容器中
kubectl attach my-pod -i
# 进入pod的终端内查看日志
kubectl exec -ti pod名称 -- bash
# 输出pod中容器的日志(stdout，pod中有多个容器的情况下使用）
kubectl logs my-pod -c 容器名
kubectl -f logs my-pod -c 容器名
# 获取 Pod 容器的日志（标准输出, 多容器场景）
kubectl logs my-pod -c my-container
# 流式输出 Pod 容器的日志（标准输出, 多容器场景）
kubectl logs -f my-pod -c my-container

##############管理k8s组件日志
# 查看你systemd守护进程管理的组件日志
## kubelet是systemd方式运行的
journalctl -u kubelet

# 查看Pod部署的组件日志
## k8s的其他组件都是pod运行的
kubectl logs kube-proxy-xxx -n kube-system
## 持续查看日志
kubectl logs -f kube-proxy-xxx -n kube-system

# 从OS中查看日志
tail /var/log/messages
# 持续查看OS日志
tail -f /var/log/messages

################kubectl logs查看日志原理
 #kubectl logs (获取容器标准输出的日志) -> apiserver -> kubelet -> docker(接管容器标准输出并写入文件中持久化保存) -> 获取某个容器的日志

# 标准输出在宿主机的路径:
/var/lib/docker/containers/容器id/容器id-json.log

# 想要查看该日志文件
## 先通过pod名称查询容器id
docker ps|grep pod名称

## 进入该容器id的目录
cd /var/lib/docker/containers/容器id/

## 查看该容器id的log
cat 容器id-json.log	# 防止文件过大打不开,可以使用less 容器id-json.log







#————————————————
#版权声明：本文为CSDN博主「识途老码」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/omaidb/article/details/121855074