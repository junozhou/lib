db.getCollection('plan').find({"envuse_team" : "old-value"}).forEach(
   function(item){
       db.getCollection('plan').update({"_id":item._id},{$set:{"envuse_team":"new-value"}})
   }
)
