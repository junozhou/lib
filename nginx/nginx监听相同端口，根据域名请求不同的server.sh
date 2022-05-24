#同时监听相同端口，可以通过匹配server_name 来决定最终匹配哪个server
    #server1
    server {
        listen       80;
        #server_name  localhost;

        location  / {
            rewrite / http://www.baidu.com;
        }
    }
    #server2
    server {
        listen       80;
        #uc-center.m.szy.net 在本地的hosts文件 解析到 127.0.0.1
        server_name  uc-center.m.szy.net;

        location  ~* ^\/(.*)$ {
           rewrite ^\/(.*)$ http://www.sina.com;
        }
    }



   例如:  访问   http://uc-center.m.szy.net  不会因为server1的配置，而导致跳转到“百度首页”。
              nginx会优先匹配 配置有server_name的server2,最终跳转到"新浪首页"。
https://blog.csdn.net/liaosiqian/article/details/54861270