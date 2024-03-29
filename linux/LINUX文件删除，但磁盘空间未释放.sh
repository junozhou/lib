LINUX文件删除，但磁盘空间未释放
最近在进行系统压测，由于服务器节点太多，便写了个简单的脚本，在执行过程中发现，日志文件删除后，磁盘空间只释放了一小部分，任有大部分磁盘空间未释放。

使用lsof | grep delete命令，发现已经删除的文件仍然被应用程序占用。

解决方法：
1.杀掉进程kill -9 pid，重启应用服务
  批量操作方法：lsof | grep deleted | awk '{print $2}' | xargs kill -9
2.重启服务器

http://blog.51cto.com/ixdba/1435781



Linux系统里，直接删除日志文件，磁盘空间往往没有释放。可以不删除，用echo命令解决：
echo “” > info.log，可以看到磁盘空间已释放