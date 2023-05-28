input_str = input("请输入：")

if input_str.isdigit():       #返回值为True表示输入的所有字符都是数字，否则，不是全部为数字
    print("您输入的全是数字！"+input_str)
else:
    print("您输入的不全是数字！")
# ————————————————
# 版权声明：本文为CSDN博主「全村最好捉的羊」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
# 原文链接：https://blog.csdn.net/crestroncarter/article/details/122367894
#
#
# Python3 基础语法
# 知识点：
#
# str为字符串
# str.isalnum() 判断所有字符都是数字
# str.isalpha() 判断所有字符都是字母
# str.isdigit() 判断所有字符都是数字
# str.islower() 判断所有字符都是小写
# str.isupper() 判断所有字符都是大写
# str.istitle() 判断所有单词都是首字母大写，像标题
# str.isspace() 判断所有字符都是空白字符、\t、\n、\r