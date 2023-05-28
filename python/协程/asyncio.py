# asyncio模块用于定义协程函数，启动协程
# 定义协程函数用 async def xxx 和 await ，启动协程用loop=asyncio.get_event_loop()
# loop.run_until_complete(asyncio.wait(tasks))  (tasks是一个asyncio.ensure_future(协程函数（参数））的列表，
# 相当于多任务，异步执行tasks里的所有任务）或者loop=asyncio.get_event_loop()  future=asyncio.ensure_future(协程函数（参数））
# loop.run_until_complete(future) 相当于一个任务，调用一次协程函数
# ————————————————
# 版权声明：本文为CSDN博主「Aries8842」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
# 原文链接：https://blog.csdn.net/Aries8842/article/details/78952532


# 2、asyncio.wait 和 asyncio.gather 的异同

# 相同：从功能上看，asyncio.wait 和 asyncio.gather 实现的效果是相同的，都是把所有 Task 任务结果收集起来。
#
# 不同：asyncio.wait 会返回两个值：done 和 pending，done 为已完成的协程 Task，pending 为超时未完成的协程 Task，需通过 future.result 调用 Task 的 result；而asyncio.gather 返回的是所有已完成 Task 的 result，不需要再进行调用或其他操作，就可以得到全部结果。
#
#
# 2. asyncio.wait 用法：
# 最常见的写法是：await asyncio.wait(task_list)。
#
# 3. asyncio.gather 用法：
# 最常见的用法是：await asyncio.gather(*task_list)，注意这里 task_list 前面有一个 *。
#
#
# 作者：dex0423
# 链接：https://www.jianshu.com/p/6872bf356af7
# 来源：简书
# 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
