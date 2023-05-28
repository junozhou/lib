# while True 语句中一定要有结束该循环的break语句，否则会一直循环下去的
#
# python学习——while True的用法
#
# 在学习过程中，经常能遇到采用while True的用法。下面以一个例子进行说明：
#
# 建立一个用户登录系统，用户输入用户名和密码，如果正确就可以进入系统。
#
# 1、我自己最开始的写法：

d = {"awei1": "passwd1", "awei2": "passwd2"}        #数据库字典，所有用户的用户名密码存储在此

name = input("请输入您的用户名：")
if name in d:
    password = input("请输入您的密码")
    if d[name] == password:
        print('进入系统') #如果输入正确的话就跳出循环
    else:
        print('您输入的密码错误，请重新输入')
else:
    print('您输入的用户名不正确，请重新输入')
# 这个自己写的程序逻辑上貌似是对的：
# ——先让用户输入用户名，如果存在该用户名，就继续让用户输入密码，如果密码正确就进入系统。如果密码不正确就重新输入。
# ——如果不存在该用户名，提示“您输入的用户名不正确，请重新输入”
#
# 但是在实际运行过程中，如果用户输入的用户名和密码都正确，那自然是没有问题的。但是如果有一个输入不正确，那系统只会显示“您输入的用户名不正确，请重新输入”或“您输入的密码错误，请重新输入”。也就是说，如果出现错误，没有返回到原来的地方，请求继续输入。
#
# 2、采用while True循环语句：
#
# 采用该语句的核心思想是如果出现错误的话，可以继续循环。

d = {"awei1": "passwd1", "awei2": "passwd2"}

while True:
    name = input('请输入您的用户名：')
    if name in d:
        break #如果输入正确的话就跳出循环
    else:
        print('您输入的用户名不存在，请重新输入')
        continue

while True:
    password = input('请输入您的密码：')
    if d[name] == password: #如果输入正确的话就跳出循环
        print('进入系统')
        break
    else:
        print('您输入的密码不正确，请重新输入')
        continue
# 以上程序就可以达到所需目的：在输入用户名或密码错误的情况下返回到开始部分，请求继续输入。
#
# while True 语句中一定要有结束该循环的break语句，否则会一直循环下去的。
#
# 当然，我们遇见过如果密码错误的话，提示您还有几次输入密码的机会。可以这样实现：

count = 5
while count:
    password = input('请输入您的密码：')
    if d[name] == password: #如果输入正确的话就跳出循环
        print('进入系统')
        break
    else:
        count -= 1
        print('您输入的密码不正确，还有{}次输入机会'.format(count))
        continue


# ————————————————
# 版权声明：本文为CSDN博主「geerniya」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
# 原文链接：https://blog.csdn.net/geerniya/article/details/77524173