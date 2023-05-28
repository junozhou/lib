1、TCPConnector 链接池
import asyncio
from aiohttp import ClientSession, TCPConnector
async def aiohttp_get():
    url = 'url'
    conn = TCPConnector(limit=10)  # 限制同时链接数，连接默认是100，limit=0 无限制
    async with ClientSession(connector=conn) as session:
        async with session.get(url) as response:
            html = await response.text()
            return html

2、Semaphore 信号量
async def asyncSpider(sem, url):
    """异步任务"""
    async with sem:
        print('Getting data on url',url)
        async with ClientSession() as session:
            async with session.get(url) as response:
                html = await response.text()
                return html

async def taskManager():
    """异步任务管理器"""
    tasks = []
    sem = asyncio.Semaphore(10) # 控制并发数
    for url in url_list:
        task = asyncio.create_task(asyncSpider(sem, url))
        task.add_done_callback(parseHTML)
        tasks.append(task)
    await asyncio.gather(*tasks)

def main():
    print('Task start! It is working...')
    loop = asyncio.get_event_loop()
    loop.run_until_complete(taskManager())
    print('Finished!')
————————————————
版权声明：本文为CSDN博主「JOSON.」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/joson1234567890/article/details/105762195