我通过nginx反向代理解决跨域问题，启动项目，地址为localhost:8142, 然后配置nginx的8142端口。
nginx报错

nginx: [emerg] bind() to 0.0.0.0:8142 failed
(10013: An attempt was made to access a socket in a way forbidden by its access permissions)

server {
        listen       8142;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location /Webapi {
            rewrite  ^.+Webapi/?(.*)$ /$1 break;
            include  uwsgi_params;
            proxy_pass   http://www.baidu.com;
       }


要么修改你nginx的监听端口, 要么改vue-cli配置的webpack配置的端口.

这是我nginx的配置, 监听80即页面默认端口.
当Nginx接收到api路径的时候, 转发给8070端口.会改写成(就是去掉/api,然后转发)http://127.0.0.1:8070/...

 server {
        listen       80;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location ^~/api/ {
            rewrite ^/api/(.*) /$1 break;
            proxy_pass http://127.0.0.1:8070;
        }
       ...
      }

这个是我测试环境的反向代理配置.
我前端测试的端口号是:8081
通过设置完这个proxyTable之后, 我的请求路径只要是定位为/api就会变成http://localhost/api/....

proxyTable: {
      '/api': {
        target: 'http://localhost/',
        changeOrigin: true,
        pathRewrite: {
          // '^/api': '' 这里注释掉了, 是因为我nginx配置好了拦截api, 所以这里不改写也没问题
        }
      }
    }



