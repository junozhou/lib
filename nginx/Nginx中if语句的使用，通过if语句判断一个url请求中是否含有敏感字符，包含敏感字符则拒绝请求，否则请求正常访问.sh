1、正则表达式匹配：

符号	说明
==	等值的比较
~	与指定正则表达式模式匹配，区分字符大小写
~*	与指定正则表达式模式匹配，不区分字符大小写
!~	与指定正则表达式模式不匹配，区分字符大小写
!~*	与指定正则表达式模式不匹配，不区分字符大小写
2.文件及目录匹配：

符号	说明
-f ,!-f	判断指定路径的文件是否存在
-d, !-d	判断指定路径的目录是否存在
-e, !-e	判断指定路径的文件或目录是否存在
-x, !-x	判断指定路径的文件是否存在且可执行
-r,!-r	判断指定路径的文件是否存在且可读
-w,!-w	判断指定路径的文件是否存在且可写
3.通过if语句判断一个url请求中是否含有敏感字符，包含敏感字符则拒绝请求，否则请求正常访问。
nginx变量：
$server_addr :获取服务器ip
$request_uri : 获取url请求
$arg_paramsName :获取请求参数paramsName
$http_host :获取客户端host
$scheme :获取http或https协议

nginx.conf配置：

server {
		listen 8899;
		server_name localhost;
		location /{
			#获取url完整请求
			set $URL  $scheme://$http_host$request_uri;
			#根据获取的URL匹配一些限制字符，满足条件拒绝访
			#这里以www字符为例，可自行修改
			if ($URL ~ "www"){
				echo "请求带有敏感字符'www',拒绝访问!";
				#重定向到百度
				#rewrite ^/(.*) http://www.baidu.com/ permanent;
				}
			echo "正常访问,url=" $URL;
		}
	}
访问带有www字符：curl http://127.0.0.1:8899/test?params=www.qq.com&code=1234&msg=helloworld

[root@ZYL /]# curl http://127.0.0.1:8899/test?params=www.qq.com&code=1234&msg=helloworld
[1] 37147
[2] 37148
[root@ZYL /]# 请求带有敏感字符'www',拒绝访问!

访问不带www字符：http://127.0.0.1:8899/test?params=w.qq.com&code=1234&msg=helloworld

[root@ZYL /]# curl http://127.0.0.1:8899/test?params=w.qq.com&code=1234&msg=helloworld
[1] 37149
[2] 37150
[root@ZYL /]# 正常访问,url= http://127.0.0.1:8899/test?params=w.qq.com
注：在nginx中不支持if else的多重判断。