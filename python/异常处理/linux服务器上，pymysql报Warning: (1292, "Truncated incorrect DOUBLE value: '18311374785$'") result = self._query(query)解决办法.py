# linux服务器上，pymysql报Warning: (1292, "Truncated incorrect DOUBLE value: '18311374785$'") result = self._query(query)解决办法
# 是由于pymysql版本太低了，发现版本是0.9.3
#
# 卸载该版本pip3 uninstall pymysql
#
# 安装新版本0.10.1，pip3 install pymysql==0.10.1（高于该本版的应该都可以，没做尝试）