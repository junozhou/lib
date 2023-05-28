#!/usr/bin/python
# -*- coding: UTF-8 -*-


import time
import threading
from queue import Queue


def do_req():
    res = "ddd"
    return res
class Worker(threading.Thread):
    def __init__(self, selfManager, name):
        threading.Thread.__init__(self)
        self.work_queue = selfManager.work_queue
        self.q_lock = selfManager.queue_lock
        self.res = selfManager.res
        self.name = name
        self.start()


    def run(self):
        while True:
            try:
                self.q_lock.acquire()
                if not self.work_queue.empty():
                    # print("thread-%s: queue is empty, waiting for task." % self.name)
                    text = self.work_queue.get(block=True)
                    self.q_lock.release()
                # todo Anything
                    print("%s thread-%s: 任务完成: %s" % (str(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())),
                                                self.getName(), str(text)))

                    self.q_lock.acquire()
                    self.res.append(do_req())
                    self.q_lock.release()
                    print(self.res)
                    # time.sleep(3)
                    # self.work_queue.task_done()
                else:
                    self.q_lock.release()
                    break
            except Exception as e:
                print("thread-%s: 任务失败: %s" % (self.getName(), str(e)))
                break


class WorkManager:
    def __init__(self, thread_num,task_list):
        self.work_queue = Queue()  # 队列对象
        self.queue_lock = threading.Lock()  # 锁
        self.res = []  # 锁
        self.threads = []
        self._init_queue(task_list)
        self._init_thread_pool(thread_num)


    def _init_queue(self,task_list):
        print("初始化队列")
        self.queue_lock.acquire()
        for i in task_list:
            self.add_job(i)
        self.queue_lock.release()
    def _init_thread_pool(self, thread_num):
        """初始化线程"""
        print("初始化线程")
        for name in range(thread_num):
            self.threads.append(Worker(self, str(name)))


    def add_job(self, job):
        """初始化工作队列"""
        self.work_queue.put(job)


if __name__ == '__main__':
    # queue_lock = threading.Lock()  # 锁
    task_list = [i for i in range(0,11)]
    print(task_list)
    work_manager = WorkManager(5,task_list)
    # for i in range(100):
    #     work_manager.add_job(i)

