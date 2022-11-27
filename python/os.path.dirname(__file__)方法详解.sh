该测试脚本所在的位置：D:\第1层\第2层\第3层\第4层\第5层\test11.py

1.  import os
2.  #该文件所在位置：D:\第1层\第2层\第3层\第4层\第5层\test11.py

3.  path1 = os.path.dirname(__file__)
4.  print(path1)#获取当前运行脚本的绝对路径

5.  path2 = os.path.dirname(os.path.dirname(__file__)) #
6.  print(path2)#获取当前运行脚本的绝对路径（去掉最后一个路径）

7.  path3 = os.path.dirname(os.path.dirname(os.path.dirname(__file__)))
8.  print(path3)#获取当前运行脚本的绝对路径（去掉最后2个路径）

9.  path4 = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(__file__))))
10.  print(path4)#获取当前运行脚本的绝对路径（去掉最后3个路径）

11.  path5 = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(__file__)))))
12.  print(path5)#获取当前运行脚本的绝对路径（去掉最后4个路径）

13.  path6 = os.__file__                  #获取os所在的目录
14.  print(path6)

结果：

16.  C:\Python352\python.exe D:/第1层/第2层/第3层/第4层/第5层/test11.py
17.  D:/第1层/第2层/第3层/第4层/第5层
18.  D:/第1层/第2层/第3层/第4层
19.  D:/第1层/第2层/第3层
20.  D:/第1层/第2层
21.  D:/第1层
22.  C:\Python352\lib\os.py
8.
23.  Process finished with exit code 0



os.path.dirname(file)返回脚本的路径，但是需要注意一下几点:

必须是实际存在的.py文件，如果在命令行执行，则会引发异常NameError: name 'file' is not defined；
在运行的时候如果输入完整的执行的路径，则返回.py文件的全路径如：Python c:/test/test.py 则返回路径 c:/test，如果是python test.py 则返回空；
结合os.path.abspath用，效果会好，如果大家看过一些python架构的代码的话，会发现经常有这样的组合：os.path.dirname(os.path.abspath(file)),os.path.abspath(file)返回的是.py文件的绝对路径。
这就是os.path.dirname(file)的用法，其主要总结起来有:

不要在命令行的形式来进行os.path.dirname(file)这种形式来使用这个函数；
结合os.path.abspath()使用

作者：流光汐舞
链接：https://www.jianshu.com/p/1bb207a6f1e9
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。