["???","???","???","???"]


#为此查看 pymysql.connect 的参数发现  有charset 这个属性 默认是空：只支持“utf8” 这种格式。不支持“utf-8”
pymysql.connect(host="127.0.0.1", user="root", password="root", db="test", charset='utf8')



