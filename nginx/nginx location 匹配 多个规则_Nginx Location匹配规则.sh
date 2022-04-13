规则语法

ed0981ae8c1fd7127e3483b87bb57d27.png
!~和!~*分别为区分大小写不匹配及不区分大小写不匹配 的正则, 但是是用于条件判断的时候(即if语句)

if ($host !~* "^www.") { # ... }
匹配简单来说:

优先匹配 = 精确匹配, 若未匹配到则转下一步骤
依照最大前缀匹配规则, 先匹配普通规则(空 , ^~)
若最终匹配到 ^~, 则使用
若匹配到 空 或 未匹配到, 则转下一步骤(当前匹配结果暂时保存)
按照物理存储顺序, 若匹配到任意一条正则, 马上使用(无视后面正则)
若未匹配到任意正则, 则使用步骤2中匹配到普通正则
location 分类
只有两类：正则location和普通location

~ 和 ~* 为正则location=、^~、@和无任何前缀的都属于普通location，另外，@是用作服务端内部的一种转发行为，很少用，在此不做讨论。

匹配顺序：
先普通，再正则
普通location之间的匹配顺序：按最大前缀匹配
如location /a/{}，location /a/b/ {},请求 http://a/b/c.html 匹配的是 location /a/b/ {}
正则location之间的匹配顺序：按配置文件中的物理顺序匹配，只要匹配到一条正则，就不再考虑后面的
若普通location匹配到 精确匹配= 或 非正则匹配 ^~, 则不再进行后续的正则匹配
普通location与正则location之间的匹配结果选择
普通location先匹配，匹配到了结果，只是一个临时结果；
会继续正则location的匹配，
如果匹配到正则，则用匹配到的正则结果；
如果没有匹配到正则，则继续用普通匹配的那个结果
综上，常规的顺序是匹配完普通location，还要继续匹配正则location，但是，也可以告诉nginx，匹配到了普通location，就不要再搜索匹配正则location了，通过在普通location前面加上^~符号，^表示非，~表示正则，^~就是表示不要继续匹配正则。

除了^~，=也可阻止nginx继续匹配正则，区别在于^~依然遵循最大前缀匹配规则，而=是严格匹配

扩展
location / {}和 location =/ {}的区别
/ {}作为普通匹配，是遵循最大前缀匹配原则的，所以，对于一个url，如果有更特殊合适的匹配，就选特殊合适的，如果没有更特殊合适的匹配，也有 / {}兜着，就像是默认配置一样

=/ {} 遵循的是严格匹配规则，只能匹配到 http://ip:port/，同时会停止搜索正则匹配。

测试
接下来测试验证。

1.先验证第二条：普通location之间的匹配顺序：按最大前缀匹配

nginx.conf配置：

#普通location
    location  /a/b {
        return 666;
    }
    #普通location
    location /a/b/c {
        return 777;
    }
测试链接：http://192.168.88.38/a/b，http状态码为666，符合预期。如图（后面的测试可自行F12打开浏览器控制台查看http状态码，不再截图）：

测试链接：http://192.168.88.38/a/b/c，http状态码为777，匹配的是location /a/b/c {return 777;}，符合预期。

2.验证第三条：正则location之间的匹配顺序：按配置文件中的物理顺序匹配，只要匹配到一条正则，就不再考虑后面的

nginx.conf配置：

location ~* /a {
        return 999;
    }
   #匹配a-z的任意一个字母
   location ~* ^/[a-z]$ {
        return 666;
    }
测试链接：http://192.168.88.38/a，http状态码999，匹配的是location ~* /a {renturn 999;}，符合预期。
将nginx.conf中的两个正则匹配顺序调换下：

location ~* ^/[a-z]$ {
        return 666;
    }

    location ~* /a {
        return 999;
    }
测试链接：http://192.168.88.38/a，http状态码666，匹配的是location ~* ^/[a-z]$，符合预期。

3.验证第4条，其实第4条就相当于是总结性的匹配顺序了：

nginx.conf配置：

#普通location
location /a {
     return 666;
}
 #普通location
location  /a/b {
     return 777;
}
#正则location
location ~* /a/b {
     return 888;
}
测试链接：http://192.168.88.38/a，http状态码666，匹配到普通location，location /a {return 666;},符合预期。
测试链接：http://192.168.88.38/a/b，http状态码777，先进行普通location匹配，遵循最大前缀原则，匹配到location /a/b {return 777; }，但是，这只是一个临时结果，因为接下来还要继续往下进行正则location匹配，匹配到 location ~* /a/b { return 888; }，最终返回结果为888。符合预期。
将正则location的规则改下：

#普通location
        location /a {
            return 666;
        }
        #普通location
        location  /a/b {
            return 777;
        }
        #正则location
        location ~* /a/c {
            return 888;
         }
测试链接：http://192.168.88.38/a/b，http状态码777，匹配到location /a/b {return 777; }，并且因为接下来没有符合的正则location，所以最终返回为777，符合预期。

综上，location的匹配顺序及结果取值都符合2,3,4点结论。
接下来再测试验证普通location中的^~及=符号对于匹配搜索过程的阻断效果，当然，别忘了这俩符号的真实作用。^~为普通字符匹配，=为精确匹配。
^~测试验证nginx.conf配置：

location /a {
        return 666;
    }
    #普通匹配
    location ^~ /a/b {
        return 777;
    }
    #正则location
    location ~* /a/b {
        return 888;
    }
测试链接：http://192.168.88.38/a/b，匹配到 location ^~ /a/b {return 777;}后，因为使用了^~符号，不再继续搜索正则location匹配，所以，虽然下面有符合条件的正则location，但是最终还是返回了777，符合预期。
=测试验证nginx.conf配置：

location /a {
        return 666;
    }
    #普通匹配
    location = /a/b {
        return 777;
    }
    #正则location
    location ~* /a/b {
        return 888;
    }
测试链接：http://192.168.88.38/a/b，匹配到 location = /a/b {return 777;}后，因为使用了=符号，不再继续搜索正则location匹配，最终返回777，符合预期。

另附上常用正则表达式：

. ： 匹配除换行符外的任意字符
? ： 重复0次或1次
： 重复1次或更多次
： 重复0次或更多次
d ：匹配数字
^ ： 匹配字符串的开始
$ ： 匹配字符串的结束
{n} ： 重复n次
{n,} ： 重复n次或更多次
[c] ： 匹配单个字符，如此处的字符 c
[a-z] ： 匹配a-z小写字母的任意一个
(a|b|c)：匹配a或b或c
以上内容希望帮助到大家，很多PHPer在进阶的时候总会遇到一些问题和瓶颈，业务代码写多了没有方向感，不知道该从那里入手去提升，对此我整理了一些资料，包括但不限于：分布式架构、高可扩展、高性能、高并发、服务器性能调优、TP6，laravel，YII2，Redis，Swoole、Swoft、Kafka、Mysql优化、shell脚本、Docker、微服务、Nginx等多个知识点高级进阶干货需要的可以免费分享给大家，需要请戳这里链接 或 者关注咱们下面的知乎专栏

PHP架构师圈子​zhuanlan.zhihu.com

https://blog.csdn.net/weixin_39587029/article/details/110583976