一、$project 修改文档的结构
可以用来重命名，增加或者删除文档中的字段
要求查找 order 只返回文档中 trade_no 和 all_price 字段。

$project中的字段值 为1表示筛选该字段，为0表示过滤该字段
def list_special_conf(**listArgs):
    logger.info("查询环境特殊配置：%s => %s" % (sys._getframe().f_code.co_name, listArgs))
    page = int(listArgs.get("page"))
    pageSize = int(listArgs.get("pageSize"))
    k8snamespace = str(listArgs.get("k8snamespace"))
    special_conf_table = k8snamespace.strip()+"_special_conf"
    relation_table = ""
    for i in ENV_RELATION:
        special_tables = ENV_RELATION.get(i)
        if special_conf_table in special_tables:
            relation_table = i
    queryFilter = copy.deepcopy(listArgs)
    queryFilter.pop("page")
    queryFilter.pop("pageSize")
    queryFilter.pop("k8snamespace")
    query = {}
    query["$and"] = []
    for key in list(queryFilter.keys()):
        if queryFilter.get(key) != "":
            tmpObj = {}
            tmpObj[key] = {"$regex":queryFilter.get(key)}
            query["$and"].append(tmpObj)
    if query["$and"] == []:
        query = {}
    elif len(query["$and"]) == 1:
        query = query["$and"][0]
    query["status"] = {"$gt": 0}
    # print(query)
    myclient = pymongo.MongoClient("mongodb://127.0.0.1:27017/")
    mydb = myclient[SPECIAL_CONF_DB_NAME]
    r = []
    ret = {}
    skip = pageSize*(page-1)
    lookup_query = {
        "$lookup": {
            "from": relation_table,
            "localField": "type",
            "foreignField": "type",
            "as": "common-relation"
        }
    }
    project_query = {
        '$project':
            {
                'common-relation.serviceList':1,
                'key':1,
                'value':1,
                'status':1,
                'cluster':1,
                'type':1,
                '_id':0,
            },
    }
    match_query = {
        '$match':
            query,
    }
    # print(query)
    collection_data = mydb.get_collection("k8snamespace_special_conf").aggregate([
        lookup_query,
        project_query,
        match_query,{
            '$sort': {
                'type':1
            }
        },{
            '$limit':pageSize
        },{
            '$skip':skip
        }
    ])
    itemsCount = mydb.get_collection(special_conf_table).count_documents(query)
    if itemsCount == 0:
        totalPages = 0
    elif itemsCount % pageSize == 0:
        totalPages = int(itemsCount/pageSize)
    else:
        totalPages = int(itemsCount/pageSize)+1
    for i in collection_data:
        r.append(i)
        print(i['type'])
    # r = sorted(r, key=lambda x: (x['type']))
    ret["dataList"] = copy.deepcopy(r)
    ret["pagecond"] = {}
    ret["pagecond"]["count"] = itemsCount
    ret["pagecond"]["totalPages"] = totalPages
    ret["pagecond"]["page"] = page
    ret["pagecond"]["pageSize"] = pageSize
    # print(ret["dataList"])
    # print(ret)
    return ret


#lookup联合查询

mycol_case_collection = mydb["case_collection"]

#当前表A
result = mycol_case_collection.aggregate(
    [
        {
            '$lookup':
                {
                    "from": "task_collection", #需要联合查询的另一张表B
                    "localField": "task_id",   #表A的字段
                    "foreignField": "task_id", #表B的字段
                    "as": "task_docs"          #根据A、B联合生成的新字段名
                },
        },
        {
            '$project':                        #联合查询后需要显示哪些字段，1：显示
                {
                    'task_docs.task_id':1,
                    'task_docs.task_name':1,
                    'task_docs.task_type':1,
                    'task_docs.evidence_content':1,
                    'case_id':1,
                    'task_id':1,
                    'user_id':1,
                    '_id':0,
                },
         },
        {
            '$match':                           #根据哪些条件进行查询
                {
                    "user_id" : name            #这里是根据表A中 user_id == name
                }
        }
    ]
)
#mongodb Aggregation聚合操作之$match

db.articles.aggregate( [

{ $match: { $or: [ { score: { $gt: 70, $lt: 90 } }, { views: { $gte: 1000 } } ] } },

{ $group: { _id: null, count: { $sum: 1 } } }

] );

#作者：蚁族的乐土
#链接：https://www.jianshu.com/p/84578fcab3f3
#来源：简书
#著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

参考地址：https://blog.csdn.net/qq_40323256/article/details/114310905?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7EHighlightScore-1.queryctrv2&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7EHighlightScore-1.queryctrv2&utm_relevant_index=1