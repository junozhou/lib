
import pymongo
def page_query(query_filter=None,page_size=10,page_no=1):
    """分页查询"""
    myclient = pymongo.MongoClient("mongodb://127.0.0.1:27017/")
    mydb = myclient["cron_status"]
    skip = page_size*(page_no-1)
    collection_data = mydb.get_collection("table_name").find(query_filter,{
    #     过滤不需要返回的字段
    #     'job_state':0,'next_run_time':0
    }).limit(page_size).skip(skip)
    # mongo统计数据量，count方法已经废弃，用count_documents
    itemsCount = mydb.get_collection("env_use_plan").count_documents(query_filter)

if __name__ == '__main__':
    #app = Flask(__name__)
    page_query(None,4,1)