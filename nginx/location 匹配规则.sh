location的匹配：
匹配模式及顺序举例：

location = /uri 　　　=开头表示精确匹配，只有完全匹配上才能生效。
location ^~ /uri 　　^~ 开头对URL路径进行前缀匹配，并且在正则之前。
location ~ pattern 　~开头表示区分大小写的正则匹配。
location ~* pattern 　~*开头表示不区分大小写的正则匹配。
location /uri 　　　　不带任何修饰符，也表示前缀匹配，但是在正则匹配之后，如果没有正则命中，命中最长的规则。
location / 　　　　　通用匹配，任何未匹配到其它location的请求都会匹配到，相当于switch中的default。

————————————————
版权声明：本文为CSDN博主「kunAUGUST」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/kunaugust/article/details/117568431