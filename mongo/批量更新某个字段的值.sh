db.getCollection('plan').find({"envuse_team" : "old-value"}).forEach(
   function(item){
       db.getCollection('plan').update({"_id":item._id},{$set:{"envuse_team":"new-value"}})
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