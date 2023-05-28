https://www.jb51.net/article/253791.htm
一、概念
1.1.无状态和有状态的区别

主要从网络和存储来对比

无状态不考虑存储和网络，可以任意漂移，每个副本是一样的，如Nginx

有状态应用需要考虑存储和网络，每个副本是不对等的，具有唯一的ID，如etcd、mysql

1.2.StatefulSet的特点

专为部署有状态服务而生

解决Pod独立生命周期，保持Pod启动顺序和唯一性

应用场景：分布式应用、数据库集群

稳定，唯一的网络标识符，持久存储
有序，优雅的部署和扩展、删除、终止
有序，滚动更新

1.3.Headless Service

也是一种Service，但不需要Cluster IP，需要设置clusterIP: None

1.4.serviceName

告诉StatefulSet要使用serviceName指定的headless service来保证Pod的身份

1.5.稳定的存储

存储卷使用volumeClaimTemplates创建，称为卷申请模板；当创建一个PV时，同样会为每个Pod分配并且创建一个编号PVC


二、实例
拿Nginx测试，主要演示yaml的写法，实际应用中需用有状态服务
2.1.statefulset.yaml

apiVersion: apps/v1
kind: StatefulSet
metadata:
  labels:
    app: web
  name: web
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  serviceName: "headless-web"
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - image: nginx
        imagePullPolicy: IfNotPresent
        name: web
        ports:
        - containerPort: 8080
        volumeMounts:
          - name: www
            mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: www
    spec:
      storageClassName: "managed-nfs-storage"
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 1Gi
设置了3个副本，从0开始标号，创建3个副本

在这里插入图片描述

自动创建PV和PVC

在这里插入图片描述

在这里插入图片描述

2.2.headless-svc.yaml

apiVersion: v1
kind: Service
metadata:
  name: headless-web
spec:
  clusterIP: None
  ports:
  - port: 80
    protocol: TCP
  selector:
    app: web
CLUSTER-IP为None

#NAME  TYPE  CIISTER-IP  EXTERNAL-IP PORT(S)  AGE
#headless-web ClusterIP None <none> 80/TCP’ 9m16s
#kubernetes  ClusterIP 10.1.0.1 <none> 443/TCP  37d
#web NodePort  10.1.87.150 <none> 80:30360/TCP 15d

在这里插入图片描述

启动一个busybox的Pod

kubectl run test -it --rm --image=busybox -- sh
nslookup headless-web
域名解析结果

在这里插入图片描述

在容器里可以通过<Pod Name>.<Headless Service>访问

curl web-0.headless-web

在这里插入图片描述

参考视频：https://ke.qq.com/user/index/index.html#/plan/cid=1709963&term_id=102815140

到此这篇关于K8S之StatefulSet有状态服务详解的文章就介绍到这了,更多相关K8S StatefulSet有状态服务内容请搜索脚本之家以前的文章或继续浏览下面的相关文章希望大家以后多多支持脚本之家！

