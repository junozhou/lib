#Linux export 命令
#￼
#Linux export 命令用于设置或显示环境变量。
#在 shell 中执行程序时，shell 会提供一组环境变量。export 可新增，修改或删除环境变量，供后续执行的程序使用。export 的效力仅限于该次登陆操作。
#语法
#export [-fnp][变量名称]=[变量设置值]
#参数说明：
#* 		-f 　代表[变量名称]中为函数名称。
#* 		-n 　删除指定的变量。变量实际上并未删除，只是不会输出到后续指令的执行环境中。
#* 		-p 　列出所有的shell赋予程序的环境变量。
#实例
#列出当前所有的环境变量
# export -p //列出当前的环境变量值


export http_proxy=http://192.1.199.225:7701 && export https_proxy=http://192.1.199.225:7701 && python3 -m pip install aiohttp