import aiohttp
import asyncio
import async_timeout
from flask import Flask
import logging

from datetime import datetime

logger = logging.getLogger("name")
class MutilSerSync(object):
    def __init__(self):
        self.semaphore = asyncio.Semaphore(10)  # 信号量，有时候需要控制协程数，防止爬的过快被反爬
        self.header = {
            "Accept-Encoding": "gzip",    # 使用gzip压缩传输数据让访问更快
            'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36'
        }
        # self.encoding = 'utf-8'
    async def crequest(self, url):
        try:
            # async with asyncio.Semaphore(10):# 设置最大信号量，有时候需要控制协程数，防止爬的过快被反爬
            session = aiohttp.ClientSession(headers=self.header, connector=aiohttp.TCPConnector(ssl=False))
            response = await session.get(url)
            # result = await response.text(encoding=self.encoding)
            result = await response.json()
            await session.close()
            return result
        except (aiohttp.ClientConnectorError, aiohttp.ClientError, aiohttp.ClientConnectionError,
                TimeoutError,AttributeError) \
                as e:
            logger.error('error: {}'.format(e))
            return None

    async def ncrequest(self, url):
        try:
            async with self.semaphore:# 设置最大信号量，有时候需要控制协程数，防止爬的过快被反爬
                async with aiohttp.ClientSession(headers=self.header, connector=aiohttp.TCPConnector(ssl=False)) as \
                        session:
                    async with session.get(url) as response:
                        # result = await response.text(encoding=self.encoding)
                        result = await response.json()
                        print(result)
                        await session.close()
                        return result
        except (aiohttp.ClientConnectorError, aiohttp.ClientError, aiohttp.ClientConnectionError,
                TimeoutError,AttributeError) \
                as e:
            logger.error('error: {}'.format(e))
            return None


    async def crequest_index(self, env, service,ima_tag, username,res):
        url = f"http://qa.test1.com/api/nrestart?env={env.strip()}&service=" \
              f"{service.strip()}&branch=&image=&image_tag={ima_tag}&user={username.strip()}"
        logger.info(f"等待响应结果,{url}")
        text = await self.ncrequest(url)
        await self.parse(url,service,text,res)

    async def parse(self,url, service, text,res):
        if text:
            if service not in text['msg']:
                text['msg'] = f"{service}-{text['msg']}"
            res.append(text)

        logger.info(f"得到:{url},返回结果:{text}")

    # """异步任务管理器"""
    async def taskManager(self,service_status,ser_list,image_tags,renv,username,res):

        tasks = []
        for i in service_status:
            ima_tag = i["image"][i["image"].rfind(":")+1:]
            # 服务列表、镜像标签都不选，同全量重启，即把源环境中的镜像在目标环境部署
            if not ser_list and not image_tags:
                task = asyncio.ensure_future(self.crequest_index(renv, i['service'],ima_tag, username,res))
                tasks.append(task)
            # 服务列表、镜像标签同时选，仅根据所选服务进行同步镜像
            elif ser_list:
                # 服务可以多选
                if i['service'] in ser_list:
                    task = asyncio.ensure_future(self.crequest_index(renv, i['service'],ima_tag, username,res))
                    tasks.append(task)
            # 仅选镜像标签
            elif image_tags:
                # 镜像标签可多选
                if ima_tag in image_tags:
                    task = asyncio.ensure_future(self.crequest_index(renv, i['service'],ima_tag, username,res))
                    tasks.append(task)
        await asyncio.gather(*tasks)



    def nrun(self,service_status,ser_list,image_tags,renv,username,res):
        start = datetime.now()
        # new_loop = asyncio.new_event_loop()
        # asyncio.set_event_loop(new_loop)
        try:
            loop = asyncio.get_event_loop()
        except RuntimeError as ex:
            print(ex)
            loop = asyncio.new_event_loop()
        try:
            loop.run_until_complete(self.taskManager(service_status,ser_list,image_tags,renv,username,res))
        finally:
            loop.close()

        # loop = asyncio.get_event_loop()
        # loop.run_until_complete(self.taskManager(service_status,ser_list,image_tags,renv,username,res))
        # loop.close()
        delta = (datetime.now() - start).total_seconds()
        logger.info("耗时："+str(delta))
    async def run(self,service_status,ser_list,image_tags,renv,username,res):

        start = datetime.now()
        tasks = []
        for i in service_status:
            ima_tag = i["image"][i["image"].rfind(":")+1:]
            # 服务列表、镜像标签都不选，同全量重启，即把源环境中的镜像在目标环境部署
            if not ser_list and not image_tags:
                task = asyncio.create_task(self.crequest_index(renv, i['service'],ima_tag, username,res))
                tasks.append(task)
            # 服务列表、镜像标签同时选，仅根据所选服务进行同步镜像
            elif ser_list:
                # 服务可以多选
                if i['service'] in ser_list:
                    task = asyncio.create_task(self.crequest_index(renv, i['service'],ima_tag, username,res))
                    tasks.append(task)
            # 仅选镜像标签
            elif image_tags:
                # 镜像标签可多选
                if ima_tag in image_tags:
                    task = asyncio.create_task(self.crequest_index(renv, i['service'],ima_tag, username,res))
                    tasks.append(task)
        # loop = asyncio.get_event_loop()
        tasks = await asyncio.gather(*tasks)
        # loop.run_until_complete(tasks)
        delta = (datetime.now() - start).total_seconds()
        logger.info("耗时："+str(delta))
        return tasks


async def fetch(url):
    async with aiohttp.ClientSession(connector=aiohttp.TCPConnector(ssl=False)) as session:
        async with session.get(url) as response:
            return await response.text()

def fight(responses):
    return "done"


# async def run():
#     task_list = []
#     for i in range(5):
#         i = "https://www.jianshu.com/p/6872bf356af7"
#         task = asyncio.create_task(fetch(i))
#         task_list.append(task)
#     results = await asyncio.gather(*task_list)
#     for result in results:
#         print((f" 得到执行结果 {result}"))

# c-
# c-
# b-
# s-
# c-
# test1
# o-
# p-
# us-
# test2
# c- m- b-
# test3
def a():

    import requests
    url = "http://qa.test1.com/api/nstatus?env=test1-t4"
    response = requests.get(url)
    result = response.json()
    renv = "test1-t8"
    ser_list = "test2-biz-auto-operation,test1-biz-sys,test1-biz-order,test1-biz-ccb,test1-bigdata-server," \
               "test1-ecds-adapter,test1-render-server,test1-biz-org,test1-biz-voucher,test1-biz-scg," \
               "test1-biz-auth,test1-auth-server".split(",")
    username = "test3"
    image_tags = ""
    res = []

    try:
        loop = asyncio.get_event_loop()
    except RuntimeError as er:
        print(er.args[0], 'create a new EventLoop')
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)
    spider = MutilSerSync()
    loop.run_until_complete(spider.run(result,ser_list,image_tags,renv,username,res))
    print("res")
    print(res)
    return str(res)

if __name__ == "__main__":
    a()