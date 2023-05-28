
import pymongo
def page_query(query_filter=None,page_size=10,page_no=1):
    """分页查询"""
    myclient = pymongo.MongoClient("mongodb://12.0.216.73:27017/")
    mydb = myclient["code_merge"]
    skip = page_size*(page_no-1)
    collection_data = mydb.get_collection("code_merge_records").find().sort([("updateTime",-1)]).collation({
        "locale": "en_US", "numericOrdering": True}).limit(page_size).skip(skip)
    # mongo统计数据量，count方法已经废弃，用count_documents
    # itemsCount = mydb.get_collection("env_use_plan").count_documents(query_filter)
    collection_data = [i for i in collection_data]
    print(collection_data)

if __name__ == '__main__':
    #app = Flask(__name__)
    page_query(None,4,1)