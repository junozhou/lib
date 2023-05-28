子线程：可以看做是程序执⾏的⼀条分⽀，当⼦线程启动后会和主线程⼀起同时执⾏
使用threading .Thread(target=函数名，args=(参数列表，元组))创建子线程对象


关于这里的start和jion都是固定的操作套路，记住这两个代词以后直接套用即可，需要注意的是多线程程序的执行顺序是不确定的。
当执行到sleep语句时，线程将被阻塞（Blocked），到sleep结束后，线程进入就绪（Runnable）状态，
等待调度的命令执行另一个子线程，线程调度将自行选择一个线程执行。



三、多线程

import threading #引入多线程
importrequest,time,os

deflajifenlei（）:
    time.sleep(2):
    print('干垃圾')
start_time=time.time()

defshangke():
    time.sleep(2)
    print('上课')
#单线程
for  i in range(10):
    lajifenlei()
print(time.time()-start_time)
#结果：单线程需要20多秒
#启动线程
for i in range（10):#启动10个线程
    th=threading.Thread(target=laijifenlei)  #只写函数名
th.start()
print(time.time()-start_time)   #这里打印出的结果，是主线程运行完的时间，但是子线程并没有运行完。
线程和线程之间是独立的，所有的进程中，本身就有一个线程，这个线程是主线程。python文件本身就是一个进程，所以在没有启动线程的时候，本身就有一个主线程。

那么，如果需要知道所有线程运行完的时间，就需要主线程等待子线程。


#主线程等待子线程方法一:

threads=[]:
for i in range(10):#启动10个线程
    sk=threading.Thread(target=shangke）
    sk.start()
    threads.append(sk)#运行完的子线程，加入到list中
for t inthreads:
    t.join() #等待list中子线程全部运行完，这里的join区别于字符串的join
#t.join的作用就是，主线程一直等待全部的子线程结束之后，主线程自身才结束，程序退出。
 print(time.time()-start_time) #结果：10个线程需要2秒多点
#主线程等待子线程方法二:

for i in range（10）：
    sk=threading.Thread(target=shangke)
    sk.start()
#threading.activeCount():#查看当前运行的线程数，包括主线程
while threading.activeCount()!=1:          #查看当前有几个线程,=1说明只有一个主线程，即子线程都运行完了。
     pass
print(time.time() - start_time)
四、线程锁：
threading模块中提供了5种最常见的锁，下面是按照功能进行划分：

同步锁：lock（一次只能放行一个）
递归锁：rlock（一次只能放行一个） recursion lock
条件锁：condition（一次可以放行任意个）
事件锁：event（一次全部放行）(红绿灯锁)
信号量锁：semaphore（一次可以放行特定个）
#————————————————
#版权声明：本文为CSDN博主「沐 修」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/qq_42701659/article/details/124213677