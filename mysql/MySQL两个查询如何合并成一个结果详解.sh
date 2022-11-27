MySQL 查询合并
如果我们需要将两个select语句的结果作为一个整体显示出来，我们就需要用到union或者union all关键字。union(或称为联合)的作用是将多个结果合并在一起显示出来。

#注意：两个列表中的字段要一样才可以合并(顺序也要一样)

满足条件：
1、两个select查询的列的数量必须相同；
2、每个列的数据类型需要相似；


1.先写两条select
第一条select：
SELECT
    DATE_FORMAT(add_time, '%Y-%m-%d') as 'add_time',
    COUNT(add_time) as 'reach_intention'
FROM
    table1
where
## where 条件可以根据自己实际情况来定
    DATE_FORMAT(add_time, '%Y-%m-%d') > DATE_FORMAT(date_sub(now(), interval 1 month), '%Y-%m-%d')
group by
    DATE_FORMAT(add_time, '%Y-%m-%d')
这是查询出来的结果

结果一

第二条select：
select
    DATE_FORMAT(add_date, '%Y-%m-%d') as 'add_time' ,
    COUNT(add_date)  as 'post_release'
from
    table2
where
## where 条件可以根据自己实际情况来定
    DATE_FORMAT(add_date, '%Y-%m-%d') > DATE_FORMAT(date_sub(now(), interval 1 month), '%Y-%m-%d')
group by
    DATE_FORMAT(add_date, '%Y-%m-%d')
第二条select查询出来的结果


2.合并查询结果
先把两条select用union all连接起来

SELECT
        DATE_FORMAT(add_time, '%Y-%m-%d') as 'add_time', COUNT(add_time) as 'reach_intention' ,  '' as 'post_release'
    FROM
        table1
    where
        DATE_FORMAT(add_time, '%Y-%m-%d') > DATE_FORMAT(date_sub(now(), interval 30 day), '%Y-%m-%d')
    group by
        DATE_FORMAT(add_time, '%Y-%m-%d')
UNION ALL
    select
        DATE_FORMAT(add_date, '%Y-%m-%d') as 'add_time' , '' as 'reach_intention' ,  COUNT(add_date) as 'post_release'
    from
        table2
    where
        DATE_FORMAT(add_date, '%Y-%m-%d') > DATE_FORMAT(date_sub(now(), interval 30 day), '%Y-%m-%d')
    group by
        DATE_FORMAT(add_date, '%Y-%m-%d')
在外层嵌套一个select


## 括号里面放 用 union all 连接的select
select * from () test
## 这里要给表起个别名 不然会报 Every derived table must have its own alias 每个派生表都必须有自己的别名
把union all 连接的select 放到括号里面去然后运行

select
    *
from
(
    SELECT
        DATE_FORMAT(add_time, '%Y-%m-%d') as 'add_time', COUNT(add_time) as 'reach_intention' ,  '' as 'post_release'
    FROM
        table1
    where
        DATE_FORMAT(add_time, '%Y-%m-%d') > DATE_FORMAT(date_sub(now(), interval 30 day), '%Y-%m-%d')
    group by
        DATE_FORMAT(add_time, '%Y-%m-%d')
UNION ALL
    select
        DATE_FORMAT(add_date, '%Y-%m-%d') as 'add_time' , '' as 'reach_intention' ,  COUNT(add_date) as 'post_release'
    from
        table2
    where
        DATE_FORMAT(add_date, '%Y-%m-%d') > DATE_FORMAT(date_sub(now(), interval 30 day), '%Y-%m-%d')
    group by
        DATE_FORMAT(add_date, '%Y-%m-%d')
) test
运行结果
把结果按日期分组排序。

使用 group by 和 order by 关键字

select
    add_time,
    sum(reach_intention) as 'reach_intention' ,
    sum(post_release) as 'post_release'
from
    (
    SELECT
        DATE_FORMAT(add_time, '%Y-%m-%d') as 'add_time', COUNT(add_time) as 'reach_intention' , '' as 'post_release'
    FROM
        table1
    where
        DATE_FORMAT(add_time, '%Y-%m-%d') > DATE_FORMAT(date_sub(now(), interval 30 day), '%Y-%m-%d')
    group by
        DATE_FORMAT(add_time, '%Y-%m-%d')
UNION ALL
    select
        DATE_FORMAT(add_date, '%Y-%m-%d') as 'add_time' , '' as 'reach_intention' , COUNT(add_date) as 'post_release'
    from
        table2
    where
        DATE_FORMAT(add_date, '%Y-%m-%d') > DATE_FORMAT(date_sub(now(), interval 30 day), '%Y-%m-%d')
    group by
        DATE_FORMAT(add_date, '%Y-%m-%d') ) test
group by
    test.add_time
order by
    test.add_time desc
结果如下

总结
到此这篇关于MySQL两个查询如何合并成一个结果的文章就介绍到这了,更多相关MySQL两个查询合并一个内容请搜索脚本之家以前的文章或继续浏览下面的相关文章希望大家以后多多支持脚本之家！