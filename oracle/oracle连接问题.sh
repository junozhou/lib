#cx_Oracle.DatabaseError: DPI-1047: Cannot locate a 64-bit Oracle Client library:
#"libclntsh.so: 无法打开共享对象文件: 没有那个文件或目录".
# See https://cx-oracle.readthedocs.io/en/latest/user_guide/installation.html for help

#可行
sudo sh -c "echo /usr/lib/oracle/18.5/client64/lib > /etc/ld.so.conf.d/oracle-instantclient.conf"
sudo ldconfig