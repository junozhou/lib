1. 方法1： INSTR函数用法
mysql 进行模糊查询时，可使用内部函数 instr，替代传统的 like 方式，并且速度更快。

instr(field, str) 函数，第一个参数 field 是字段，第二个参数 str 是要查询的串，返回串 str 的位置，没找到就是0

select * from book where  INSTR( book_name , "经" ) > 0
1
2. 方法2： like
SELECT * FROM users WHERE emails like "%b@email.com%";
1
3. 方法3： find_in_set();
必须以","分割开。

SELECT * FROM users WHERE find_in_set('aa@email.com', emails);


#https://blog.csdn.net/u014651560/article/details/124248358