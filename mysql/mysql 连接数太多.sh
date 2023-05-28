https://blog.csdn.net/wenchangwenliu/article/details/109461986

今天生产服务器上的MySQL出现了一个不算太陌生的错误“Too many connections”。平常碰到这个问题，我基本上是修改/etc/my.cnf的max_connections参数，然后重启数据库。但是生产服务器上数据库又不能随便重启。

没办法，只好想办法手动去释放一些没用的连接。
登陆到MySQL的提示符下，数据show processlist这个命令，可以得到所以连接到这个服务器上的MySQL连接：

mysql> show processlist;
最近使用mysql5.7的时候连接公司系统数据库时发现提示报错，出现mysql too many connection 的异常。经过查询发现是mysql的系统自带的连接数太小，连接的线程超过系统配置导致出现错误。

1. 首先登录mysql终端，输入show variables like max_connections，查看最大连接数。

修改最大连接数：set GLOBAL max_connections=1000，配置好之后再次查看最大连接数的量。



2. 超过连接数的原因，是mysql的连接数保持时间太长。可以修改一下保活机制show global variables like 'wait_timeout' ，就是最大睡眠时间。

修改一下　set global wait_timeout=300; 自动杀死线程。



3.  刚刚的配置是临时修改，重启mysql会失效。可以通过修改mysql的配置/etc/my.cnf。

group_concat_max_len = 10240
# 最大睡眠时间
wait_timeout=300
# 超时时间设置
interactive_timeout = 500
————————————————
版权声明：本文为CSDN博主「心诚则灵＇」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/wenchangwenliu/article/details/109461986