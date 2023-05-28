# d = {'a':1, 'b':2, 'c':3,'aa':1, 'bb':2, 'cd':3}
# print(d)
# s = {}
# for key in list(d):
#     # d.pop(key)
#     if "a" in key:
#         d = {i:d.get(i) for i in d if "a" not in i and "bb" not in i}
#     # print(d)
#     if "b" in key:
#         # print("h")
#         s.update({"oo":0,"oop":8})
#         # d = d.update(s)
#         # print(d)
#     if "c" in key:
#         s.update({"h":9,"sq":7})
#         print('1sss')
# print(d)
# print(s)
# d.update(s)
# print(d)

a = ""
if a :
    print("hhh" )
if a is not None:
    print("aaa")

url = "http://qa.test2.com/api/nstatus?env=test2-t5"
import requests
res = requests.get(url)
print(res)

res = [i['service'] for i in res.json() if "2.0.0-SNAPSHOT-test1" in i['image']]
print(",".join(res))
