#!/bin/bash
echo "Hello $USER,"
echo "Today is $(date +'%Y-%m-%d')"


1. 使用bash -x
bash -x打印出脚本执行过程中的所有语句
like：
shell数组.sh   shell调试.sh
shell git:(master)  bash -x shell调试.sh
+ echo 'Hello zhouxiaoyan,'
Hello zhouxiaoyan,
++ date +%Y-%m-%d
+ echo 'Today is 2023-01-18'
Today is 2023-01-18
shell git:(master)  bash shell调试.sh
Hello zhouxiaoyan,
Today is 2023-01-18

2. set
有的时候，我们的脚本非常复杂，使用bash -x得到的输出太多，很难找到需要的信息
set 可以进行局部调试，在需要调试的代码之前加上“set -x”，需要调试的代码之后加上“set +x”即可
like：
如下面的脚本所示：

##!/bin/bash
#echo "Hello $USER,"
#set -x
#echo "Today is $(date %Y-%m-%d)"
#set +x

#!/bin/bash
echo "Hello $USER,"
set -x
echo "Today is $(date +'%Y-%m-%d')"
set +x

让我们看看运行起来是啥样？

$  bash shell-set.sh
  Hello zhouxiaoyan,
  ++ date +%Y-%m-%d
  + echo 'Today is 2023-01-18'
  Today is 2023-01-18
  + set +x



注意：我们在运行脚本的时候，不需要使用bash -x了。

##### 在跟踪里输出行号

#在一个很大的脚本中，你会看到很多很多的执行跟踪的输出，阅读起来非常费劲，所以，你可以在每一行前加上文件的行号，这会非常有用。要做到这样，你只需要设置下面的环境变量：
#
#export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}: '
#让我们看看设置上了PS4这个环境变量后会是什么样的输出。
$ bash -x example_script.sh
+example_script.sh:2:: echo 'Hello chenhao,'
Hello chenhao,
++example_script.sh:3:: date +%Y-%m-%d
+example_script.sh:3:: echo 'Today is 2009-08-31'
Today is 2009-08-31

主要参考：
https://www.likecs.com/show-306217476.html
原文链接：
https://www.cnblogs.com/sakaiPeng/p/9766044.html