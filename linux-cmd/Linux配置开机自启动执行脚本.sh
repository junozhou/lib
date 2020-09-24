系统启动时需要加载的配置文件

/etc/profile、/root/.bash_profile
/etc/bashrc、/root/.bashrc
/etc/profile.d/*.sh、/etc/profile.d/lang.sh
/etc/sysconfig/i18n、/etc/rc.local（/etc/rc.d/rc.local）

# 1.编辑rc.local文件
[root@localhost ~]# vi /etc/rc.local
#备注---start
#/etc/rc.local，该文件为链接文件
#
#[root@c69-01 ~]# ll /etc/rc.local
#lrwxrwxrwx. 1 root root 13 Feb  5 10:03 /etc/rc.local -> rc.d/rc.local
#备注---end


# 2.修改rc.local文件，在 exit 0 前面加入以下命令。保存并退出。
/etc/init.d/mysqld start                                         # mysql开机启动
/etc/init.d/nginx start                                          # nginx开机启动
supervisord -c /etc/supervisor/supervisord.conf                  # supervisord开机启动
/bin/bash /server/scripts/test.sh >/dev/null 2>/dev/null
/home/run-dd.sh

# 3.最后修改rc.local文件的执行权限
[root@localhost ~]# chmod +x  /etc/rc.local
[root@localhost ~]# chmod 755 /etc/rc.local