import re

text = '你好！吃早饭了吗？再见。'
t = re.split('。|！|？',text)
print(t)

text = '4d28h'
text = '4h'
t = re.split('d|h|m|s',text)
print(t)
