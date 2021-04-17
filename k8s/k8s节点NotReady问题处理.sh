1、kubectl get events
2、journalctl -f
3、kubectl describe node <节点名称>


Pending：该阶段表示已经被 Kubernetes 所接受，但是容器还没有被创建，正在被 kube 进行资源调度。
1：图中数字 1 是表示在被 kube 资源调度成功后，开始进行容器的创建，但是在这个阶段是会出现容器创建失败的现象
Waiting或ContainerCreating：这两个原因就在于容器创建过程中镜像拉取失败，或者网络错误容器的状态就会发生转变。
Running：该阶段表示容器已经正常运行。
Failed：Pod 中的容器是以非 0 状态（非正常）状态退出的。
2：阶段 2 可能出现的状态为CrashLoopBackOff，表示容器正常启动但是存在异常退出。
Succeeded：Pod 容器成功终止，并且不会再在重启。
https://blog.csdn.net/Tulipyx/article/details/113869714?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.control&dist_request_id=1328665.22126.16160685827724025&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.control
————————————————
版权声明：本文为CSDN博主「YX杨小鑫」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/Tulipyx/article/details/113869714