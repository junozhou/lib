# 在编写python代码时，我们常用def写函数、方法外，我们经常会用到lambda表达式当做一个简单的函数，通常我们称为匿名函数，下面我们就将lambda函数做一个总结：
#
# lambda函数：是python的一个匿名函数，lambda是python的保留字之一，并且函数体则为一个表达式。
#
# 样例：
#  lambda函数
test = lambda x:x+1
print(test(1))
# lambda定义：
#
# <函数名> = lambda<参数> ： <表达式>
#
# lambda函数也可以传入多参：


test = lambda x,y:x+y
print(test(1,2)) #结果输出3
# lambda函数可以是方法的编写更加简单，但是它只能用于函数体只有一种逻辑时，所以选择它应用时，需要考虑好应用场景。
#
# lambda函数内容就是这些，赶紧学习、收藏起来吧。


