from flask import Blueprint,request, jsonify,abort,make_response
from flask import make_response
import asyncio
import time
import aiohttp

my_blueprint = Blueprint('my_blueprint', __name__)

@my_blueprint.route('/',methods=['GET'])
def home():
    #code block
    async def download_site(session, url):
        async with session.get(url) as response:
            print("Read {0} from {1}".format(response.content_length, url))


    async def download_all_sites(sites):
        async with aiohttp.ClientSession() as session:
            tasks = []
            for url in sites:
                task = asyncio.ensure_future(download_site(session, url))
                tasks.append(task)
            await asyncio.gather(*tasks, return_exceptions=True)

    sites = ["https://www.jython.org","http://olympus.realpython.org/dice"]*20
    start_time = time.time()
    asyncio.get_event_loop().run_until_complete(download_all_sites(sites))
    duration = time.time() - start_time
    return jsonify({"status":f"Downloaded {len(sites)} sites in {duration} seconds"})
    #end of code block
