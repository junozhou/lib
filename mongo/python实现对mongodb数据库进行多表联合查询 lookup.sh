#最近项目中需要用到对mongodb数据库进行联合查询，百度了一下都只有mongodb语句的联合查询方法，没有通过python来进行查询的。
#
#       可能是因为mongodb数据库不是关系型数据库，大家对于它的关系也用不到那么多。
#
#
#
#表字段定义
#mycol_case_collection = mydb["case_collection"]   #表A
#mycol_task_collection = mydb["task_collection"]   #表B
#A:
#mylist_case_collection = [
#    {"user_id": "yu", "case_id": "1", "case_name": "案件名1","task_id": ["10000", "10001"]}
#]
#B:
#mylist_task_collection = [
#    {"task_id": "10000","task_type": "1", "task_name": "任务名1-1","create_time": "2019-8-26 15:30:22"}
#]
#对于两张表中的task_id字段进行联合查询
#
#
#mongodb语句联合查询参考文档：
#
#https://www.cnblogs.com/lgh344902118/p/8656266.html
#
#https://www.cnblogs.com/xuliuzai/p/10055535.html
#
#mongodb官方文档
#lookup联合查询
#————————————————
#版权声明：本文为CSDN博主「yuer_xiao」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/yuer_xiao/article/details/100164847


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