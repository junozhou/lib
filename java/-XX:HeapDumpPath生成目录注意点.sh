-XX:HeapDumpPath生成目录注意点
使用-XX:HeapDumpPath配置的时候，需要保证目录的文件夹都是存在，因为它在到处dump文件的时候，不会帮你去创建不存在的目录。

使用相对路径：


nohup java -Xms512M -Xmx512M -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./  -jar order-0.0.1-SNAPSHOT.jar  >/dev/null 2>&1 &
使用绝对路径：

nohup java -Xms512M -Xmx512M -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/usr/local/log/  -jar order-0.0.1-SNAPSHOT.jar  >/dev/null 2>&1 &


————————————————
版权声明：本文为CSDN博主「面包君123」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/u010772230/article/details/104470041