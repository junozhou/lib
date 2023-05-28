# 我们在python编程中，除了列表、字典等外，还经常会用到集合，下面就总结一下集合的定义与用法。
# 集合：在python用{}表示，它是python内置的一种可变数据序列。
# '''python 集合的定义和用法'''
# 集合的创建
testset = {"test1","test2"}
print(type(testset)) # <class 'set'>

# 集合与字典的区别：在集合里只要value，而字典则有key-value。
# 集合的特点：集合内的元素不能重复。所以我们可以用这个方法进行数据去重
testset = {"test1","test1"}
print(testset) # {'test1'}
# 创建一个空集合：
testset = set()
testset1 = set(range(3))
print(testset1) # {0, 1, 2}

# 集合的函数和操作：
#
# 1、给集合内增加一个元素，add()
testset1 = {1,3,4}
testset1.add(5)
print(testset1) #{1, 3, 4, 5}
# 2、集合元素是否存在的判断 in & not in
testset1 = {1,3,4}
print(2 not in testset1) # True
# 3、集合元素的删除。
testset1 = {1,3,4}
testset1.discard(3)
print(testset1) # {1, 4}
# 4、集合间判断是否相同。

testset1 = {1,3,4}
testset2 = {1,3,4}
print(testset1 == testset2) # True
# 6、两个集合的并集。

testset1 = {1,3,4}
testset2 = {1,3,5}
print(testset1.union(testset2)) # {1, 3, 4, 5}
# 7、两个集合的差集。

testset1 = {1,3,4}
testset2 = {1,3,5}
print(testset1.difference(testset2)) # {4}

