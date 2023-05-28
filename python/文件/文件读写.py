a = []
with open('test1.txt', 'r') as f1:
    for i in f1.readlines():
        i = i.rstrip('\n')
        a.append(i)
        print(i)
print(",".join(a))
# # 对于read()和readline()也是把'\n'读入了，但是print的时候可以正常显示（因为print里的'\n'被认为是换行的意思）
# with open("log_file", 'w') as fd:
#     fd.write("======")