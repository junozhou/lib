#方式一：
#
#  先将指定文件添加到 暂存区，然后提交所有 暂存区 的文件

git add index.html about.html
git commit -m '我提交了所有 暂存区 的文件'
#方式二：
#
#  此方式可以提交分别来自不同地方的文件，比如 工作区的 和 暂存区的

git commit -o index.html about.html -m '我同时提交了 工作区的index.html 和 暂存区的about.html 这两个文件'

#————————————————
#版权声明：本文为CSDN博主「糖薪砖」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/tangxinzhuan/article/details/89428745