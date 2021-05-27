kubectl delete pod `kubectl get pod -n xxx|grep "Evicted"|awk '{print $1}'` -n xxx
docker volume prune -f
docker rm `docker ps -a | grep Exited | awk '{print $1}'`
docker rmi `docker images | grep  "<none>" | awk '{print $3}'`
docker images --no-trunc # 显示完整的镜像信息
docker system df # 用于查看Docker的磁盘使用情况

#清理容器里的日志
cd /var/lib/docker/containers
for i in `ls`; do echo "" > $i/$i-json.log; done
for i in `ls`; do echo "" > $i/$i.json; done