#! /bin/bash
#读取命令执行结果
for line in `grep worker *yaml | grep 146 | awk '{print $1}' | awk -F':' '{print $1}'`
do
 echo $line
 kubectl replace -f $line --force
done

for line in `cat ./a`
do
 echo $line
 kubectl replace -f $line --force
done

for line in `sudo locate *jar* | grep fastjson`:
  do
    echo $line | awk
    rm -rf $line
  done


for line in `ls | grep 01`
do
  echo $line
  echo "" > $line/chunks/000001
  echo "" > $line/chunks/000002
  echo "" > $line/chunks/000003
  echo "" > $line/chunks/000004
  echo "" > $line/chunks/000005
  echo "" > $line/index
  done
du -sh ./*
df -h

for line in `cat ./t`
do
  echo $line
  kubectl replace -f $line.yaml --force
  done

for dep in `kubectl get deployment -n ccbscf-t3|grep ccbscf|grep -v redis|awk '{print $1}'`;
do
  echo $dep
  done


#! /bin/bash
#从文件中读入
file=d5

for line in `cat ./file`
do
  cat /data/docker/dokuwiki/logs/lighttpd/lighttpd/access.log | grep `echo $line |awk -F, '{print $1}'` | grep `echo $line |awk -F, '{print $2}'` | awk '{print $1}'|sort | uniq -c | wc -l
done

for line in `cat ./f`
do
  mkdir data/$line/_series/00
  mkdir data/$line/_series/01
  mkdir data/$line/_series/02
  mkdir data/$line/_series/03
  mkdir data/$line/_series/04
  mkdir data/$line/_series/05
  mkdir data/$line/_series/06
  mkdir data/$line/_series/07
  touch data/$line/_series/00/0000
  touch data/$line/_series/01/0000
  touch data/$line/_series/02/0000
  touch data/$line/_series/03/0000
  touch data/$line/_series/04/0000
  touch data/$line/_series/05/0000
  touch data/$line/_series/06/0000
  touch data/$line/_series/07/0000

done



#! /bin/bash
# 从文件中读取
for line in `cat ./additems.txt`
do
 echo rm -rf $line
done


file= `ls *yaml`
for line in $file
do
  echo $line
done


for line in `cat ./fz`
do
#  echo $line
  cd $line
  git remote -v | grep fetch
  cd ../
done



for line in `cat ./fz`
do
#  echo $line
  cd $line
  git remote -v | grep inner | grep fetch | awk -v testEnv="git remote set-url origin " '{print testEnv$2}'
  cd ../
done





for line in `cat ./fz`
do
  echo $line
  echo "========"
  cd $line
  git remote -v | grep 3000 | grep fetch
  cd ../
done




cat ff | while read line; do
  cd `echo $line | awk -F '[/|.]' '{print $7}'`
  $line
  cd ../
  done


  cat fz2 | while read line; do
  cd `echo $line | awk -F '[/|.]' '{print $7}'`
  $line
  cd ../
  done


  cat fz2 | while read line; do
  cd `echo $line | awk -F '[/|.]' '{print $7}'`
  $line
  cd ../
  done



  for line in `cat ./fz`;
  do
    cd $line;
    git pull| grep "not found" ;
    cd ../; done