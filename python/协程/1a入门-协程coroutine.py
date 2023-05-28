# https://zhuanlan.zhihu.com/p/525051592

########1. 案例引入
# 在介绍协程之前，我们先来看一个案例网站，链接地址为：https://httpbin.org/delay/5，如果我们访问这个链接，
# 需要等待五秒之后才能得到结果，这是因为服务器强制等待了 5 秒的时间才返回响应。
#
# 平时我们浏览网页的时候，绝大部分网页响应速度还是很快的，
# 如果我们写爬虫来爬取的话，发出 Request 到收到 Response 的时间不会很长，因此我们需要等待的时间并不多。
#
# 然而像上面这个网站，一次 Request 就需要 5 秒才能得到 Response，如果我们用 requests 写爬虫来爬取的话，
# 那每次 requests 都要等待 5 秒才能拿到结果了。
#
# 我们来测试下，下面我们来用 requests 写一个遍历程序，直接遍历 100 次试试看，实现代码如下：

import requests
import logging
import time
logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(levelname)s: %(message)s')
TOTAL_NUMBER = 100
URL = 'https://httpbin.org/delay/5'
start_time = time.time()
for _ in range(1, TOTAL_NUMBER + 1):
    logging.info('scraping %s', URL)
    response = requests.get(URL)
