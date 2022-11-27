在mysql中，having子句用于筛选分组之后的各种数据，
通常与“group by”联合使用，该语句弥补了where关键字无法与聚合函数联合使用的不足。
mysql中having的用法是什么
在 SQL 中增加 HAVING 子句原因是，WHERE 关键字无法与聚合函数一起使用。

HAVING 子句可以让我们筛选分组后的各组数据。

#SQL HAVING 语法
SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE column_name operator value
GROUP BY column_name
HAVING aggregate_function(column_name) operator value;

#SQL HAVING 实例
现在我们想要查找总访问量大于 200 的网站。
我们使用下面的 SQL 语句：
SELECT Websites.name, Websites.url, SUM(access_log.count) AS nums FROM (access_log
INNER JOIN Websites
ON access_log.site_id=Websites.id)
GROUP BY Websites.name
HAVING SUM(access_log.count) > 200;