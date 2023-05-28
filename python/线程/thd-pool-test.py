'''
学习中遇到问题没人解答？小编创建了一个Python学习交流群：711312441
寻找有志同道合的小伙伴，互帮互助,群里还有不错的视频学习教程和PDF电子书！
'''
import socket
import threading
from threading import Thread
import threading
import sys
import time
import random
from queue import Queue

# host = ''
# port = 8888
# s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# s.bind((host, port))
# s.listen(3)

class ThreadPoolManger():
    """线程池管理器"""
    def __init__(self, thread_num):
        # 初始化参数
        self.work_queue = Queue()
        self.thread_num = thread_num
        self.__init_threading_pool(self.thread_num)

    def __init_threading_pool(self, thread_num):
        # 初始化线程池，创建指定数量的线程池
        for i in range(thread_num):
            thread = ThreadManger(self.work_queue)
            thread.start()

    def add_job(self, func, *args):
        # 将任务放入队列，等待线程池阻塞读取，参数是被执行的函数和函数的参数
        self.work_queue.put((func, args))

class ThreadManger(threading.Thread):
    """定义线程类，继承threading.Thread"""
    def __init__(self, work_queue):
        super(ThreadManger, self).__init__()
        self.work_queue = work_queue
        self.daemon = True

    def run(self):
        # 启动线程
        while True:
            target, args = self.work_queue.get()
            print(target,args)
            target(*args)
            self.work_queue.task_done()

# 创建一个有4个线程的线程池
thread_pool = ThreadPoolManger(4)

# 处理http请求，这里简单返回200 hello world
# def handle_request(conn_socket):
#     recv_data = conn_socket.recv(1024)
#     reply = 'HTTP/1.1 200 OK \r\n\r\n'
#     reply += 'hello world'
#     print('thread %s is running ' % threading.current_thread().name)
#     conn_socket.send(reply)
#     conn_socket.close()

def handle_request(req1):
    print("request1--"+req1)

def handle_request2(req2):
    print("request2=="+req2)

# # 循环等待接收客户端请求
# while True:
#     # 阻塞等待请求
#     conn_socket, addr = s.accept()
#     # 一旦有请求了，把socket扔到我们指定处理函数handle_request处理，等待线程池分配线程处理
#     thread_pool.add_job(handle_request, *(conn_socket, ))
#
# s.close()
# 任务list
import queue
queueLock = threading.Lock()
nameList = ["mock-server","biz-ci","mock-server3","biz-ci4","mock-server34","biz-ci1"]
task_queue = queue.Queue(len(nameList)+1)

threads = []
sub_ret_str = []

# 填充队列
queueLock.acquire()
for word in nameList:
    task_queue.put(word)
queueLock.release()
from concurrent.futures import ThreadPoolExecutor
# def ma(queueLock,threadName, q,lser_dic,rser_dic,lplatform_alias,rplatform_alias,sub_ret_str,
#        lplatform_name,rplatform_name,detail_switch,lbranch,rbranch):
def ma():
    with ThreadPoolExecutor(max_workers=4) as e:
        while True:
            # 获取锁，用于线程同步
            queueLock.acquire()
            if not task_queue.empty():
                service = task_queue.get()
                print(service)
                queueLock.release()
                # res = handle_request(service)
                future = e.submit(handle_request, *(service, ))
                print("future.result()")
                print(future.result())
                queueLock.acquire()
                # sub_ret_str.append(res)
                queueLock.release()
            else:
                queueLock.release()
                break


def test():
    print("kk")
    req1 = ":ok"
    thread_pool.add_job(handle_request, *(req1, ))
    req2 = ":not ok"
    thread_pool.add_job(handle_request2, *(req2, ))


if __name__ == "__main__":
    ma()
    # count = 9
    # while count > 0:
    #     test()
    #     count -= 1
    #     time.sleep(3)