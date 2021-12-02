db.env_use_plan.find().forEach(
   function(item){
       db.env_use_plan.update({"_id":item._id},{"$set":  {"text":item.envuse_test}})
    }
)