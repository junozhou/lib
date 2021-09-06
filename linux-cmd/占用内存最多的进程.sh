inux下获取占用CPU资源最多的10个进程，可以使用如下命令组合：

ps aux|head -1;ps aux|grep -v PID|sort -rn -k +3|head

linux下获取占用内存资源最多的10个进程，可以使用如下命令组合：

ps aux|head -1;ps aux|grep -v PID|sort -rn -k +4|head

命令组合解析(针对CPU的，MEN也同样道理)：

ps aux|head -1;ps aux|grep -v PID|sort -rn -k +3|head

该命令组合实际上是下面两句命令：

ps aux|head -1

ps aux|grep -v PID|sort -rn -k +3|head

其中第一句主要是为了获取标题内容(即USER PID %CPU %MEM VSZ RSS TTY STAT START TIME

COMMAND这些内容)，接下来的grep -v PID是将ps

aux获得的结果去掉上面的标题，即grep不包含PID这三个字母组合的行，再将其中结果使用sort排序，sort -rn -k

+3该命令中的-rn的r表示是结果倒序排列，n为以数值大小排序，而-k

+3则是针对第3列的内容进行比对排序，再使用head命令获取默认前10行数据。(其中的|表示管道操作)