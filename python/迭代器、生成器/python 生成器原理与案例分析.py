# 之前总结了python的迭代器，从中可知迭代器可以运算过程中可以节省计算机的内存空间，而且迭代器可以返回下一个数据。
# 下面我们总结一下另外一个迭代器的变种--生成器，主要用于生成数据，但是不需要创建完整数据列表。讲起来有些拗口，直接上示例：
#
# 用for 循环作一个数据输出示例：我们只需要输出第一次结果为10，而for循环却需要把所有的列表数据都读取进来，
# 而且内部循环已经完成了，外部循环的列表数据还在内存空间中。

list1 = [1,2,4,5,6]
list2 = [1,5,6,8,9]
for i in list1:
    for j in list2:
        if i + j == 10:
            print(i,j)
    break
# 我们用生成器会如何呢？首先我们先了解一下生成器的关键字：yield。
# yield用法其实与return是一样的，但是执行完return，当前函数就终止了，函数内部的所有数据，所占的内存空间，全部都没有了。
# 而yield在返回数据的同时，还保存了当前的执行内容，当你再一次调用这个函数时，他会找到你在此函数中的yield关键字，然后从yield的下一句开始执行。
#
# 所以我们使用生成器完成上面的案例时就可以用下面的方法：

list1 = [1,2,4,5,6]
list2 = [1,5,6,8,9]
def num_generator(list1,list2):
    for i in list1:
        for j in list2:
            yield i,j

for i, j in num_generator(list1,list2):
    if i + j == 10:
        print(i,j)
        break
# 生成器的总结：
#
# 1、节约内存空间；
#
# 2、迭代到下一次调用的时候，所有的参数都会保留；
#
# 3、yield会阻塞，下次调用会接着上面的未执行的接着执行；
#
# 上面是生成器的所有内容，下次我们把迭代器和生成器经常在python代码编程中使用到的生成者和消费者案例做一个梳理，这样迭代器和生成器的概念都更加清晰了。记得关注，收藏起来哦。

def test():
    for i, j in num_generator(list1,list2):
        if i + j == 10:
            print(i,j)
            return

if __name__ == "__main__":
    test()
