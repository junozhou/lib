# 2，爬虫时间阻塞主要在对服务器发送请求和接收请求，对抓取的函数我们用异步，那么支持异步的抓取的模块，用aiohttp。

import aiohttp
#headers信息，一般包含User-Agent就可以
header = {
    "Accept-Encoding": "gzip",    # 使用gzip压缩传输数据让访问更快
    'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36'
}
url = "https://baidu.com"
timeout = aiohttp.ClientTimeout(total=15)  # 超时
# 此处设置超时，则表示所以任务都在这个时间完成
session = aiohttp.ClientSession(headers=header, connector=aiohttp.TCPConnector(ssl=False),timeout=timeout)
# session.get(url,timeout=timeout) 设置超时表示单个请求超时
response = await session.get(url,timeout=timeout)
# result = await response.text(encoding=self.encoding)
result = await response.json()
await session.close()


# 博客里的实例：https://blog.csdn.net/cui_yonghua/article/details/106840662
# 使用asyncio+aiohttp爬取数据并拼装返回的数据
# -*- coding:utf-8 -*-
import json
import asyncio
from aiohttp import ClientSession
from aiohttp.client_exceptions import ClientConnectionError, ClientError, ClientConnectorError
from lxml import etree


class MyTest(object):
    """asyncio+aiohttp实现的爬虫如何查看返回的数据"""

    def __init__(self):
        self.custom_headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36'
        }
        self.Semaphore = asyncio.Semaphore(10)
        self.encoding = 'utf-8'
        self.url = ''

    async def Request(self):
        try:
            async with self.Semaphore:
                async with ClientSession(headers=self.custom_headers) as session:
                    async with session.get(self.url) as resp:
                        if resp.status in [200, 302, 301]:
                            text = await resp.text(encoding=self.encoding)
                            # json = await resp.json()
                            content = await resp.read()
                            stream_content = await resp.content.read()
                            resp = {"code": resp.status, "text": text,
                                    "content": content, "url": resp.url, "stream_content": stream_content,
                                    "headers": resp.headers, "cookie": resp.cookies}
                            self.parse(response=resp)
                            return resp
        except (ClientConnectorError, ClientError, ClientConnectionError, TimeoutError, AttributeError) as e:
            print('error: {}'.format(e))
            return None

    def parse(self, response):
        if response:
            selector = etree.HTML(response['text'])
            content = selector.xpath('//span[@id="sentence"]/text()')[0]
            print(content)

    def run(self):
        loop = asyncio.get_event_loop()
        tasks = [self.Request() for i in range(3)]
        result = loop.run_until_complete((asyncio.wait(tasks)))
        # for i in result[0]:
        #     print(i.result())
        loop.close()


if __name__ == '__main__':
    my = MyTest()
    my.url = 'http://www.nows.fun/'
    my.run()
