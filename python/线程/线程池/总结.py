参考：https://www.cnblogs.com/ygbh/p/12072085.html

Python之concurrent.futures模块的使用
concurrent.futures的作用：
管理并发任务池。concurrent.futures模块提供了使用工作线程或进程池运行任务的接口。线程和进程池API都是一样，所以应用只做最小的修改就可以在线程和进程之间地切换

1、基于线程池使用map()
with ThreadPoolExecutor(max_workers=5) as pool:
    htmls = pool.map(craw, urls)
    htmls = list(zip(urls, htmls))
    for url,html in htmls:
        matUrl = url.split("&service=")[1].split("&branch")[0]
        if matUrl not in html['msg']:
            html['msg'] = f"{matUrl.group(1)}-{html['msg']}"
        res.append(html)


Future Objects
  Future实例由Executor.submit方法返回，注意Executor.map并不会返回Future对象，而是一个迭代器，迭代器的内容由你调用函数返回的内容组成。

2、futures执行单个任务


复制代码
#!/usr/bin/env python
# -*- coding: utf-8 -*-

from concurrent import futures
import threading
import time

def task(n):
    print('{}: 睡眠 {}'.format(threading.current_thread().name, n))
    time.sleep(n / 10)
    print('{}: 执行完成 {}'.format(threading.current_thread().name, n))
    return n / 10

ex = futures.ThreadPoolExecutor(max_workers=2)
print('main :开始')
f = ex.submit(task, 5)
print('main: future: {}'.format(f))
print('等待运行结果')
results = f.result()
print('main: result:{}'.format(results))
print('main: future 之后的结果:{}'.format(f))


@python 3.6.8

"""Future methods."""

cancel()
# 尝试取消调用，终止进程池中的任务，无法取消返回False，成功返回True

cancelled()
# 返回True表示成功取消

running()
# 返回True表示任务正在被调用不能取消

done()
# 返回True表示任务成功取消或者完成

result(timeout=None)
# 返回执行结果，timeout为任务运行指定时间，若超时则引发错误，不设置将永远等待任务返回。

exception(timeout=None)
# 返回任务执行异常，没有异常返回None，timeout为任务运行指定时间，同上。

add_done_callback(fn)
# 回调函数，传递Future对象给fn函数，
# 最大的特点是被调用的fn函数是在调用方法的同一个进程的同一个线程中执行。

作者：lifanxin
链接：https://www.jianshu.com/p/36bf441034b9
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


Module Functions

@python 3.6.8

concurrent.futures.wait(fs, timeout=None, return_when=ALL_COMPLETED)
# 等待由fs传递来的futures实例完成，futures可以是由不同的Executor对象创建，
# 返回由两个集合构成的元组，第一个集合，包含已经完成和被取消的；
# 第二个集合包含没有完成的。timeout参数和前面的一样。

# return_when 常量
FIRST_COMPLETED
# 立刻返回，如果fs中有任何future完成或者被取消

FIRST_EXCEPTION
# 立刻返回，如果fs中有任何future引发错误，如果没有那么和ALL_COMPLETED一样

ALL_COMPLETED
# 返回，当所有future完成后或者被取消


concurrent.futures.as_completed(fs, timeout=None)
# 遍历fs提供的futures实例，futures可以是由不同的Executor对象创建，
# 当它们完成或者被取消时，使用yield返回迭代器。
# 如果fs提供有重复的future那么这个future只会返回一次。timeout参数和上面一样。

作者：lifanxin
链接：https://www.jianshu.com/p/36bf441034b9
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。





