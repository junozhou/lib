# 2) python 协程实现并发
#
# python 协程是单线程的，但是它具有多线程的并发效果,这也是python 协程最主要的作用，怎么实现的呢？
#
# 这里我们就要介绍一下协程中任务或者日程的概念，在协程中的每个任务就对应多线程中的一条线程，我们要同时运行多个程序，那就将多个程序打包成任务，这样在协程中运行时，就会同时启动这些任务。
#
# 例如下面的程序(先不要关注语法 async await，当成正常函数看就行了)：

import asyncio

from datetime import datetime

async def coro1():

    print(f'coro1 start')

    for i in range(3):

        print('coro1 -', i)

    await asyncio.sleep(3) # 休眠3秒

    print(f'coro1 end')

async def coro2():

    print(f'coro2 start')

    for i in range(3):

        print('coro2 -', i)

    await asyncio.sleep(4) # 休眠4秒

    print(f'coro2 end')

async def main():

    # 将coro1()打包成任务

    task1 = asyncio.create_task(coro1())

    # 将coro2()打包成任务

    task2 = asyncio.create_task(coro2())

    print(datetime.now())

    await task1 # 启动任务1

    await task2 # 启动任务2

    print(datetime.now())

if __name__ == '__main__':

    asyncio.run(main())


# 从运行的结果我们可以看出以下几点：
#
# 1.coro1()与coro2()中有休眠3秒、休眠4秒,但是打印结果显示整个main()也只运行了4秒，所以它们是同时运行的，确实实现了并发效果。
#
# 2.从打印的效果来看，非常的整齐，完全不像多线程那样的丑陋，这是因为协程中切换任务是可以调控的，给了程序员很大的空间，也就是异步效果。
#
# 详细解释一下完整的运行
#
# 首先在当前线程中正常执行


# print(datetime.now())
#
# 咦，遇到两个协程 任务/日程task1、task2 ,于是当前线程先进入到任务task1中,并运行函数coro1()的代码：
#
# print(f'coro1 start')
#
# for i in range(3):
#
# print('coro1 -', i)
#
# 这些都是 正常的的同步代码，当前线程在task1中运行这些代码是不会切换的，当遇到
#
# await asyncio.sleep(3)
#
# 前面加了关键词await，这表明 asyncio.sleep(3)是一个异步的操作，也是切换的指令，于是当前线程切换到下一个任务去，也就是task2,开始在task2中执行代码
#
# print(f'coro2 start')
#
# for i in range(3):
#
# print('coro2 -', i)
#
# 在task2中执行，又遇到
#
# await asyncio.sleep(4)
#
# 由于两个任务都在执行sleep(),于是当前线程开始等待异步的结果，3秒过去，task1的asyncio.sleep(3)完成，当前线程切换到task1`继续执行
#
# print(f'coro1 end')
#
# 再过去一秒，task2的asyncio.sleep(4)也完成，切换到task2，执行
#
# print(f'coro2 end')
#
# 两个任务都完成了，也就是
#
# await task1 # 启动任务1
#
# await task2 # 启动任务2
#
# 执行完毕，接着往下执行
#
# print(datetime.now())
#
# 通过整个运行流程可以看到，在协程中，切换任务是可控的。
#
# 当遇到异步操作await ……时，线程就切换到下一个任务中去执行，当异步结果完成后，再切回来，这样就实现了在多个任务中切换与退出(进进出出)以实现并发效果。


# 二、协程与多线程对比
#
# 1) 协程更节省系统资源
#
# 首先创建线程需要一定的开销，而协程不需要创建多余的线程。
#
# 其次多线程之间的切换开销是远远大于协程间任务切换的开销。
#
# 最后是切换频率，多线程中为了实现并发效果，在每个线程中执行100个字节码就会进行切换。而协程中任务并发切换则不会这么频繁，直到遇到异步操作才会切换任务。
#
# 2)协程是单线程的，不需要加锁，更好控制。
#
# 在多线程中，由于数据是共享的，在执行一个函数时，可能执行到一半，就切换成下一个线程来执行，如果刚好下一个线程也需要操作这个函数，而函数的数据还是上一个线程操作时的遗留状态，这样就会造成数据混乱，所以我们要对这样的函数加锁，强制线程执行完这个函数后再切换出去，而不是执行100个字节码就切换。
#
# 而协程是单线程的，不需要加锁。
#
# 3)协程调用系统资源更加均匀。
#
# 仔细想一想，协程在单线程实现并发效果，和小学生的流程控制题目一样。
#
# 小明起床2分钟，洗漱5分钟，等待煮饭10分钟，吃饭5分钟.
#
# 问小明一共需要多久能做好，这道题目的精髓就是小明在等待煮饭的时间可以做其它的事情。
#
# 协程实现并发也是如此，在做耗时的IO操作时，协程切换任务，去做其它的事情，等耗时的IO完成了再接着做，所以实现一个人同时做多件事情，所以协程始终在做事，调用系统资源比较均匀稳定。
#
# 而多线程的并发则会出现这样一种情况，有的时候多个线程同时调用系统资源，有的时候多个线程又都很闲，系统资源一下子又空着没人用了，这就是多线程不懂协调分配任务。
#
# 三、协程的运用场景
#
# IO密集型与计算密集型
#
# 一般的程序都分上面两种，IO操作比较多的程序，如读写文件、发送网络数据时，就需要等待IO操作完成，这种成为IO密集型，比较适合使用协程。
#
# 如果是CPU计算比较多的，则不适合使用协程。


# ————————————————
# 版权声明：本文为CSDN博主「weixin_29488835」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
# 原文链接：https://blog.csdn.net/weixin_29488835/article/details/113508507