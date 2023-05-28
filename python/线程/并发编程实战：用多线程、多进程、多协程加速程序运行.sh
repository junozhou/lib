#http://t.zoukankan.com/zhangguosheng1121-p-15460216.html

#https://www.cnblogs.com/zhangguosheng1121/p/15460216.html

很详细


一、为什么要引入并发编程
场景一：一个网络爬虫，按顺序爬花了一个小时，采用并发下载减少到20分钟

场景二：一个APP应用，优化前每次打开页面需要3秒，采用异步编发提升到每次200毫秒

引入并发，就是为了提升程序运行速度

二、有哪些程序提速的方法


三、Python对并发编程的支持
①多线程：threading，利用CPU和IO可以同时执行的原理，让CPU不会干巴巴等待IO完成

②多进程：multiprocessing，利用多核CPU的能力，真正的并行执行任务

③异步IO：asyncio，在单线程利用CPU和IO同时执行的原理，实现函数异步执行

④使用Lock对资源加锁，防止冲突访问

⑤使用Queue实现不同线程/进程之间的数据通信，实现生产者-消费者模式

⑥使用线程池Pool/进程池Pool，简化线程/进程的任务提交、等待结束、获取结果使用subprocess启动外部程序的进程，并进行输入输出交互


四、Python并发编程的三种方式
①多线程（Thread）

②多进程（Process）

③多协程（Coroutine）