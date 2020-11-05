https://www.cnblogs.com/eoalfj/p/10590604.html

需要导出一些稍微复杂的数据，用Python处理很方便

环境
Win10
Python 3.7.0
Oracle 11g
安装依赖
安装 cx_Oracle 模块
pip install cx_Oracle
安装 Oracle 客户端
去官网下载 64 位 Windows 客户端

instantclient-basic-windows.x64-11.2.0.4.0.zip
解压安装
并将解压路径配置到环境变量 PATH 中

E:\instantclient_11_2
代码示例
import os
import cx_Oracle
import xlwt

# 解决 Oracle 乱码问题
# 或 os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.AL32UTF8'
os.environ['NLS_LANG'] = 'SIMPLIFIED CHINESE_CHINA.UTF8'

conn = cx_Oracle.connect('username/password@127.0.0.1/orcl')
cursor = conn.cursor()

cursor.execute("select 'hello', 'world!' from dual")
rows = cursor.fetchall()
for row in rows:
    print(row[0], row[1])
cursor.close()
conn.close()

输出

hello world!