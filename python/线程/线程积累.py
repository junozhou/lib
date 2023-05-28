#!/usr/bin/python
# -*- coding: UTF-8 -*-


import time
import threading
from queue import Queue


class Worker(threading.Thread):
    def __init__(self,selfManager,  name,queue_lock):
        threading.Thread.__init__(self)
        self.work_queue = selfManager.work_queue
        self.q_lock = queue_lock
        # self.res = self.res
        self.name = name
        self.start()


    def run(self):
        while True:
            try:
                self.q_lock.acquire()
                if not self.work_queue.empty():
                    # print("thread-%s: queue is empty, waiting for task." % self.name)
                    continue
                    text = self.work_queue.get(block=True)
                    self.q_lock.release()
                    # todo Anything
                    print("%s thread-%s: doing task text: %s" % (str(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())), self.getName(), str(text)))
                    self.q_lock.acquire()
                    self.res.append(do_req())
                    self.q_lock.release()
                    # time.sleep(10)
                # self.work_queue.task_done()
                else:
                    self.q_lock.release()
                    print("队列为空")
                    break
            except Exception as e:
                print("thread-%s: task is error: %s" % (self.getName(), str(e)))
                break

def do_req():
    print("hhhhhok")
    res = "ddd"
    return res

class WorkManager:
    def __init__(self, thread_num,queue_lock):
        self.work_queue = Queue()  # 队列对象
        # self.queue_lock = queue_lock  # 锁
        self.threads = []
        self.res = []
        self._init_thread_pool(thread_num,queue_lock)


    def _init_thread_pool(self, thread_num,queue_lock):
        """初始化线程"""
        print("初始化线程")
        for name in range(thread_num):
            self.threads.append(Worker(self, str(name),queue_lock))


    def add_job(self, job):
        """初始化工作队列"""
        print("初始化工作队列")
        self.work_queue.put(job)

def test():
    queue_lock = threading.Lock()  # 锁
    work_manager = WorkManager(5,queue_lock)
    print("hh")
    queue_lock.acquire()
    for i in range(100):
        work_manager.add_job(i)
    queue_lock.release()


if __name__ == '__main__':

    test()
