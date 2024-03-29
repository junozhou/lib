#1、git commit后，如何撤销commit
#修改了本地的代码，然后使用：

git add file
git commit -m '修改原因'

#执行commit后，还没执行push时，想要撤销这次的commit，该怎么办？
#
#解决方案：
#使用命令：

git reset --soft HEAD^

#这样就成功撤销了commit，如果想要连着add也撤销的话，--soft改为--hard（删除工作空间的改动代码）。
#
#命令详解：

#HEAD^ 表示上一个版本，即上一次的commit，也可以写成HEAD~1
#如果进行两次的commit，想要都撤回，可以使用HEAD~2

--soft
#不删除工作空间的改动代码 ，撤销commit，不撤销git add file

--hard
#删除工作空间的改动代码，撤销commit且撤销add

#另外一点，如果commit注释写错了，先要改一下注释，有其他方法也能实现，如：

git commit --amend
#这时候会进入vim编辑器，修改完成你要的注释后保存即可。

#作者：旅行者xy
#链接：https://www.jianshu.com/p/a9f327da3562
#来源：简书
#著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


#====================
#我想删除最近的两次commit：那就需要选择倒数第三次的commit id
#即：ae5346f77ac3a79dcababc16bcd61560b3d4b1cd
#
#Step2：
#使用如下两个命令撤销提交：

git reset --hard  ae5346f77ac3a79dcababc16bcd61560b3d4b1cd #如果还没有push到远程服务器只需要执行这一步
git push origin HEAD --force

#————————————————
#版权声明：本文为CSDN博主「sunweijm」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/sunweijm/article/details/77008177


