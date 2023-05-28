1、首先找到overlay2目录
cd /var/lib/docker/overlay2

2、查看文件的大小
du -h --max-depth=1|grep G
1.6G	./ad5a2362a03ff9b79154d58d3b5bc0e839e09d32e3b6216ec886e0d291472073

3、查看占用空间的pid，以及对应的容器名称
docker ps -q | xargs docker inspect --format '{{.State.Pid}}, {{.Name}}, {{.GraphDriver.Data.WorkDir}}' | grep "ad5a2362a03ff9b79154d58d3b5bc0e839e09d32e3b6216ec886e0d291472073"
6991, /k8s_test-server, /var/lib/docker/overlay2/ad5a2362a03ff9b79154d58d3b5bc0e839e09d32e3b6216ec886e0d291472073/work

#4、解决方法（会删除对应的容器和对应镜像）：
docker stop k8s_test-server && docker rm k8s_test-server

#版权声明：本文为CSDN博主「喵喵喵更多」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/m0_67393827/article/details/123731553


kubectl label nodes t4-k8sn-49 worker=worker221049
kubectl label nodes t4-k8sn-50 worker=worker221050
kubectl label nodes t4-k8sn-51 worker=worker221051
kubectl label nodes t2-k8sn-70 worker=worker221070
#kubectl label nodes cs-docker-155 worker=worker155




4、手动删除不用的镜像
在执行docker system prune -f 删除不了之后
sudo docker images |grep 镜像tag等唯一指标 | awk '{print $3}' | xargs sudo docker rmi --force
sudo docker images |grep 2.0.0-SNAPSHOT-hotfeat-20220401-auth | awk '{print $3}' | xargs sudo docker rmi --force