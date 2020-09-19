#!/usr/bin/env bash

#解决每次git pull需要输入用户名密码的问题
#问题描述
#在服务器上每次执行git pull，都提示输入用户名和密码
#
#现象分析
#我们在git clone工程时有2中形式 https 和git@git。当你使用前者拉取工程时每次都需要输入用户名和密码

#解决方案
#1.执行下面命令

git config --global credential.helper store
#这个时候~/.gitconfig文件中会多一行
#
#[credential]
#helper = store
#
#2.执行git pull再次输入用户名和密码
#
#此时你会看到/root/.git-credentials中会多一行内容。里面的内容类似https://{username}:{password}@github.com这种形式

#作者：缘来是你ylh
#链接：https://www.jianshu.com/p/faba73a28a7c
#来源：简书
#著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。