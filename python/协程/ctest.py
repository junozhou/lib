# import asyncio
# import aiohttp
# import time
#
# start = time.time()
#
# async def get(url):
#     session = aiohttp.ClientSession(connector=aiohttp.TCPConnector(limit=64,verify_ssl=False))
#     response = await session.get(url)
#     await response.text()
#     await session.close()
#     return response
#
# async def request():
#     url = 'https://httpbin.org/delay/5'
#     print('Waiting for', url)
#     response = await get(url)
#     print('Get response from', url, 'response', response)
#
# tasks = [asyncio.ensure_future(request()) for _ in range(10)]
# loop = asyncio.get_event_loop()
# loop.run_until_complete(asyncio.wait(tasks))
#
# end = time.time()
# print('Cost time:', end - start)



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
        print('Waiting for', url)
        response = await get(url)
        print('Get response from', url, 'response', response)

    tasks = [asyncio.ensure_future(request()) for _ in range(number)]
    loop = asyncio.get_event_loop()
    loop.run_until_complete(asyncio.wait(tasks))

    end = time.time()
    print('Number:', number, 'Cost time:', end - start)

for number in [1, 3]:
    test(number)