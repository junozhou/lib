一、查询重复记录
例：查询员工表里出现重复姓名的记录

思路：
#1、查看重复记录，首先要使用分组函数（group by），再用聚合函数中的计数函数count(name)给姓名列计数，且使用group by 后不可使用*
#2、查关键字：姓名，以姓名进行分组，看潜在条件：重复，也就是count（name）>1，使用having过滤条件，不可使用where（where子句无法与聚合函数count（）一起使用）

方法1
代码如下（示例）：
select employee_name,count(*) from employee group by employee_name having count(employee_name)>1;

方法2：使用别名as
代码如下（示例）：
select employee_name,count(*) as c from employee group by employee_name having c>1;
方法2试过,能查出所有列
select *,count(*) as c from `user` group by username having c>1;

方法3:筛选全部字段，将符合的数据进行展示
代码如下（示例）：
方法3，不推荐，执行速度较慢
select * from employee where employee_name in ( select employee_name from employee group by employee_name having count(employee_name)>1);
二、总结
推荐方法2，简洁且运行速度快；方法3不推荐，需要全部字段筛选出来，运行速度慢。
#————————————————
#版权声明：本文为CSDN博主「晚风吹儿」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/weixin_44688529/article/details/121358920