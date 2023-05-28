#!/usr/bin/python3

import queue
import threading
import time

exitFlag = 0

class myThread (threading.Thread):
    def __init__(self, threadID, name, q):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.q = q
    def run(self):
        print ("开启线程：" + self.name)
        process_data(self.name, self.q)
        print ("退出线程：" + self.name)

def process_data(threadName, q):
    while not exitFlag:
        queueLock.acquire()
        if not workQueue.empty():
            data = q.get()
            queueLock.release()
            print ("%s processing %s" % (threadName, data))
        else:
            queueLock.release()
        time.sleep(1)

threadList = ["Thread-1", "Thread-2", "Thread-3"]
nameList = ["One", "Two", "Three", "Four", "Five"]
queueLock = threading.Lock()
workQueue = queue.Queue(10)
threads = []
threadID = 1

# 创建新线程
for tName in threadList:
    thread = myThread(threadID, tName, workQueue)
    thread.start()
    threads.append(thread)
    threadID += 1

# 填充队列
queueLock.acquire()
for word in nameList:
    workQueue.put(word)
queueLock.release()

# 等待队列清空
while not workQueue.empty():
    pass

# 通知线程是时候退出
exitFlag = 1

# 等待所有线程完成
for t in threads:
    t.join()
print ("退出主线程")


#网上查到的最常见的一种方式，但是实际应用中并不适合
# 如，同时发起两个请求，A请求需要的时间长，B请求需要的时间短，在B完成之后，exitFlag被更新，导致主线程退出
# 所以，根据以上的样例

# 去掉吗exitFlag
# 把队列填充置于创建线程之前
# 去掉等待队列清空的代码，直接等待线程结束
# 线程类可以像如下写
class codediffThread(threading.Thread):

    def __init__(self, func, *args, **kwargs):
        super(codediffThread, self).__init__()
        self.result = None
        self.func = func
        self.args = args
        self.kwargs = kwargs

    def run(self):
        print(f"{self.args[1]},线程开启")
        self.result = self.func(*self.args, **self.kwargs)
        print(f"{self.args[1]},线程退出")

    def get_result(self):
        return self.result


# 一个请求最多创建5个线程处理问题
def do_req_fa(thd_name,q,q_lock,sub_ret_str):
    while True:
        q_lock.acquire()
        if not q.empty():
            ser = q.get()
            q_lock.release()
            res = do_req(ser)
            q_lock.acquire()
            sub_ret_str.append(res)
            q_lock.release()
        else:
            q_lock.release()
            break

def do_req(ser):
    print(ser)
    res = ""
    return res

def http_req():
    nameList = ["a","b","c","d","e","f","s"]
    thd_name_list = ["thd-1","thd-2","thd-3","thd-4","thd-5"]
    thds = []
    sub_ret_str = []
    # 创建锁
    q_lock= threading.Lock
    q = queue.Queue(len(nameList)+1)
    # 填充队列
    q_lock.acquire()
    for i in nameList:
        q.put(i)
    q_lock.release()

    # 创建线程
    for thd_name in thd_name_list:
        thd = codediffThread(func=do_req_fa,args=[thd_name,q,q_lock,sub_ret_str])
        thd.start()
        thds.append(thd)

    # 等待所以线程退出
    for i in thds:
        i.join()