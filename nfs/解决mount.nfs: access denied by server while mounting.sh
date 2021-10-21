#在linux下挂载的时候突然出现： mount.nfs: access denied by server while mounting 。第一感觉是读取文件权限不够。
#
#然后准备去更改一下挂载点的权限，一看不对。因为其他服务器都能正常挂载那就是说明权限是正确的。
#
#然后问了下哥们，哥们说要添加一条记录到被挂载的服务器上。
#修改配置文件/etc/exports，加入 insecure 选项：
#
#?
#001
#vi /etc/exports
#添加一条：
#
#?
#/bank 255.255.255.255(rw,no_root_squash)
#/bank是挂载点，255.255.255.255是要挂载的IP。
#
#保存退出
#然后重启nfs服务：service nfs restart
#               或
#               systemctl restart nfs
#然后问题就解决了