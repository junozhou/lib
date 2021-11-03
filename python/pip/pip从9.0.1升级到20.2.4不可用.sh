背景介绍：
系统提示我升级pip，我就把它升级了：

You are using pip version 9.0.1, however version 20.3.4 is available.
You should consider upgrading via the 'pip install --upgrade pip' command

我就使用命令升级：

pip install --upgrade pip
此命令会失败
需要在后面加 --user
即：
pip install --upgrade pip --user

pip --version #仍然是9。0。1
此时：

原来是版本信息需要自己手动更新
[root@localhost bin]# where pip
/usr/local/bin/pip
[root@localhost bin]# vim pip

#!/usr/bin/python
# EASY-INSTALL-ENTRY-SCRIPT: 'pip==9.0.1','console_scripts','pip'
__requires__ = 'pip==20.3.4'
import sys
from pkg_resources import load_entry_point

if __name__ == '__main__':
    sys.exit(
        load_entry_point('pip==20.3.4', 'console_scripts', 'pip')()
    )
~


[root@localhost bin]# pip -V
pip 20.3.4 from /Users/zhouxiaoyan/Library/Python/2.7/lib/python/site-packages/pip (python 2.7)
#————————————————
#版权声明：本文为CSDN博主「Frost-xie」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/xys2333/article/details/109291167