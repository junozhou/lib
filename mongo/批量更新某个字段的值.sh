db.getCollection('plan').find({"envuse_team" : "old-value"}).forEach(
   function(item){
       db.getCollection('plan').update({"_id":item._id},{$set:{"envuse_team":"new-value"}})
   }
)


db.getCollection('error_log_info').find({"log_status" : 0}).forEach(
   function(item){
       db.getCollection('error_log_info').update({"_id":item._id},{$set:{"log_status":1}})
   }
)


db.getCollection('base_env_info').find({"root_env_desc" : "融通t1"}).forEach(
   function(item){
       db.getCollection('base_env_info').update({"_id":item._id},{$set:{"root_env_desc":"T1"}})
   }
)
db.getCollection('env_use_plan').find({"envuse_test" : "融通t1"}).forEach(
   function(item){
       db.getCollection('env_use_plan').update({"_id":item._id},{$set:{"envuse_test":"T1"}})
   }
)
db.getCollection('env_use_plan').find({"text" : "融通t1"}).forEach(
   function(item){
       db.getCollection('env_use_plan').update({"_id":item._id},{$set:{"text":"T1"}})
   }
)

db.getCollection('base_env_info').find({"root_env_desc" : "融通t2"}).forEach(
   function(item){
       db.getCollection('base_env_info').update({"_id":item._id},{$set:{"root_env_desc":"T2"}})
   }
)
db.getCollection('env_use_plan').find({"envuse_test" : "融通t2"}).forEach(
   function(item){
       db.getCollection('env_use_plan').update({"_id":item._id},{$set:{"envuse_test":"T2"}})
   }
)
db.getCollection('env_use_plan').find({"text" : "融通t2"}).forEach(
   function(item){
       db.getCollection('env_use_plan').update({"_id":item._id},{$set:{"text":"T2"}})
   }
)


db.getCollection('base_env_info').find({"root_env_desc" : "融通t4"}).forEach(
   function(item){
       db.getCollection('base_env_info').update({"_id":item._id},{$set:{"root_env_desc":"T4"}})
   }
)
db.getCollection('env_use_plan').find({"envuse_test" : "融通t4"}).forEach(
   function(item){
       db.getCollection('env_use_plan').update({"_id":item._id},{$set:{"envuse_test":"T4"}})
   }
)
db.getCollection('env_use_plan').find({"text" : "融通t4"}).forEach(
   function(item){
       db.getCollection('env_use_plan').update({"_id":item._id},{$set:{"text":"T4"}})
   }
)





db.getCollection('base_env_info').find({"root_env_desc" : "运营平台t11"}).forEach(
   function(item){
       db.getCollection('base_env_info').update({"_id":item._id},{$set:{"root_env_desc":"T11_scfop运营端"}})
   }
)
db.getCollection('env_use_plan').find({"envuse_test" : "运营平台t11"}).forEach(
   function(item){
       db.getCollection('env_use_plan').update({"_id":item._id},{$set:{"envuse_test":"T11_scfop运营端"}})
   }
)
db.getCollection('env_use_plan').find({"text" : "运营平台t11"}).forEach(
   function(item){
       db.getCollection('env_use_plan').update({"_id":item._id},{$set:{"text":"T11_scfop运营端"}})
   }
)

db.getCollection('base_env_info').find({"root_env_desc" : "运营平台t12"}).forEach(
   function(item){
       db.getCollection('base_env_info').update({"_id":item._id},{$set:{"root_env_desc":"T12_scfop运营端"}})
   }
)
db.getCollection('env_use_plan').find({"envuse_test" : "运营平台t12"}).forEach(
   function(item){
       db.getCollection('env_use_plan').update({"_id":item._id},{$set:{"envuse_test":"T12_scfop运营端"}})
   }
)
db.getCollection('env_use_plan').find({"text" : "运营平台t12"}).forEach(
   function(item){
       db.getCollection('env_use_plan').update({"_id":item._id},{$set:{"text":"T12_scfop运营端"}})
   }
)


db.getCollection('env_use_plan').find({"envuse_team" : "技术-运营团队"}).forEach(
   function(item){
       db.getCollection('env_use_plan').update({"_id":item._id},{$set:{"envuse_team_name":"技术-运营团队"}})
   }
)


db.getCollection('ForecasterBillExtension').find({"createTime" : {"$lt":ISODate("2022-06-01T01:16:33.303Z")}}).forEach(
   function(item){
       db.getCollection('ForecasterBillExtension').remove( { "_id": item._id }, { justOne: true } )
   }
)




db.getCollection('ForecasterBillExtension').find({"createTime" : {"$lt":ISODate("2020-02-20T01:16:33.303Z")}}).forEach(
   function(item){
       db.getCollection('ForecasterBillExtension').remove( { "_id": item._id }, { justOne: true } )
   }
)






db.getCollection('Pccd_common_relation').find().forEach(
   function(item){
       db.getCollection('Pccd_common_relation').update(
       {"update_time":item.update_time},
       {$set:{"platform_data":{
         "id":1,
         "platform_name": "1平台",
         "platform_alias": "Pccd"
         }
         }
         }
         )
   }
)