end_time = time.time()
logging.info('total time %s seconds', end_time - start_time)
# 这里我们直接用循环的方式构造了 100 个 Request，使用的是 requests 单线程，
# 在爬取之前和爬取之后记录了时间，最后输出爬取了 100 个页面消耗的时间。
#
# 运行结果如下：
#
# 2020-08-03 01:01:36,781 - INFO: scraping https://httpbin.org/delay/5
# 2020-08-03 01:01:43,410 - INFO: scraping https://httpbin.org/delay/5
# 2020-08-03 01:01:50,029 - INFO: scraping https://httpbin.org/delay/5
# 2020-08-03 01:01:56,702 - INFO: scraping https://httpbin.org/delay/5
# 2020-08-03 01:02:03,345 - INFO: scraping https://httpbin.org/delay/5
# 2020-08-03 01:02:09,958 - INFO: scraping https://httpbin.org/delay/5
# 2020-08-03 01:02:16,500 - INFO: scraping https://httpbin.org/delay/5
# 2020-08-03 01:02:23,143 - INFO: scraping https://httpbin.org/delay/5
# ...
# 2020-08-03 01:12:19,867 - INFO: scraping https://httpbin.org/delay/5
# 2020-08-03 01:12:26,479 - INFO: scraping https://httpbin.org/delay/5
# 2020-08-03 01:12:33,083 - INFO: scraping https://httpbin.org/delay/5
# 2020-08-03 01:12:39,758 - INFO: total time 662.9764430522919 seconds
# 由于每个页面至少要等待 5 秒才能加载出来，因此 100 个页面至少要花费 500 秒的时间，
# 加上网站本身负载的问题，总的爬取时间最终为 663 秒，大约 11 分钟。
#
# 这在实际情况下是很常见的，有些网站本身加载速度就比较慢，稍慢的可能 1~3 秒，更慢的说不定 10 秒以上。
# 如果我们用 requests 单线程这么爬取的话，总的耗时是非常多的。
# 此时如果我们开了多线程或多进程来爬取的话，其爬取速度确实会成倍提升，那是否有更好的解决方案呢？
#
# 本节就来了解一下使用协程来加速的方法，此种方法对于 IO 密集型任务非常有效。如将其应用到网络爬虫中，爬取效率甚至可以成百倍地提升。
# 2. 基础知识
# 在了解协程之前，我们首先了解一些基础概念，如阻塞和非阻塞、同步和异步、多进程和协程。
#
# 阻塞
# 阻塞状态指程序未得到所需计算资源时被挂起的状态。程序在等待某个操作完成期间，自身无法继续干别的事情，则称该程序在该操作上是阻塞的。
#
# 常见的阻塞形式有：网络 I/O 阻塞、磁盘 I/O 阻塞、用户输入阻塞等。阻塞是无处不在的，包括 CPU 切换上下文时，所有的进程都无法真正干事情，它们也会被阻塞。如果是多核 CPU，则正在执行上下文切换操作的核不可被利用。
#
# 非阻塞
# 程序在等待某操作的过程中，自身不被阻塞，可以继续运行干别的事情，则称该程序在该操作上是非阻塞的。
#
# 非阻塞并不是在任何程序级别、任何情况下都存在的。仅当程序封装的级别可以囊括独立的子程序单元时，它才可能存在非阻塞状态。
#
# 非阻塞的存在是因为阻塞存在，正因为某个操作阻塞导致的耗时与效率低下，我们才要把它变成非阻塞的。
#
# 同步
# 不同程序单元为了完成某个任务，在执行过程中需靠某种通信方式以协调一致，此时这些程序单元是同步执行的。
#
# 例如在购物系统中更新商品库存时，需要用“行锁”作为通信信号，让不同的更新请求强制排队顺序执行，那更新库存的操作是同步的。
#
# 简言之，同步意味着有序。
#
# 异步
# 为了完成某个任务，有时不同程序单元之间无须通信协调也能完成任务，此时不相关的程序单元之间可以是异步的。
#
# 例如，爬取下载网页。调度程序调用下载程序后，即可调度其他任务，而无须与该下载任务保持通信以协调行为。不同网页的下载、保存等操作都是无关的，也无须相互通知协调。这些异步操作的完成时刻并不确定。
#
# 简言之，异步意味着无序。
#
# 多进程
# 多进程就是利用 CPU 的多核优势，在同一时间并行执行多个任务，可以大大提高执行效率。
#
# 协程
# 协程，英文叫作 coroutine，又称微线程、纤程，它是一种用户态的轻量级线程。
#
# 协程拥有自己的寄存器上下文和栈。协程调度切换时，将寄存器上下文和栈保存到其他地方，在切回来的时候，恢复先前保存的寄存器上下文和栈。因此，协程能保留上一次调用时的状态，即所有局部状态的一个特定组合，每次过程重入时，就相当于进入上一次调用的状态。
#
# 协程本质上是个单进程，它相对于多进程来说，无须线程上下文切换的开销，无须原子操作锁定及同步的开销，编程模型也非常简单。
#
# 我们可以使用协程来实现异步操作，比如在网络爬虫场景下，我们发出一个请求之后，需要等待一定时间才能得到响应，但其实在这个等待过程中，程序可以干许多其他事情，等到响应得到之后才切换回来继续处理，这样可以充分利用 CPU 和其他资源，这就是协程的优势。
#
# 3. 协程的用法
# 接下来，让我们来了解一下协程的实现。从 Python 3.4 开始，Python 中加入了协程的概念，但这个版本的协程还是以生成器对象为基础，Python 3.5 则增加了 async/await，使得协程的实现更加方便。
#
# Python 中使用协程最常用的库莫过于 asyncio，所以本节会以 asyncio 为基础来介绍协程的用法。
#
# 首先，我们需要了解下面几个概念：
#
# event_loop：事件循环，相当于一个无限循环，我们可以把一些函数注册到这个事件循环上，当满足条件发生的时候，就会调用对应的处理方法。
# coroutine：中文翻译叫协程，在 Python 中常指代协程对象类型，我们可以将协程对象注册到时间循环中，它会被事件循环调用。我们可以使用 async 关键字来定义一个方法，这个方法在调用时不会立即被执行，而是返回一个协程对象。
# task：任务，它是对协程对象的进一步封装，包含了任务的各个状态。
# future：代表将来执行或没有执行的任务的结果，实际上和 task 没有本质区别。
# 另外，我们还需要了解 async/await 关键字，它是从 Python 3.5 才出现的，专门用于定义协程。其中，async 定义一个协程，await 用来挂起阻塞方法的执行。
#
# 4. 准备工作
# 在本节开始之前，请确保安装的 Python 版本为 3.5 及以上，如果版本是 3.4 及以下，则下方的案例是不能运行的。
#
# 具体的安装方法可以参考：https://setup.scrape.center/python。
#
# 安装好合适的 Python 版本之后我们就可以开始本节的学习了。
# 5. 定义协程


# 我们引入了 asyncio 这个包，这样我们才可以使用 async 和 await
import asyncio
# async 定义了一个 execute 方法，该方法接收一个数字参数，执行之后会打印这个数字。
async def execute(x):
    print('Number:', x)

