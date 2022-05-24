一、环境说明
两台linux服务器，其中一台通过NFS挂载了另一台机器的一个目录。由于该机器出现问题，无法在mount一端的目录中进行写操作，此时需要将该目录umount后再次mount。在umount时失效。

二、mount 中-l 参数说明
man umount:
 -l     Lazy  unmount.  Detach the filesystem from the filesystem hierarchy now, and
              cleanup all references to the filesystem as soon as it is not busy  anymore.
              (Requires kernel 2.4.11 or later.)
有些时候，可能某些设备(通常是  CD-ROM )正忙或无法响应时umount时会失败，在此时可以使用umount -l <挂载点|设备>方式，此命令将会断开设备并关闭打开该设备的全部句柄。这就是lazy umount。

三、实例
1. 说明
两台机器分别:172.16.211.129/130
129机器 mount 130机器/home/sam目录到/test目录

2. 检查环境
[root@sam /]# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda5              34G   26G  6.4G  80% /
tmpfs                 997M   88K  997M   1% /dev/shm
/dev/sda1             194M   52M  133M  29% /boot
/dev/sda3             2.0G   68M  1.9G   4% /tmp
172.16.211.130:/home/sam
                       34G   27G  4.7G  86% /test
3. umount失败
[root@sam /]# umount /test
/test was not found in /proc/mounts
/test was not found in /proc/mounts

4. umount 使用 -l 参数后成功
[root@sam /]#  umount  -l  /test

5. 检查umount成功
[root@sam /]# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda5              34G   26G  6.4G  80% /
tmpfs                 997M   88K  997M   1% /dev/shm
/dev/sda1             194M   52M  133M  29% /boot
/dev/sda3             2.0G   68M  1.9G   4% /tmp

6. 再次mount成功
[root@sam /]# mount -t nfs -o  rw 172.16.211.130:/home/sam /test
7. 检查mount成功结果
[root@sam /]# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda5              34G   26G  6.4G  80% /
tmpfs                 997M   88K  997M   1% /dev/shm
/dev/sda1             194M   52M  133M  29% /boot
/dev/sda3             2.0G   68M  1.9G   4% /tmp
172.16.211.130:/home/sam
                       34G   27G  4.7G  86% /test

8. 测试在/test中写文件，恢复正常

四、总结
       碰到这个问题时，通常人们会想到重启动机器 ，但是做为一名DBA人员，数据库服务器重启动总是要小心，格外的小心，所以熟练使用参数来完成想要的完成的工作是必备技能，又在学习的道路上掌握了umount -l 方法。oh yeah!
来自 “ ITPUB博客 ” ，链接：http://blog.itpub.net/26148431/viewspace-1787523/，如需转载，请注明出处，否则将追究法律责任。

转载于:http://blog.itpub.net/26148431/viewspace-1787523/

相关资源：linux中mount/umount命令的基本用法及开机自动挂载方法

