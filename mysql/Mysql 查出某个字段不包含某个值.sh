遇到了个sql查询某个字段不包含某个值，记录一下

比如：某表 table_ceshi , 有以下的数据

id   status

1        1

2        2

3        3

4        2

5        1

现在想要排除 status = 3的，查出来后的数据为

id   status

1        1

2        2

4        2

5        1

可以使用一下sql:

select id,status from table_ceshi where id not in (select id from table_ceshi where status='3')

        有些小伙伴可能会说直接 status != 3 不就可以了，还用得着这样麻烦，我当时也想过这样用，可是这是在某种情况下用 != 时不生效的场景，当时就遇上了这种场景，所以记录一下。

sql查询字段不包含某个值 保存一下链接

常用条件：=等于、<>不等于、in包含、not in不包含、like匹配
————————————————
版权声明：本文为CSDN博主「chicheese」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/qq_34828100/article/details/127103285