# 随后我们直接调用了这个方法，然而这个方法并没有执行，而是返回了一个 coroutine 【协程对象】
coroutine = execute(1)
print('Coroutine:', coroutine)
print('After calling execute')
# 随后我们使用 get_event_loop 方法创建了一个【事件循环】 loop
loop = asyncio.get_event_loop()
# 并调用了 loop 对象的 run_until_complete 方法将协程注册到【事件循环】 loop 中，然后启动。
# 当我们将 coroutine 对象传递给 run_until_complete 方法的时候，实际上它进行了一个操作，就是将 coroutine 封装成了 task 对象。
loop.run_until_complete(coroutine)
print('After calling loop')

# 执行结果
# Coroutine: <coroutine object execute at 0x110588548>
# After calling execute
# Number: 1
# After calling loop
#
# Process finished with exit code 0

# 最后，我们才看到 execute 方法打印了输出结果。
# 可见，async 定义的方法就会变成一个无法直接执行的 coroutine 对象，必须将其注册到事件循环中才可以执行。
# 在上面的例子中，当我们将 coroutine 对象传递给 run_until_complete 方法的时候，
# 实际上它进行了一个操作，就是将 coroutine 封装成了 task 对象。我们也可以显式地进行声明，如下所示：
import asyncio
async def execute(x):
    print('Number:', x)
    return x
coroutine = execute(1)
print('Coroutine:', coroutine)
print('After calling execute')
loop = asyncio.get_event_loop()
# 显示的将 coroutine 封装成了 task 对象
# 这里我们定义了 loop 对象之后，接着调用了它的 create_task 方法将 coroutine 对象转化为 task 对象，
# 随后我们打印输出一下，发现它是 pending 状态。
task = loop.create_task(coroutine)
print('Task:', task)
# 接着，我们将 task 对象添加到事件循环中执行，随后打印输出 task 对象，
# 发现它的状态变成了 finished，同时还可以看到其 result 变成了 1，也就是我们定义的 execute 方法的返回结果。
loop.run_until_complete(task)
print('Task:', task)
print('After calling loop')

# 执行结果
# Coroutine: <coroutine object execute at 0x10b0b07c8>
# After calling execute
# Task: <Task pending coro=<execute() running at /Users/zhouxiaoyan/Documents/coding/lib/python/1a入门-协程coroutine.py:23>>
# Number: 1
# Task: <Task finished coro=<execute() done, defined at /Users/zhouxiaoyan/Documents/coding/lib/python/1a入门-协程coroutine.py:23> result=1>
# After calling loop
#
# Process finished with exit code 0


# 另外，定义 task 对象还有一种方式，就是直接通过 asyncio 的 ensure_future 方法，
# 返回结果也是 task 对象，这样的话我们就可以不借助 loop 来定义。
# 即使我们还没有声明 loop，也可以提前定义好 task 对象，写法如下：
#
import asyncio
# 1、async定义方法
async def execute(x):
    print('Number:', x)
    return x
# 2、调用方法，实际上没有调用，返回协程对象
coroutine = execute(1)
print('Coroutine:', coroutine)
print('After calling execute')
# 3、定义task对象，协程对象注册到task对象。这种是不用借助loop定义的方式，即使我们还没有声明 loop，也可以提前定义好 task 对象
task = asyncio.ensure_future(coroutine)
print('Task:', task)
# 4、创建事件循环
loop = asyncio.get_event_loop()
# 5、协程（task任务）注册到事件循环 loop 中，然后启动
loop.run_until_complete(task)
print('Task:', task)
print('After calling loop')

# 另外，我们也可以为某个 task 绑定一个回调方法。比如，我们来看下面的例子：
#
import asyncio
import requests
# 1、async定义方法
# 这里我们定义了一个 request 方法，请求了百度，获取其状态码，但是这个方法里面我们没有任何 print 语句。
async def request():
    url = 'https://www.baidu.com'
    status = requests.get(url)
    return status

# 随后我们定义了一个 callback 方法，这个方法接收一个参数，是 task 对象，然后调用 print 方法打印了 task 对象的结果。
# 这样我们就定义好了一个 coroutine 对象和一个回调方法。
# 我们现在希望的效果是，当 coroutine 对象执行完毕之后，就去执行声明的 callback 方法。
#
# 那么它们两者怎样关联起来呢？很简单，只需要调用 add_done_callback 方法即可。
# 我们将 callback 方法传递给封装好的 task 对象，这样当 task 执行完毕之后，就可以调用 callback 方法了。
# 同时 task 对象还会作为参数传递给 callback 方法，调用 task 对象的 result 方法就可以获取返回结果了。
def callback(task):
    print('Status:', task.result())
