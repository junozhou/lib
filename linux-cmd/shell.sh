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

for line in `tail -n 100 ./cc.txt`
do
 ls $line > ccc.txt

done
select * from tf.table_file t where t.count = '0' and t.create_time <
to_date('12-12-2019 18:42:20', 'dd-mm-yyyy hh24:mi:ss') and t.file_path like '%cupload/%' AND t.FILE_SIZE > 10 ORDER BY t.create_time DESC

for line in `sudo locate *jar* | grep fastjson`:
  do
    echo $line | awk
    rm -rf $line
  done

for line in `kubectl get pod,deployment -n health-check | grep Terminating | awk '{print $1}'`
  do
    kubectl delete $line --force --grace-period=0 -n health-check
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

for dep in `kubectl get deployment -n test|grep test|grep -v redis|awk '{print $1}'`;
do
  echo $dep
  done


for line in `kubectl get deployment -n test-t8 | grep -E "test-api-mobile-paper|test-biz-stdpaper" | awk '{print $1}'`
do
  kubectl delete deployment.extensions/$line -n test-t8
  done


for line in `ls /test/test/default/20220601`
do

  fa="/test/test/default/20220601/${line}"
  for cline in `ls ${fa}`
  do

    if [[ ${cline} != "56" || ${cline} != "57" || ${cline} != "58" ]]
        then
          echo "包含"
          echo $fa/$cline
          rm -rf $fa/$cline/*
      fi

    done
  done



  for line in `ls /test/test/default/20220601`
  do

    fa="/test/test/default/20220601/${line}"
    for cline in `ls ${fa}`
    do
      echo $fa/$cline
      find $fa/$cline -name "*zip" -amin +1 -type f -print | xargs rm -f
      done
    done

  for line in `ls /test/test/default/20220602`
  do

    fa="/test/test/default/20220602/${line}"
    for cline in `ls ${fa}`
    do
      echo $fa/$cline
      find $fa/$cline -name "*zip" -amin +1 -type f -print | xargs rm -f
      done
    done


if [ ! -d "/cuploadarch1" ];then
  mkdir -p /cuploadarch1
fi


      for line in `ls /test/test/default/20220602`
      do

        fa="/test/test/default/20220602/${line}"
        for cline in `ls ${fa}`
        do
          echo $fa/$cline
          find $fa/$cline -name "*zip" -amin +1 -type f -print | xargs rm -f

          done
        done

  #  for cline in `ls /test/test/default/20220601/`


#! /bin/bash
#从文件中读入
file=d5

for line in `cat ./file`
do
  cat test/access.log | grep `echo $line |awk -F, '{print $1}'` | grep `echo $line |awk -F, '{print $2}'` | awk '{print
  $1}'|sort | uniq -c | wc -l
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


file= `kubectl get pod -n test -o wide | grep 123| awk '{print $1}'`
for line in `kubectl get pod -n test -o wide | grep 123| awk '{print $1}'`
do
  echo $line
  kubectl delete pod $line -n test --force --grace-period=0
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



for line in `ls /var/local/codediff/test`
do
  echo "========s==="
  echo $line

  cd $line
  git remote -v | grep fetch | awk '{print $1}'
  echo "========end===="
  cd ../
done

for line in `sudo find / -name log4j-core*jar`
do
  echo $line
  sudo rm -rf $line
done

for line in `top -b -n 2 | grep java| grep -v grep|awk '{print $1}'`
  do
    ps -ef | grep $line | grep -v grep

    echo $line

  done



for line in `ls -lrth | grep 2021 | awk '{print $9}'`
do
  echo $line
  echo "" > $line
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

/data/Pccbscf/projects/test2/
    for line in `cat ./cb.txt`
    do
      echo $line
      rm -rf $line
      done

cd /data/Pccbscf/projects/test2
rm -rf testcc1 testcc2 testcc3