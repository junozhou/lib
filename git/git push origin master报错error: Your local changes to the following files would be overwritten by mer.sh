error: Your local changes to the following files would be overwritten by merge:         LivingDepth/living_depth.py
common/tools.py
config.py
generate_gallery_embedding.py
test.py
Please commit your changes or stash them be

#这种情况下，如何保留本地的修改同时又把远程的合并过来呢？
#
#首先取决于你是否想要保存本地修改。（是 /否）
#
#是
#有如下三部曲

 git stash
 git pull origin master
 git stash pop

#git stash的时候会把你本地快照，然后git pull 就不会阻止你了，pull完之后这时你的代码并没有保留你的修改。惊了！ 别急，我们之前好像做了什么？
#
#STASH
#这时候执行git stash pop你去本地看会发现发生冲突的本地修改还在，这时候你该commit push啥的就悉听尊便了。
#
#否
#既然不想保留本地的修改，那好办。直接将本地的状态恢复到上一个commit id 。然后用远程的代码直接覆盖本地就好了。

git reset --hard
git pull origin master


#另外，重装系统后拉代码让我输入gitlab的密码，输入了登录密码也不对，要重新配置生成ssh密钥，再拉取代码就可以了
#
#————————————————
#版权声明：本文为CSDN博主「人类高质量算法工程师」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/qq_35037684/article/details/116264699









————————————————
版权声明：本文为CSDN博主「人类高质量算法工程师」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/qq_35037684/article/details/116264699