# 2、调用async定义的方法，实际上没有调用，返回一个协程对象
coroutine = request()
# 3、根据协程对象定义task对象
task = asyncio.ensure_future(coroutine)
# 4、
task.add_done_callback(callback)
print('Task:', task)

loop = asyncio.get_event_loop()
loop.run_until_complete(task)
print('Task:', task)

# 实际上不用回调方法，直接在 task 运行完毕之后，也可以直接调用 result 方法获取结果，如下所示：

import asyncio
import requests

async def request():
    url = 'https://www.baidu.com'
    status = requests.get(url)
    return status

coroutine = request()
task = asyncio.ensure_future(coroutine)
print('Task:', task)

loop = asyncio.get_event_loop()
loop.run_until_complete(task)
print('Task:', task)
print('Task Result:', task.result())
# 运行结果是一样的：
#
# Task: <Task pending coro=<request() running at demo.py:4>>
# Task: <Task finished coro=<request() done, defined at demo.py:4> result=<Response [200]>>
# Task Result: <Response [200]>
#
# 7. 多任务协程
# 上面的例子我们只执行了一次请求，如果想执行多次请求，应该怎么办呢？我们可以定义一个 task 列表，然后使用 asyncio 的 wait 方法即可执行。看下面的例子：

import asyncio
import requests

async def request():
    url = 'https://www.baidu.com'
    status = requests.get(url)
    return status

tasks = [asyncio.ensure_future(request()) for _ in range(5)]
print('Tasks:', tasks)

loop = asyncio.get_event_loop()
loop.run_until_complete(asyncio.wait(tasks))

for task in tasks:
    print('Task Result:', task.result())
# 这里我们使用一个 for 循环创建了 5 个 task，组成了一个列表，然后把这个列表首先传递给了 asyncio 的 wait 方法，
# 再将其注册到时间循环中，就可以发起 5 个任务了。最后，我们再将任务的运行结果输出出来，具体如下：
#
# Tasks: [<Task pending coro=<request() running at demo.py:5>>, <Task pending coro=<request() running at demo.py:5>>, <Task pending coro=<request() running at demo.py:5>>, <Task pending coro=<request() running at demo.py:5>>, <Task pending coro=<request() running at demo.py:5>>]
# Task Result: <Response [200]>
# Task Result: <Response [200]>
# Task Result: <Response [200]>
# Task Result: <Response [200]>
# Task Result: <Response [200]>
# 可以看到，5 个任务被顺次执行了，并得到了运行结果。

# 8. 协程实现
# 前面说了这么一通，又是 async，又是 coroutine，又是 task，又是 callback，但似乎并没有看出协程的优势？反而写法上更加奇怪和麻烦了。
# 别急，上面的案例只是为后面的使用作铺垫。接下来，我们正式来看下协程在解决 IO 密集型任务上有怎样的优势。
#
# 在上面的代码中，我们用一个网络请求作为示例，这就是一个耗时等待操作，因为我们请求网页之后需要等待页面响应并返回结果。
# 耗时等待操作一般都是 IO 操作，比如文件读取、网络请求等。
# 协程对于处理这种操作是有很大优势的，当遇到需要等待的情况时，程序可以暂时挂起，转而去执行其他操作，从而避免一直等待一个程序而耗费过多的时间，充分利用资源。
#
# 为了表现出协程的优势，我们还是以本节开头介绍的网站 https://httpbin.org/delay/5 为例，因为该网站响应比较慢，
# 所以我们可以通过爬取时间来直观感受到爬取速度的提升。
#
# 为了让大家更好地理解协程的正确使用方法，这里我们先来看看大家使用协程时常犯的错误，后面再给出正确的例子来对比一下。
#
# 首先，我们还是拿之前的 requests 库来进行网页请求，接下来再重新使用上面的方法请求一遍：

import asyncio
import requests
import time

start = time.time()

async def request():
    url = 'https://httpbin.org/delay/5'
    print('Waiting for', url)
    response = requests.get(url)
    print('Get response from', url, 'response', response)

tasks = [asyncio.ensure_future(request()) for _ in range(10)]
loop = asyncio.get_event_loop()
loop.run_until_complete(asyncio.wait(tasks))

