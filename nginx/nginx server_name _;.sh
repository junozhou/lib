【解释server_name _】的意思
经常在nginx中看到一段以下的server_name 匹配。在虚拟主机当中。
server_name _;
这里指定的不是什么特别的名字，它只是一个无效的域名。从来不会匹配任何真实名字相匹配。
如:
server {
  listen    8080;
  server_name _;
  access_log /data1/logs/nginx/monitor_access.log base;
  root /data1/www/other/monitor;
  location / { return 403; }

  location ~ "^/(monitor|apc|clear_apc)\.php$" {
    fastcgi_pass  php-fpm;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include    fastcgi_params;
  }
}

其中当访问:
curl -I http://localhost:8080/monitor.php

日志格式:

log日志为:
0.001 0.001 127.0.0.1 - unix:/dev/shm/php-fpm1.sock [30/Aug/2016:21:12:52 +0800] localhost "HEAD /monitor.php HTTP/1.1" 200 143 "-" "curl/7.19.7 (x86_64-redhat-linux-gnu) libcurl/7.19.7 NSS/3.16.2.3 Basic ECC zlib/1.2.3 libidn/1.18 libssh2/1.4.2" "-" "-" - "127.0.0.1"

其中localhost为nginx的 $host字段。

当其访问:
curl -I http://192.168.100.10:8080/monitor.php

log中$host为192.168.100.10

注意:
变量中$host
功能:该变量的值等于请求头中的Host值，如果Host无效时，那么就处理该请求的Server的名称。
注意:$host和$http_host变量有些情况是有区别的。$host不包括端口号。

疑问:
curl -I http://localhost:8080/monitor.php

server {
listen 8080;
server_name localhost;
root ...
location / {
.....
}
}

server {
listen 8080;
server_name _;
root ...
location / {
.....
}
}

上面两个虚拟主机，会被匹配到哪个呢？
-----------------------------------
©著作权归作者所有：来自51CTO博客作者cuizhiliang的原创作品，请联系作者获取转载授权，否则将追究法律责任
nginx server_name _;
https://blog.51cto.com/cuidehua/1844511