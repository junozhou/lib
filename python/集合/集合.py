# https://www.runoob.com/python3/python3-set.html

# 集合（set）是一个无序的不重复元素序列。
#
# 可以使用大括号 { } 或者 set() 函数创建集合，注意：创建一个空集合必须用 set() 而不是 { }，因为 { } 是用来创建一个空字典。


# 遍历set
# 由于 set 也是一个集合，所以，遍历 set 和遍历 list 类似，都可以通过 for 循环实现。
#
# 直接使用 for 循环可以遍历 set 的元素：


weekdays = set(['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'])

for d in weekdays:
    print (d)


# 注意: 观察 for 循环在遍历set时，元素的顺序和list的顺序很可能是不同的，而且不同的机器上运行的结果也可能不同。

