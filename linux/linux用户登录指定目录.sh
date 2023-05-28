一、创建用户和用户组

[root@web4 lianyu]#  groupadd lianyu
[root@web4 lianyu]#  useradd lianyu -g lianyu
[root@web4 lianyu]#  passwd lianyu
二、用户登录指定目录

[root@web4 lianyu]# cd /home/lianyu
[root@web4 lianyu]# ls -a
.  ..  .bash_history  .bash_logout  .bash_profile  .bashrc  .cache  CATALINA_HOME_IS_UNDEFINED  .config  .dubbo  .ssh  .viminfo
编辑.bash_profile，来指定：

# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

export IPOWER_HOME=/usr/local/

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

cd $IPOWER_HOME  # 可以直接指定登录目录  即：cd /log



# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

export IPOWER_HOME=/data/log/

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

cd /data/log/  # 可以直接指定登录目录  即：cd /log