#一）接口入参准备：
#
#url地址：http://httpbin.org/post
#
#入参：

# <?xml version="1.0" encoding = "UTF-8"?>
# <COM>
#     <REQ name="多测师_王sir">
#         <USER_ID>duoceshi</USER_ID>
#         <COMMODITY_ID>123456</COMMODITY_ID>
#         <SESSION_ID>DwO68dQFBg9xIizKsC6RhaeHRxqIT9nmU</SESSION_ID>
#     </REQ>
# </COM>

#二）把上面入参内容保存放入到duoceshi.xml文件中：
#
#
#三）发送接口请求：

#coding=utf-8
'''
python处理xml格式入参的接口
'''

#1.先把xml入参用open函数读出来变为字符串
def read_xml():
    '''
    读取xml文件
    :return:
    '''
    f = open('duoceshi.xml',"r")
    body = f.read()
    #print(body)
    return body

#2.发送接口请求
import requests

class Api_Test(object):

    def send_post(self):
        url = "http://httpbin.org/post"
        r = requests.post(url, data=read_xml())
        print(r.text)

if __name__ == '__main__':
    api = Api_Test()  #创建对象
    api.send_post()   #调用实例方法

#四）查看响应体的内容：

{
  "args": {},
  "data": "<?xml version=\"1.0\" encoding = \"UTF-8\"?>\n　　　　　　 <COM>\n       　　　　 　　<REQ name=\"\u591a\u6d4b\u5e08_\u738bsir\">\n        　　　　　　 　　<USER_ID>duoceshi</USER_ID>\n        　　　　　　 　　<COMMODITY_ID>123456</COMMODITY_ID>\n        　　　　　　 　　<SESSION_ID>DwO68dQFBg9xIizKsC6RhaeHRxqIT9nmU</SESSION_ID>\n    　　　　　 　　　</REQ>\n　　　　　　 </COM>\n\n\n",
  "files": {},
  "form": {},
  "headers": {
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate",
    "Content-Length": "248",
    "Host": "httpbin.org",
    "User-Agent": "python-requests/2.22.0",
    "X-Amzn-Trace-Id": "Root=1-5eb7ea8e-2b31c719d1ecd8f197e39c12"
  },
  "json": None,
  "origin": "222.65.223.177",
  "url": "http://httpbin.org/post"
}

#原文链接： https://www.cnblogs.com/xiaoshubass/p/12864757.html
#-----------------------------------
#Python+requests库发送接口入参为xml格式的接口请求
#https://blog.51cto.com/icestick8586/2497332