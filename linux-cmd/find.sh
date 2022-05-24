find /log -name "*log*" -atime +10 -type f -print | xargs rm -f


测试 TESTS
       数字参数可以这样给出：

       +n     是比 n 大，

       -n     是比 n 小，

       n      正好是 n 。

       -amin n
              对文件的最近一次访问是在 n 分钟之前。

       -anewer file
              对文件的最近一次访问比 file 修改时间要晚。如果命令行中 -follow 在 -anewer 之前，(也只有在这种情况下) -anewer 会受 -follow 的影响。

       -atime n
              对文件的最近一次访问是在 n*24 小时之前。

       -cmin n
              对文件状态的最近一次修改是在 n 分钟之前。

       -cnewer file
              对文件状态的最近一次修改比 file 修改时间要晚。如果命令行中 -follow 在 -cnewer 之前，(也只有在这种情况下) -cnewer 会受 -follow 的影响。

       -ctime n
              对文件状态的最近一次修改是在 n*24 小时之前。

       -empty 文件是空的普通文件或者空目录。