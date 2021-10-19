# 原因在于在python中从Redis取出的Sting都变成bytes格式
#
# 解决一

# 加上decode_responses=True即可解决

# redis_store = redis.StrictRedis(host='127.0.0.1', port=6379, decode_responses=True)

# redis中我们存进去的是字符串类型的数据，取出来却是字节类型的。
# 这是由于python3的与redis交互的驱动的问题，python2取出来的就是字符串类型的。
#
# 为了得到字符串类型的数据，你可以每次取出来decode一下，
# 但是太繁琐了，可以直接在连接redis时设置：
#
# sr =redis(host=‘localhost’, port=6379, db=0,decode_responses=True)
#
# 即在连接数据库的时候加上decode_responses=True即可
#
# 解决二
#
# 取值时后面加上decode()
#
# redis_store.get("name:%s"%name).decode()



# =====2

#encoding=utf-8
from redis import *

#读取数据
d1=input("您输入的数据是：")

#连接
r=StrictRedis(host='localhost',port=6379)

#写
# pipe=r.pipeline()
# pipe.set('r1','hello')
# pipe.set('r2','world')
# pipe.execute()

#读
#在python3的前面，有一个'b'代表的是bytes
#用以下方式解决

#注意，有值则进行编码
#法1：
# temp=r.get('r1').decode()
# print(temp)

#法2：
# temp=r.get('r2')
# h1=str(temp,encoding='utf-8')
# print(h1)

#如果没有值，则为None
s=r.get(d1)
print(s)
if s==None:
    print('yes')
else:
    print('no')
    temp=s.decode()
    print(temp)

# ===========3
# 在python3的前面，有一个’b’代表的是bytes
# 用以下方式解决:
# 1.注意，有值则进行编码
# (1). print(r.get(‘foo’).decode())
# (2). temp = r.get(‘foo’)
# print(str(temp,encoding=‘utf-8’))
# 2.如果没有值，则为None，不需要编码