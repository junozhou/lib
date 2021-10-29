1、mac安装vim

   brew install vim   //Mac在安装Homebrew后，安装vim的方法
2、进入家目录

  cd ～
3、克隆configures到家目录

  git clone https://github.com/hicqu/configures
4、configures文件夹里面的dot_vim复制到家目录

cp -rf configures/dot_vim .   //dot_vim复制到家目录
rm -rf .vim  //删除家目录下的.vim目录
mv dot_vim .vim   //dot_vim从命名为.vim
5、命令行输入vim

  vim  //这时候看到的就是刚才安装的新版vim了
  :PlugInstall  //安装插件，安装完成后vim就配置完成了
其他Linux系统也可以用，方法一样，只是安装vim的命令可能不同～～～