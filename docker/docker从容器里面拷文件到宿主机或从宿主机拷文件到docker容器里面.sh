在学习的过程中遇到这个问题，创建容器的时候没有挂载宿主机目录，导致在宿主机与容器之间无法进行文件共享，于是就想到如何从容器复制文件到宿主机或者从宿主机复制文件到容器。方法虽然简单，记录在博客中分享给大家。

首先通过docker ps确定容器的名称，我们假定容器名称为 nginx-web。

一、从容器复制文件到宿主机
现在我们想要将容器的 /home/licence.txt 文件复制到宿主机的 /home 目录下。执行如下命令：

docker cp nginx-web:/home/licence.txt /home

二、从宿主机复制文件到容器
现在我们想要将宿主机的 /home/licence.txt 文件复制到容器的 /home 目录下。执行如下命令：

docker cp /home/licence.txt nginx-web:/home

需要注意的是，不管容器有没有启动，拷贝命令都会生效。文章内容仅代表个人观点，如有不正之处，欢迎批评指正，谢谢大家。
#————————————————
#版权声明：本文为CSDN博主「志波同学」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/claram/article/details/104322078


http://www.mock.com/api/partner/v1/finances/list
http://www.mock.com/api/partner/v1/finances/list
http://12.0.217.143:30658/third-api-iep/api/partner/v1/finances/list
http://12.0.217.143:30658/third-api-iep/api/partner/v1/finances/list
http://12.0.217.143:30658/third-api-iep/api/partner/v1/finances/list