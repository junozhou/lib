#https://baijiahao.baidu.com/s?id=1750453600286090538


#在使用python过程中，假如给你一个列表获取其中的元素，你一定会用for循环进行遍历，然后获取你想要的元素。
#但是现在是一个数据爆炸的时代，假如数据特别大，那么你的计算机读取数据就要耗费大量的时间和计算机内存消耗，这时我们就会想到用python的迭代器了。

# 迭代器：就是对列表(list)等可以进行数据遍历的一种方式。
#
# 可迭代数据类型判断：我们可引用isinstance()函数来进行判断。
from collections.abc import Iterable
list = [1,4,5,3]
print(isinstance(list,Iterable)) # 结果返回True则是可迭代的

# 迭代器的好处：我们在应用迭代器进行数据的遍历时，每次都只返回下一个数据元素，
# 从而把所有的数据全部读取完毕，而且迭代器是可以记住数据访问的位置，从而可以快速拿到下一条元素，
# 而且不需要把所有的列表元素给读取进来，节省了内存空间。
#
# 迭代器的创建：以列表为例
list = ["test1","test2","test3","test4"]
listiter = list.__iter__()
print(listiter.__next__()) #结果输出test1
print(listiter.__next__()) #结果输出test2
print(listiter.__next__()) #结果输出test3
print(listiter.__next__()) #结果输出test4

# 以上迭代器的创建中我们看到用到了两个方法，__iter__()和__next__()，而__next__（）我们也可以写成next()函数。
list = ["test1","test2","test3","test4"]
listiter = list.__iter__()
print(next(listiter)) #结果输出test1
print(next(listiter)) #结果输出test2
print(next(listiter)) #结果输出test3
print(next(listiter)) #结果输出test4

# 当迭代器进行数据元素遍历的时候，遍历到最后一个时会报错。

list = ["test1","test2","test3","test4"]
listiter = list.__iter__()
while True:
    print(listiter.__next__()) #结果输出test1


    # Traceback (most recent call last):
    #   File "/test/reqest_test.py", line 516, in <module>
    #     print(listiter.__next__()) #结果输出test1
    # StopIteration


# 这时我们就需要把迭代器进行异常处理，所以一定要切记对迭代器作异常处理。

list = ["test1","test2","test3","test4"]
listiter = list.__iter__()
while True:
    try:
        print(listiter.__next__()) #结果输出test1
    except StopIteration:
        break
# 以上就是所有python迭代器的原理和应用方法，下一篇讲一下python生成器的原理和应用方法。记得赶紧学习、收藏起来哦。
#
# 
# 迭代器解决：计算机读取数据就要耗费大量的时间和计算机内存消耗
l = {'redisson.sentinelServersConfig.database': '0', 'redisson.sentinelServersConfig.masterName': 'test',
     'redisson.sentinelServersConfig.password': '123456', 'redisson.sentinelServersConfig.sentinelAddresses[0]':
         'redis://127.0.0.1:6379', 'redisson.sentinelServersConfig.clientName': 'default'}
liter = l.__iter__()
while True:
    try:
        print(liter.__next__())
    except StopIteration:
        break

