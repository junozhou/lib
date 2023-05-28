#python 连接接口报错
#报错如下：

aiohttp.client_exceptions.ClientConnectorCertificateError: Cannot connect to  host:443 ssl:True [SSLCertVerificationError: (1, '[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: self signed certificate in certificate chain (_ssl.c:1056)')]

SSL handshake failed on verifying the certificate
protocol: <asyncio.sslproto.SSLProtocol object at 0x000000B1D4E2A7F0>
transport: <_SelectorSocketTransport fd=708 read=polling write=<idle, bufsize=0>>


#解决方案：

# conn = aiohttp.TCPConnector(verify_ssl=False)  # 防止ssl报错
async with aiohttp.ClientSession(connector=aiohttp.TCPConnector(verify_ssl=False)) as session:
#加上verify_ssl=False后成功。


#————————————————
#版权声明：本文为CSDN博主「怪异的bug」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/eternal_tc/article/details/107482183


