#pymongo 模块获取当前数据库下的所有collection名称
#
#问题描述：连接mongdb指定数据库后，获取所有集合名称
#
#注意：

# pymongo 3.6 使用collection_names( include_system_collections=True, session=None)

# pymongo 3.7 使用list_collection_names(session=None)


from pymongo import MongoClient

client = MongoClient("mongodb://username:password@127.0.0.1:27017/")
db = client["testdb"]

coll_names = db.list_collection_names(session=None)
print(coll_names)

>> ['collections01',  'collections02', 'collections03']
#————————————————
#版权声明：本文为CSDN博主「梅山学子」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/LeonTom/article/details/83176500