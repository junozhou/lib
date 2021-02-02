1 、简单用法
du -a /log/* | sort -n -r | head -n 1 | awk '{print $1\" \"$2}' #选出占用磁盘最大的目录


2、复杂用法
grep "slow sql.*millis." /log/service-name/*log.2021-01-29* | awk -F" " '{ if(int($13) > 7000 || int($12) > 7000){print $0}}'

2.1、
echo b1c2d3d1e8f9 | awk '
{
     string=$0
     len=length(string)
     for(i=0; i<=len; i++)
     {
          tmp=substr(string,i,1)
          if(tmp ~ /[1-9]/)
          {
              str=tmp
              str1=(str1 str)
         }
     }
     print str1
}'

3、awk 变量testEnv
"docker inspect -f '{{.State.Pid}} {{.Name}}' $(docker ps -q) | grep %s | awk '{print $2}' | awk -v testEnv=%s -F '[_.]' '{print testEnv\"_\"$2}'" % (ppid,returned_env[0].upper())