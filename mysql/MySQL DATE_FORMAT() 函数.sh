https://www.cnblogs.com/lgx5/p/12891410.html

语法
 DATE_FORMAT(date,format)

   date 参数是合法的日期。format 规定日期/时间的输出格式。

可以使用的格式有：

实例

下面的脚本使用 DATE_FORMAT() 函数来显示不同的格式。我们使用 NOW() 来获得当前的日期/时间：

DATE_FORMAT(NOW(),'%b %d %Y %h:%i %p')
DATE_FORMAT(NOW(),'%m-%d-%Y')
DATE_FORMAT(NOW(),'%d %b %y')
DATE_FORMAT(NOW(),'%d %b %Y %T:%f')

结果类似：
Dec 29 2008 11:45 PM
12-29-2008
29 Dec 08
29 Dec 2008 16:25:46.635

1 select DATE_FORMAT('2017-09-20 08:30:45', '%Y-%m-%d %H:%i:%S') from dual;
2
3 select DATE_FORMAT(NOW(),'%Y-%m-%d %H:%i:%S');
4
5 select DATE_FORMAT(NOW(),'%b %d %Y %h:%i %p');
结果类似：

2017-09-20 08:30:45

2020-05-14 21:06:52

May 14 2020 09:07 PM