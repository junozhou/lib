# https://www.miaokee.com/390666.html
# 本文实例讲述了Python简单遍历字典及删除元素的方法。分享给大家供大家参考，具体如下：
#
# 这种方式是一定有问题的：

d = {'a':1, 'b':2, 'c':3}
for key in d:
    d.pop(key)
#
# 会报这个错误：RuntimeError: dictionary changed size during iteration
#
# 这种方式Python2可行，Python3还是报上面这个错误。
d = {'a':1, 'b':2, 'c':3}
for key in d.keys():
    d.pop(key)

# Python3报错的原因是keys()函数返回的是dict_keys而不是list。Python3的可行方式如下：

d = {'a':1, 'b':2, 'c':3}
for key in list(d):
    d.pop(key)

# 希望本文所述对大家Python程序设计有所帮助。