end = time.time()
print('Cost time:', end - start)
# 这里我们还是创建了 10 个 task，然后将 task 列表传给 wait 方法并注册到时间循环中执行。
#
# 运行结果如下：
#
# Waiting for https://httpbin.org/delay/5
# Get response from https://httpbin.org/delay/5 response <Response [200]>
# Waiting for https://httpbin.org/delay/5
# ...
# Get response from https://httpbin.org/delay/5 response <Response [200]>
# Waiting for https://httpbin.org/delay/5
# Get response from https://httpbin.org/delay/5 response <Response [200]>
# Waiting for https://httpbin.org/delay/5
# Get response from https://httpbin.org/delay/5 response <Response [200]>
# Cost time: 66.64284420013428
# 可以发现，这和正常的请求并没有什么区别，依然还是顺次执行的，耗时 66 秒，平均一个请求耗时 6.6 秒，说好的异步处理呢？
#
# 其实，要实现异步处理，我们得先要有挂起的操作，当一个任务需要等待 IO 结果的时候，可以挂起当前任务，转而去执行其他任务，这样我们才能充分利用好资源。
# 上面的方法都是一本正经地串行走下来，连个挂起都没有，怎么可能实现异步？想太多了。
#
# 要实现异步，接下来我们再了解一下 await 的用法，它可以将耗时等待的操作挂起，让出控制权。
# 当协程执行的时候遇到 await，时间循环就会将本协程挂起，转而去执行别的协程，直到其他协程挂起或执行完毕。

# 所以，我们可能会将代码中的 request 方法改成如下的样子：

async def request():
    url = 'https://httpbin.org/delay/5'
    print('Waiting for', url)
    response = await requests.get(url)
    print('Get response from', url, 'response', response)
# 仅仅是在 requests 前面加了一个关键字 await，然而此时执行代码，会得到如下报错：

# Waiting for https://httpbin.org/delay/5
# Waiting for https://httpbin.org/delay/5
# Waiting for https://httpbin.org/delay/5
# Waiting for https://httpbin.org/delay/5
# ...
# Task exception was never retrieved
# future: <Task finished coro=<request() done, defined at demo.py:8> exception=TypeError("object Response can't be used in 'await' expression")>
# Traceback (most recent call last):
# File "demo.py", line 11, in request
# response = await requests.get(url)
# TypeError: object Response can't be used in 'await' expression
# 这次它遇到 await 方法确实挂起了，也等待了，但是最后却报了这个错误。
# 这个错误的意思是 requests 返回的 Response 对象不能和 await 一起使用，为什么呢？
# 因为根据官方文档说明，await 后面的对象必须是如下格式之一（具体可以参见 https://www.python.org/dev/peps/pep-0492/#await-expression）：
#
# 一个原生 coroutine 对象；
# 一个由 types.coroutine 修饰的生成器，这个生成器可以返回 coroutine 对象；
# 一个包含 __await__ 方法的对象返回的一个迭代器。
# reqeusts 返回的 Response 对象不符合上面任一条件，因此就会报上面的错误了。

# reqeusts 返回的 Response 对象不符合上面任一条件，因此就会报上面的错误了。
#
# 有的读者可能已经发现了，既然 await 后面可以跟一个 coroutine 对象，那么我用 async 把请求的方法改成 coroutine 对象不就可以了吗？所以就改写成如下的样子：

import asyncio
import requests
import time

start = time.time()

async def get(url):
    return requests.get(url)

async def request():
    url = 'https://httpbin.org/delay/5'
    print('Waiting for', url)
    response = await get(url)
    print('Get response from', url, 'response', response)

tasks = [asyncio.ensure_future(request()) for _ in range(10)]
loop = asyncio.get_event_loop()
loop.run_until_complete(asyncio.wait(tasks))

end = time.time()
print('Cost time:', end - start)
# 这里我们将请求页面的方法独立出来，并用 async 修饰，这样就得到了一个 coroutine 对象。运行一下看看：
#
# Waiting for https://httpbin.org/delay/5
# Get response fromhttps://httpbin.org/delay/5 response <Response [200]>
# Waiting for https://httpbin.org/delay/5
# Get response from https://httpbin.org/delay/5 response <Response [200]>
# Waiting for https://httpbin.org/delay/5
# ...
# Get response from https://httpbin.org/delay/5 response <Response [200]>
# Waiting for https://httpbin.org/delay/5
# Get response from https://httpbin.org/delay/5 response <Response [200]>
# Waiting for https://httpbin.org/delay/5
# Get response from https://httpbin.org/delay/5 response <Response [200]>
# Cost time: 65.394437756259273
# 还是不行，它还不是异步执行的，也就是说我们仅仅将涉及 IO 操作的代码封装到 async 修饰的方法里面是不可行的。
# 我们必须要使用支持异步操作的请求方式才可以实现真正的异步，所以这里就需要 aiohttp 派上用场了。

