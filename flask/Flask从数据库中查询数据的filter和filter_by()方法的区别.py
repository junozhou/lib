一、问题描述
Flasky查询数据的时候，会需要用到过滤器来根据一定的条件筛选。其中，有两个方法filter和filter_by看起来很像，那么它们的区别是什么呢？

二、对比
官方文档是这样写的：

Query.filter() - filter on SQL expressions.

Query.filter_by() - filter on keyword expressions.

也就是说，它们俩接受的参数类型不一样。

1. filter接受的参数是一个类似于SQL表达式的值

u=User.query.filter(User.username=='john').first()
注意：这里要遵循Python的语法，表示相等的比较操作符是==；而且，要显式地指出username是哪个模型类的字段。

既然参数是一个表达式，它能做的就更多。请看下面的例子：

#查询出了id值大于90的所有用户
users=User.query.filter(User.id>90).all()
2.filter_by接受的参数是关键字参数

u=User.query.filter_by(username='jessica').first()
相较于filter的表达式参数，filter_by里的关键词参数写起来更加简洁，但是它不能用>或者<这样的比较操作符了。
