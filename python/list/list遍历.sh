#!/usr/bin/env python
 2 # -*- coding: utf-8 -*-
 3 if __name__ == '__main__':
 4     list = ['html', 'js', 'css', 'python']
 5
 6     # 方法1
 7     print '遍历列表方法1：'
 8     for i in list:
 9         print ("序号：%s   值：%s" % (list.index(i) + 1, i))
10
11     print '\n遍历列表方法2：'
12     # 方法2
13     for i in range(len(list)):
14         print ("序号：%s   值：%s" % (i + 1, list[i]))
15
16     # 方法3
17     print '\n遍历列表方法3：'
18     for i, val in enumerate(list):
19         print ("序号：%s   值：%s" % (i + 1, val))
20
21     # 方法3
22     print '\n遍历列表方法3 （设置遍历开始初始位置，只改变了起始序号）：'
23     for i, val in enumerate(list, 2):
24         print ("序号：%s   值：%s" % (i + 1, val))




Python遍历列表时删除元素

方法2，重新构造list

bas = [ 'ba1', 'ba2', 'ba3', 'ba4', 'ba5', 'tk' ]
bas = [ba for ba in bas if ba.find( 'ba' ) == -1]
print( bas )