# 9. 使用 aiohttp
# aiohttp 是一个支持异步请求的库，配合使用它和 asyncio，我们可以非常方便地实现异步请求操作。我们使用 pip3 安装即可：
#
# pip3 install aiohttp
# 具体的安装方法可以参考：https://setup.scrape.center/aiohttp。
#
# aiohttp 的官方文档链接为 https://aiohttp.readthedocs.io/，它分为两部分，一部分是 Client，一部分是 Server，详细的内容可以参考官方文档。
#
# 下面我们将 aiohttp 用上来，将代码改成如下样子：


# aiohttp 是一个支持异步请求的库，配合使用它和 asyncio，我们可以非常方便地实现异步请求操作。
# 我们使用 pip3 安装即可：
#
# # python3 -m pip install aiohttp
# 具体的安装方法可以参考：https://setup.scrape.center/aiohttp。
#
# aiohttp 的官方文档链接为 https://aiohttp.readthedocs.io/，它分为两部分，一部分是 Client，一部分是 Server，详细的内容可以参考官方文档。
#
# 下面我们将 aiohttp 用上来，将代码改成如下样子：

import asyncio
import aiohttp
import time

start = time.time()
# 在代码里面，我们使用了 await，后面跟了 get 方法。
# 在执行这 10 个协程的时候，如果遇到了 await，就会将当前协程挂起，转而去执行其他协程，
# 直到其他协程也挂起或执行完毕，再执行下一个协程。
#
# 开始运行时，时间循环会运行第一个 task。针对第一个 task 来说，当执行到第一个 await 跟着的 get 方法时，
# 它被挂起，但这个 get 方法第一步的执行是非阻塞的，挂起之后立马被唤醒，所以立即又进入执行，
# 创建了 ClientSession 对象，接着遇到了第二个 await，调用了 session.get 请求方法，然后就被挂起了。
# 由于请求需要耗时很久，所以一直没有被唤醒，好在第一个 task 被挂起了，那么接下来该怎么办呢？
# 事件循环会寻找当前未被挂起的协程继续执行，于是就转而执行第二个 task 了，也是一样的流程操作，
# 直到执行了第十个 task 的 session.get 方法之后，全部的 task 都被挂起了。
# 所有 task 都已经处于挂起状态，那咋办？只好等待了。
# 5 秒之后，几个请求几乎同时都有了响应，然后几个 task 也被唤醒接着执行，输出请求结果，最后总耗时 6 秒！
async def get(url):
    session = aiohttp.ClientSession()
    response = await session.get(url)
    await response.text()
    await session.close()
    return response

async def request():
    url = 'https://httpbin.org/delay/5'
    print('Waiting for', url)
    response = await get(url)
    print('Get response from', url, 'response', response)

tasks = [asyncio.ensure_future(request()) for _ in range(10)]
loop = asyncio.get_event_loop()
loop.run_until_complete(asyncio.wait(tasks))

end = time.time()
print('Cost time:', end - start)
# 这里我们将请求库由 requests 改成了 aiohttp，通过 aiohttp 的 ClientSession 类的 get 方法进行请求，结果如下：
#
# Waiting for https://httpbin.org/delay/5
# Waiting for https://httpbin.org/delay/5
# Waiting for https://httpbin.org/delay/5
# Waiting for https://httpbin.org/delay/5
# ...
# Get response from https://httpbin.org/delay/5 response <ClientResponse(https://httpbin.org/delay/5) [200 OK]>
# <CIMultiDictProxy('Date': 'Sun, 09 Aug 2020 14:30:22 GMT', 'Content-Type': 'application/json', 'Content-Length': '360', 'Connection': 'keep-alive', 'Server': 'gunicorn/19.9.0', 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Credentials': 'true')>
#
# ...
# Get response from https://httpbin.org/delay/5 response <ClientResponse(https://httpbin.org/delay/5) [200 OK]>
# <CIMultiDictProxy('Date': 'Sun, 09 Aug 2020 14:30:22 GMT', 'Content-Type': 'application/json', 'Content-Length': '360', 'Connection': 'keep-alive', 'Server': 'gunicorn/19.9.0', 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Credentials': 'true')>
# Cost time: 6.033240079879761
# 成功了！我们发现这次请求的耗时由 51 秒直接变成了 6 秒，耗费时间减少了非常多。

