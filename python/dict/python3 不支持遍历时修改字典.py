# 问题 ：
# RuntimeError: dictionary changed size during iteration。
#
# 原因：
# python2 的用法。
# python3 不支持遍历时修改字典。
#
# 解决方法：
# 加一个list。

for k in list(headerTable.keys()):
    if headerTable[k] < minSup:
        del(headerTable[k])