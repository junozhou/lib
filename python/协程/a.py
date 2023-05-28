from functools import wraps
from flask import Flask
import asyncio



app = Flask(__name__)

def async_action(f):
    @wraps(f)
    def wrapped(*args, **kwargs):
        return asyncio.run(f(*args, **kwargs))
    return wrapped
async def pp():
    print("hhh")
@app.route('/')
@async_action
async def index():
    await pp()
    return 'Hello world !'


if __name__ == '__main__':
    app.run(host='127.0.0.1',port=5006, debug=False)