# 怎么样？这就是异步操作的便捷之处，当遇到阻塞式操作时，任务被挂起，程序接着去执行其他任务，
# 而不是傻傻地等着，这样可以充分利用 CPU 时间，而不必把时间浪费在等待 IO 上。
#
# 有人会说，既然这样的话，在上面的例子中，在发出网络请求后，既然接下来的 5 秒都是在等待的，
# 在 5 秒之内，CPU 可以处理的 task 数量远不止这些，那么岂不是我们放 10 个、20 个、50 个、100 个、1000 个 task 一起执行，
# 最后得到所有结果的耗时不都是差不多的吗？因为这几个任务被挂起后都是一起等待的。

# 理论来说，确实是这样的，不过有个前提，那就是服务器在同一时刻接受无限次请求都能保证正常返回结果，也就是服务器无限抗压。
# 另外，还要忽略 IO 传输时延，确实可以做到无限 task 一起执行且在预想时间内得到结果。但由于不同服务器处理的实现机制不同，
# 可能某些服务器并不能承受这么高的并发，因此响应速度也会减慢。
#
# 这里我们以百度为例，测试一下并发数量为 1、3、5、10...500 的情况下的耗时情况，代码如下：

import asyncio
import aiohttp
import time


def test(number):
    start = time.time()

    async def get(url):
        session = aiohttp.ClientSession()
        response = await session.get(url)
        await response.text()
        await session.close()
        return response

    async def request():
        url = 'https://www.baidu.com/'
        await get(url)

    tasks = [asyncio.ensure_future(request()) for _ in range(number)]
    loop = asyncio.get_event_loop()
    loop.run_until_complete(asyncio.wait(tasks))

    end = time.time()
    print('Number:', number, 'Cost time:', end - start)

for number in [1, 3, 5, 10, 15, 30, 50, 75, 100, 200, 500]:
    test(number)

# 运行结果如下：
#
# Number: 1 Cost time: 0.05885505676269531
# Number: 3 Cost time: 0.05773782730102539
# Number: 5 Cost time: 0.05768704414367676
# Number: 10 Cost time: 0.15174412727355957
# Number: 15 Cost time: 0.09603095054626465
# Number: 30 Cost time: 0.17843103408813477
# Number: 50 Cost time: 0.3741800785064697
# Number: 75 Cost time: 0.2894289493560791
# Number: 100 Cost time: 0.6185381412506104
# Number: 200 Cost time: 1.0894129276275635
# Number: 500 Cost time: 1.8213098049163818
# 可以看到，即使我们增加了并发数量，但在服务器能承受高并发的前提下，其爬取速度几乎不太受影响。
#
# 综上所述，使用了异步请求之后，我们几乎可以在相同的时间内实现成百上千倍次的网络请求，把这个运用在爬虫中，速度提升可谓是非常可观了。

# 10. 总结
# 以上便是 Python 中协程的基本原理和用法，在后面一节中我们会详细介绍 aiohttp 的用法和爬取实战，实现快速高并发的爬取。
#
# 本节代码：https://github.com/Python3WebSpider/AsyncTest
#
# 另外，我的新书《Python3网络爬虫开发实战（第二版）》已经正式上市了！书中详细介绍了零基础用 Python 开发爬虫的各方面知识，同时相比第一版新增了 JavaScript 逆向、Android 逆向、异步爬虫、深度学习、Kubernetes 相关内容，‍同时本书已经获得 Python 之父 Guido 的推荐，感兴趣的可以点击下方链接进去了解一下：
#
# Python3网络爬虫开发实战 第2版
#
# Python3网络爬虫开发实战 第2版（图灵出品）
# 京东
# ¥104.10
# 去购买
# ​
# 非常感谢你的阅读，更多精彩内容，请关注我的公众号「进击的 Coder」和「崔庆才丨静觅」。







