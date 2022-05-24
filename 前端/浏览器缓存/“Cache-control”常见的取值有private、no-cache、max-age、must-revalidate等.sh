网页的缓存由HTTP消息头中的"Cache-Control" 来控制的，常见的取值有private、no-cache、max-age、must-revalidate等，默认为private。其作用根据不同的重新浏览方式分为以下几种情况：

（1） 打开新窗口
如果指定cache-control的值为private、no-cache、must-revalidate，那么打开新窗口访问时都会重新访问服务器。而如果指定了max-age值，那么在此值内的时间里就不会重新访问服务器，例如：
Cache-control: max-age=5
表示当访问此网页后的5秒内再次访问不会去服务器
cache-control
max-age 单位为秒
max-age>0 时 直接从游览器缓存中 提取
max-age<=0 时 向server 发送http 请求确认 ,该资源是否有修改
有的话 返回200 ,无的话 返回304.

age: 600
首部字段 Age 能告知客户端，源服务器在多久前创建了响应。字段值单位为秒。


Access-Control-Max-Age用来指定本次预检请求的有效期，单位为秒，，在此期间不用发出另一条预检请求。
例如：
resp.addHeader("Access-Control-Max-Age", "0")，表示每次异步请求都发起预检请求，也就是说，发送两次请求。
resp.addHeader("Access-Control-Max-Age", "1800")，表示隔30分钟才发起预检请求。也就是说，发送两次请求

（2） 在地址栏回车
如果值为private或must-revalidate（和网上说的不一样），则只有第一次访问时会访问服务器，以后就不再访问。如果值为no-cache，那么每次都会访问。如果值为max-age，则在过期之前不会重复访问。
（3） 按后退按扭
如果值为private、must-revalidate、max-age，则不会重访问，而如果为no-cache，则每次都重复访问
（4） 按刷新按扭
无论为何值，都会重复访问

当指定Cache-control值为“no-cache”时，访问此页面不会在Internet临时文章夹留下页面备份。
另外，通过指定“Expires”值也会影响到缓存。例如，指定Expires值为一个早已过去的时间，那么访问此网时若重复在地址栏按回车，那么每次都会重复访问：
Expires: Fri, 31 Dec 1999 16:00:00 GMT

https://www.cnblogs.com/tjws/p/3701937.html