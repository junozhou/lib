# 1) 多线程的并发效果
import threading

def func1():

    print('func1 start')

    for i in range(5):

        print('func1 ->', i)

    print('func1 end')

def func2():

    print('func2 start')

    for i in range(5):

        print('func2 ->', i)

    print('func2 end')

if __name__ == "__main__":

    t1 = threading.Thread(target=func1)

    t2 = threading.Thread(target=func2)

    t1.start()

    t2.start()

    t1.join()

    t2.join()

    print('all end')

#
# 这个多线程就很简单，在当前进程下再开启两个子线程，分别打印0 - 4，运行结果如下：
#
# func1 start
# func2 startfunc1 ->
# func2 ->0
# 0func1 ->
# func2 ->  11
#
# func1 ->func2 ->  22
#
# func1 ->func2 ->  33
#
# func1 ->func2 ->  44
#
# func1 endfunc2 end
#
# all end
#
# 没错，结果就是这么的丑陋，出现func1 -> func2 start这种情况是因为 Python 的线程切换是基于字节码字数的，每执行100条字节码切换一次，是不可控的。


# ————————————————
# 版权声明：本文为CSDN博主「weixin_29488835」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
# 原文链接：https://blog.csdn.net/weixin_29488835/article/details/113508507