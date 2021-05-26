#1、 Flask-restful路由实现url后面跟多个参数
from flask import Flask,jsonify
from flask_restful import Api
app = Flask(__name__)
api = Api(app)
api.add_resource(Todo, root + '/<int:page>/<int:limit>', endpoint)
# 如上代码中，url后面跟了两个参数，page表示分页的第几页，limit表示每页要显示的条目数


# 2、路由变量
# 2.1、绑定动态URL
# 有时我们需要将同一类 URL 映射到同一个视图函数处理，
# 比如：使用同一个视图函数来显示不同用户的个人信息。这时可以设置路由变量让视图函数可以绑定动态URL。
#
# # 设置路由变量  格式:  <路由变量>
@app.route('/user/<user_id>')
def user_info(user_id):
    print(user_id)
    res={}
    res['code'] = "0"
    res['data'] = ""
    return jsonify(res)
# 一旦设置了路由变量, 必须在视图函数设置同名的参数, 用于接收URL的动态部分


# 3、如上面代码，当你请求 /user/<user_id> 的时候，user_info，就能返回当前所有的数据信息
#
# 他是通过jsonify来进行返回的，这里需要注意的是，有2种方法可以返回json数据，一个是jsonify，还有一个是json.dumps()
#
# 那么2者有什么区别呢？可以看下图

# jsonify直接返回的是Content-type:application/json的响应对象(Response对象)
#
# json.dumps返回的，则是Content-type:text/html,charset=utf-8的HTML格式


# 4、flask-restful 重点
# https://blog.csdn.net/qq_28877125/article/details/77371065

# https://www.jianshu.com/p/ed1f819a7b58 简书
# 

