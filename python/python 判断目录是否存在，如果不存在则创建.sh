#!/usr/bin/env python
import os
FILE_PATH='/home/wuxy/aaa111/222/333/444.txt'  ###444.txt 不会当做文件，而是当做目录
if os.path.exists(FILE_PATH):   ##注意变量名不要用引号！！！目录存在，返回为真
        print 'dir exists'
else:
        print 'dir not exists'

        os.makedirs(FILE_PATH)   ###FILE_PATH不用加引号。否则会报错

os.makedirs  可以级联创建目录，类似于参数mkdir -p

改写：

if not os.path.exists(FILE_PATH):

        os.makedirs(FILE_PATH)

##如果只是判断是否存在，不存在则创建，这样更好！