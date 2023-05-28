# flask+协程成功的案例
# 来自：https://blog.csdn.net/weixin_43632687/article/details/122045927?spm=1001.2101.3001.6650.4&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-4-122045927-blog-125675950.pc_relevant_default&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-4-122045927-blog-125675950.pc_relevant_default&utm_relevant_index=6
# 以下代码来自此博客，可以通过此模版进行中修改成自己需要的
# 如同目录下的main.py就是根据自己的需求改的
# https://blog.51cto.com/u_15127518/2685377
# 此博客中介绍的内容也收益良多

import aiohttp
import asyncio
import async_timeout
from flask import Flask

loop = asyncio.get_event_loop()
app = Flask(__name__)

async def fetch(url):
    async with aiohttp.ClientSession(connector=aiohttp.TCPConnector(ssl=False)) as session, async_timeout.timeout(100):
        async with session.get(url) as response:
            return await response.text()

def fight(responses):
    return "done"

@app.route("/")
def index():
    # perform multiple async requests concurrently
    try:
        loop = asyncio.get_event_loop()
    except RuntimeError as er:
        print(er.args[0], 'create a new EventLoop')
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)

    responses = loop.run_until_complete(asyncio.gather(
        fetch("https://baidu.com")
    ))

    # do something with the results
    return fight(responses)

if __name__ == "__main__":
    app.run(debug=False, use_reloader=False)
