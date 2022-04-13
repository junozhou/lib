
https://www.cnblogs.com/t-road/p/13055355.html
总原则：先前缀字符串，再正则表达式。

不管配置文件中的location顺序怎么写，在匹配时，都会先将所有前缀字符串拎出来，放在第一位；然后再去找所有正则表达式，作为第二位。

1、首先匹配前缀字符串。前缀字符串有以下几种形式（举例）：

a、location = /data/ {}

b、location ^~ /data/ {}

c、location /data/ {}



2、然后匹配正则表达式。正则表达式的几种形式（举例）：

d、location ~ \.html? {}

e、location ~* \.html? {}



a的权限最大，一旦匹配到，立即停止，直接使用对应的location。

b的权限次之，一旦匹配到，就不再检查正则表达式。相当于打断了后续。



c如果匹配到了，不会立即停止，而是会先将它存储起来，然后继续往下匹配。



d如果匹配到了，立即停止，直接使用对应的location；

d如果没有匹配，继续往下找。



e如果匹配到了，立即停止，直接使用对应的location；

e如果没有匹配，就使用先前存储的那个前缀字符串。



也就是说，location /data/ {}这种模式是等级最低的。实在匹配不到了，才勉强使用它。



前提是我们配置了a、b、c、d、e这五个location。

如果只配置了a、b、c，就没有正则匹配什么事了；

如果只配置了d、e，就没有前缀匹配什么事了。



那么什么叫最长匹配呢？



一个请求为：http://www.example.com/images/a.png

对于/images/a.png这个URI来说，上面的2个location中，location /images/是最长匹配。虽然location /也能匹配，但不是最长的。

由于不是精确匹配，nginx此时会先将这个最长匹配保存起来。



如果后面配置了正则表达式，那么nginx会继续向下匹配正则表达式。

如果后面没有配置正则表达式，nginx就会使用刚才保存的最长的那个前缀匹配，也就是location /images/对应的地方。

