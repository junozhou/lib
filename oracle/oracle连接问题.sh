#cx_Oracle.DatabaseError: DPI-1047: Cannot locate a 64-bit Oracle Client library:
#"libclntsh.so: 无法打开共享对象文件: 没有那个文件或目录".
# See https://cx-oracle.readthedocs.io/en/latest/user_guide/installation.html for help

#可行
sudo sh -c "echo /usr/lib/oracle/18.5/client64/lib > /etc/ld.so.conf.d/oracle-instantclient.conf"
sudo ldconfig



Cannot locate a 64-bit Oracle Client library: "dlopen(libclntsh.dylib"

Mac OS 下报错DPI-1047: Cannot locate a 64-bit Oracle Client library: "dlopen(libclntsh.dylib, 1): image not found".
问题：python3连接oracle报错：Cannot locate a 64-bit Oracle Client library: "dlopen(libclntsh.dylib, 1): image not found".

经过分析发现：需要安装64位Oracle即时客户端基本或基本轻包库.

1、去官网下载合适的instantclient

下载地址如下：http://www.oracle.com/technetwork/topics/intel-macsoft-096467.html。

选择合适的依赖包，我这里下载的是：instantclient-basic-macos.x64-19.8.0.0.0dbru.dmg
2、双击打开，按照文件夹中的INSTALL_IC_README.txt文件中的步骤去执行

./install_ic.sh
3、配置环境变量

将第二步中拿到的解压包放到某个路径下，我这里是/usr/local/lib，这个可以根据自己的需要，但要记住这个路径

将该路径配置到~/.zshrc文件中

配置内容如下：

export ORACLE_HOME=/usr/local/lib/instantclient_19_8

export PATH=$PATH:$ORACLE_HOME

export DYLD_LIBRARY_PATH=$ORACLE_HOME:$DYLD_LIBRARY_PATH

配置完成，执行：

source ~/.zshrc


自此仍然失败
libclntsh.dylib 文件符号链接到后面的目录 /usr/local/lib 方可链接
cd /usr/local/lib
ln -s /usr/local/lib/instantclient-basic-macos.x64-19.8.0.0.0dbru/libclntsh.dylib libclntsh.dylib

