Python - 判断list是否为空
Python中判断list是否为空有以下两种方式：

方式一：

1 list_temp = []
2 if len(list_temp):
3     # 存在值即为真
4 else:
5     # list_temp是空的
方式二：

1 list_temp = []
2 if list_temp:
3     # 存在值即为真
4 else:
5     # list_temp是空的
以上两种方法均可以判断出 list_temp 列表是否是空列表，第二个方法要优于第一个方法，在Python中，False,0,'',[],{},()都可以视为假。
实际自己用的是第一种方式！！！！