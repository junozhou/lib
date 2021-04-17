（一）问题：

假如我们现在有两台机器：ServerA和ServerB，现在想要让ServerA不用输入密码就能够进行访问。

（二）方法和原理：

我们使用ssh-keygen在ServerA上生成private和public密钥，将生成的public密钥拷贝到远程机器ServerB上后,就可以使用ssh命令无需密码登录到另外一台机器ServerB上。

在linux系统中,ssh是远程登录的默认工具,因为该工具的协议使用了RSA/DSA的加密算法【默认是DSR算法】，该工具做linux系统的远程管理是非常安全的。

（三）实验步骤：

1.登录ServerA

2.ssh-keygen -t rsa，将会生成公钥和私钥文件id_rsa和id_rsa.pub【如果一直回车下去，最后这两个文件应该在/home/$USER/.ssh下面】

3.将 .pub 文件复制到ServerB机器的 .ssh 目录下，并保存为authorized_keys

可以使用：

ssh-cop-id命令会将指定的公钥文件复制到远程计算机

[oracle@Test232 ~]$ ssh-copy-id -i ~/.ssh/id_rsa.pub oracle@192.168.55.232
28
oracle@192.168.55.232's password:
Now try logging into the machine, with "ssh 'oracle@192.168.55.232'", and check in:


  .ssh/authorized_keys


to make sure we haven't added extra keys that you weren't expecting.
[oracle@Test232 ~]$ ssh oracle@192.168.55.232
oracle@192.168.55.232's password:
Last login: Thu Nov 24 16:05:32 2011 from 192.168.55.229
[oracle@Test232 ~]$