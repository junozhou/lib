# https://blog.csdn.net/weixin_43632687/article/details/122045927?spm=1001.2101.3001.6650.4&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-4-122045927-blog-125675950.pc_relevant_default&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-4-122045927-blog-125675950.pc_relevant_default&utm_relevant_index=6
# https://blog.51cto.com/u_15127518/2685377

# spider = MutilSerSync()
#     loop.run_until_complete(spider.run(result,ser_list,image_tags,renv,username,res))

# 上面两行必须挨在一起写，不然会报错，很奇特很偶然发现的，不然一直在坑里爬不出来

import aiohttp
import asyncio
import async_timeout
from flask import Flask
from c import a
from d import health_check

# loop = asyncio.get_event_loop()
app = Flask(__name__)



@app.route("/")
def index():
    # perform multiple async requests concurrently
    return a()

    # do something with the results


app.register_blueprint(health_check)

if __name__ == "__main__":
    app.run(host='127.0.0.1',port=5007, debug=True)
