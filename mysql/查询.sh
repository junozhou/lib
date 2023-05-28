mysql查询int ID时，查询条件可以是字符串，需求给值加个引号
 = 和 in 后面都可接字符串和字符数组
如下两个sql语句,已验证
select id from c_info where status =1 and team_id = '276' and id = '2858'
select id from c_info where status =1 and team_id = '276' and id in ('2858', '2856', '2857', '2850', '2849', '2848')
