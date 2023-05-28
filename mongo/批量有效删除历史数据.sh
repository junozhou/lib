def del_mongo_data():

    try:
        from datetime import datetime,timedelta
        print(datetime.now().strftime('%Y-%m-%d %H:%M:%S '))
        myclient = pymongo.MongoClient("mongodb://user:pass@127.0.0.1:27017")
        mydb = myclient["test"]
        count = 10000
        while count > 0:
            cdata = mydb.get_collection("testtest").find().limit(100)
            cdata = [i['_id'] for i in cdata]

            print(f"获取用户可改准生产测试环境Apollo配置的用户列表{count}===={cdata}")
            query = {"_id": {"$in": cdata}}
            mydb.get_collection("ForecasterBillExtension").delete_many(query)
            # mydb.getCollection("ForecasterBillExtension").deleteMany({"_id": {"$in": cdata}},{"w": "majority"})

            print(datetime.now().strftime('%Y-%m-%d %H:%M:%S '))
            count = count -1
        # # logger.info("team_manager data==={}".format(cdata))
        # return cdata
    except Exception as e:
        print('An error <%s> happen' % e)
        return None