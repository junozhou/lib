# reqests get\put\post\delete api
# import requests
# requests.get(url, params=None, **kwargs)
# requests.put(url, data=None, **kwargs)
# requests.post(url, data=None, json=None, **kwargs)
# requests.delete(url, **kwargs)


####### python post
import json
import requests

headers = {'content-type': "application/json"}
url=""
body=""

response = requests.post(url, data = json.dumps(body), headers = headers)
# ========================

#!/usr/bin/env python
# -*- coding: utf-8 -*-
import requests
import json
url = 'http://official-account/app/messages/group'
body = {"type": "text", "content": "测试文本", "tag_id": "20717"}
headers = {'content-type': "application/json", 'Authorization': 'APP appid = 4abf1a,token = 9480295ab2e2eddb8'}
#print type(body)
#print type(json.dumps(body))
# 这里有个细节，如果body需要json形式的话，需要做处理
# 可以是data = json.dumps(body)
response = requests.post(url, data = json.dumps(body), headers = headers)
# 也可以直接将data字段换成json字段，2.4.3版本之后支持
# response  = requests.post(url, json = body, headers = headers)
# 返回信息
print(response.text)
# 返回响应头
print(response.status_code)


####### python put
import json
import requests

headers = {'content-type': "application/json"}
url=""
body=""

response = requests.put(url, data = json.dumps(body), headers = headers)


###### python get
# python发送get请求
# get请求无参数时可以直接发送
#
# 有参数时可以将参数写到url后面发送，格式为：http://test?token=xxx
#
# 最推荐的方法：
#
# 将参数写为字典格式，使用params发送
#
# 1、无参数get请求

import requests

url = "http://test/doku.php"

res = requests.get(url)

print(res.text)

# 2、带参数get请求

import requests

url = "http://test/api/auth/me?token=xxx"

res = requests.get(url)

print(res.text)

# ②建议使用此种格式，将参数写成字典格式，方便未来修改

import requests

url = "http://test/api/auth/me"

params = {"token":"xxxx"}

res = requests.get(url=url,params=params, headers = headers)

print(res.text)


###### python delete

import requests

url = "http://test/api/auth/me"

params = {"token":"xxxx"}

res = requests.delete(url=url, headers = headers)


print(res.text)


###############
# python request.args 解析
# requst.args 获得的是 列表类型
# 原始 aa=ff&&bb=gg 通过request.args 分解为 ImmutableMultiDict([('page', u'10')])
# 列表类型 -》 todict -》 urlencode 转换为url格式的字符串


