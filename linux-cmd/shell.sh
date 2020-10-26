#! /bin/bash
#读取命令执行结果
for line in `grep worker *yaml | grep 146 | awk '{print $1}' | awk -F':' '{print $1}'`
do
 echo $line
 kubectl replace -f $line --force
done



#! /bin/bash
#从文件中读入
file=d5

for line in `cat ./$file`
do
  cat /data/docker/dokuwiki/logs/lighttpd/lighttpd/access.log | grep `echo $line |awk -F, '{print $1}'` | grep `echo $line |awk -F, '{print $2}'` | awk '{print $1}'|sort | uniq -c | wc -l
done