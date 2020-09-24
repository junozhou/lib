sed 命令详解（增删该查）

sed -n 打印行号
sed -e 多点编辑，可以执行多个子命令
sed -i 直接编辑原文件

* 查找
# 显示打印所有匹配行
sed  -n '/a/p' a.txt

# 显示打印所有匹配行，并进行筛选
sed  -n '/A/p' a.txt |grep A10
—————————————

* 增加
# 文件尾部增加数据
echo "新增的内容" >> a.txt

# 文件行首增加数据
 sed  '1 i\sed command start' a.txt

# 文件的行尾增加数据
sed  '$a \sed command end' a.txt

# 增加多行数据
sed -e '1 i\sed command start' -e '$a \sed command end' a.txt
—————————————

* 删除
#删除指定行(增加-i 为真正执行文件)： sed ‘Nd’ filename

# 删除第二行数据
sed 2d a.txt

# 删除m，n行数据
sed 'm,n'd a.txt

# 删除匹配的行
sed /A/d a.txt
—————————————

* 替换
#- 如果想替换的结果直接保存到原文中，就只需加上-i参数，否则将结果只是显示在屏幕上 sed -i ‘s/要替换的内容/新的内容/g’ 要处理的文件

#  将a替换成A前，查看替换的地方
sed  -n 's/a/A/p' a.txt |grep A

# 将A替换成a,执行替换增加-i 参数
sed -i 's/A/a/g' a.txt
sed -i "s/hotfix-20191226/master-20200104/g" *yaml

# 利用 多个sed命令也可以用-e参数连接起来，一次性完成多个操作替换
sed -e 's/a/A/g' -e 's/b/B/g'  a.txt

# 替换指定行的数据（将第二行的数据替换）
 sed '2c 这是替换后第二行的数据' a.txt -i


 —————————————
* Sed 修改文件内容

//批量修改当前文件夹下的文件的内容

sed -i "s/initialDelaySeconds: 70/initialDelaySeconds: 300/g" *



sed -i "s/initialDelaySeconds: 800/#  initialDelaySeconds: 800/g" *

sed -i "s/periodSeconds: 30/#  periodSeconds: 30/g" *
sed -i "s/port: 8679/#    port: 8679/g" *
sed -i "s/path: /health/#    path: /health/g" *
sed -i "s/"/log\"/#  httpGet/g" *

sed -i “/\#/b; s/livenessProbe/#livenessProbe/g" *

sed -i "s/periodSeconds: 15/periodSeconds: 30/g" *


sed -i "s/'hostname' => '12.0.216.153',/periodSeconds: 30/g" *

sed -i "s/hotfix-20191226/master-20200104/g" *yaml
sed -i "s/ccbscf-biz-payment/ccbscf-biz-agreement/g" *yaml

 —————————————
* SHELL 在指定行的前/后插入指定内容

#如果知道行号可以用下面的方法
sed -i '88 r b.file' a.file    #在a.txt的第88行插入文件b.txt
awk '1;NR==88{system("cat b.file")}' a.file > a.file

#如果不知道行号，可以用正則匹配
sed -i '/regex/ r b.txt' a.txt # regex是正则表达式
awk '/target/{system("cat b.file")}' a.file > c.file

#sed的話如果不改变源文件，可以去掉-i开关，修改会输出到STDOUT

—————————————

* 不知道行号，在指定行后添加一行
原文件：
 cat -n file
     1  aaaa
     2  bbbb
     3  cccc
     4  dddd

#现在要在第二行即“bbbb”行的下添加一行，内容为“xiaowu”。
# 此时，只会在终端打印，sed -i 可以写入原文件。
# 在Mac终端执行下面的sed语句会报错
[root@xiaowu shell]# sed '/bbbb/a\xiaowu' file
aaaa
bbbb
xiaowu
cccc
dddd


#如果要加两行“xiaowu”可以用一下语句，注意用“\n”换行
[root@xiaowu shell]# sed '/bbbb/a\xiaowu\nxiaowu' file
aaaa
bbbb
xiaowu
xiaowu
cccc
dddd

#如果要在第二行即“bbbb”行的上添加一行，内容为“xiaowu”，可以把参数“a”换成“i”
[root@xiaowu shell]# sed '/b/i\xiaowu' file
aaaa
xiaowu
bbbb
cccc
dddd

#由结果可知，每个匹配行的下一行都会被添加“xiaowu”

#那么如果指向在第二个“bbbb”的下一行添加内容“xiaowu”，该如何操作呢？
#可以考虑先获取第二个“bbbb”行的行号，然后根据行号在此行的下一行添加“xiaowu”

#获取第二个“bbbb”行的行号的方法：
方法一：
[root@xiaowu shell]# cat -n file |grep b |awk '{print $1}'|sed -n "2"p
4
方法二：
[root@xiaowu shell]# sed -n '/bbbb/=' file |sed -n "2"p
4
#由结果可知第二个“bbbb”行的行号为4，然后再在第四行的前或后添加相应的内容:
[root@xiaowu shell]# sed -e '4a\xiaowu' file
aaaa
bbbb
cccc
bbbb
xiaowu
dddd
[root@xiaowu shell]# sed -e '4a\xiaowu\nxiaowu' file
aaaa
bbbb
cccc
bbbb
xiaowu
xiaowu
dddd


#向指定行的末尾添加指定内容，比如在“ccccc”行的行尾介绍“ eeeee”
[root@xiaowu shell]# cat file
aaaaa
bbbbb
ccccc
ddddd
[root@xiaowu shell]# sed 's/cc.*/& eeeee/g' file
aaaaa
bbbbb
ccccc eeeee
ddddd