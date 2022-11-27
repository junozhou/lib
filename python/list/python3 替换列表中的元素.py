# 方法一：多种异常字段替换成一种字段

# 原数据
data = [123, 234, '零', 'None', 8975]
# 需要替换字段
replace = ['零', 'None']
result = [0 if i in replace else i for i in data]

# Out[6]: [123, 234, 0, 0, 8975]   # 替换后结果
# 方法二：多字段替换

# 原数据
data = [123, 234, '零', 'None', 8975]
# 需要替换字段
replace = {'零': 0, 123: '一二三'}
result = [replace[i] if i in replace else i for i in data]

# Out[9]: ['一二三', 234, 0, 'None', 8975]    # 替换后结果
# ————————————————
# 版权声明：本文为CSDN博主「码农小钢」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
# 原文链接：https://blog.csdn.net/qq_41236493/article/details/106297288