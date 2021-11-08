#可能的原因是因为Flask 的版本与 Werkzeug 的组件版本不兼容，也就是出现一新一旧的问题
#例如可能使用的flask是没有超过1.0版本的，那么这个时候Werkzeug用的是超过1.0版本的
#解决方案一： (已经试过可行)
#降低Werkzeug版本为0.16版本如下：

pip uninstall Werkzeug
pip install Werkzeug==0.16

#方案二：
pip uninstall Flask
pip uninstall Werkzeug
pip install Flask   # 目前安装的版本为1.1.2

或pip install Flask  -i http://pypi.douban.com/simple/ --trusted-host pypi.douban.com