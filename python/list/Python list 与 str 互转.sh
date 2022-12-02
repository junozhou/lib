#str 转list

str转list有两种方法,一种是list()函数,一种是split()方法 ，
list()会把字符串的每一个字符分开,而split只是根据条件切分字符串成为列表.

>>> str1="你好 hello world"
>>> list(str1)
['你', '好', ' ', 'h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']
>>>
>>> str1.split(" ")
['你好', 'hello', 'world']

#list 转 str

>>> ll = ["你好","hello","world"]
>>> list_str1="".join(ll)
>>> print(list_str1)
你好helloworld
>>> list_str1
'你好helloworld'

#list(str)转list(int)

>>> ll_int=['1','2','3','4','5']
>>> ll_int = list(map(int,ll_int))
>>> ll_int
[1, 2, 3, 4, 5]
list(int)转list(str)
>>> ll_str=[1,2,3,4,5]
>>> ll_str=list(map(str,ll_str))
>>> ll_str
['1', '2', '3', '4', '5']

#list(int)转str

>>> ll_str=[1,2,3,4,5]
>>> ll_str =",".join(list(map(str,ll_str)))
>>> ll_str
'1,2,3,4,5'
>>> ll_str=[1,2,3,4,5]
>>> ll_str ="".join(list(map(str,ll_str)))
>>> ll_str
'12345'
