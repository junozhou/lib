



https://blog.csdn.net/zhuchunyan_aijia/article/details/126236429

背景:

    安装mongo的主机,磁盘告警. 需要分析哪些表太大, 然后分析是否可以drop掉

处理过程:



查看库的大小
>use  xxxdbname
>db.stats();

也可以, 每个库的大小
> show dbs;

表的大小:统计信息
>db.collectname.stats();

----表的大小明细----
数据大小
>db.getCollection("aaa").dataSize()

为collection分配的空间大小，包括未使用的空间
> db.getCollection("aaa").storageSize()

collection中索引数据大小
> db.getCollection("aaa").totalIndexSize()

collection中索引+data所占空间
> db.getCollection("aaa").totalSize()



脚本方式并进行排序
db = db.getSiblingDB('dbname');
db.auth('user','passwd');

var collNames = db.getCollectionNames();
for (var i = 0; i < collNames.length; i++)
    {   var coll = db.getCollection(collNames[i]);
        var stats = coll.stats(1024 * 1024);
        var  tatalSize=coll.totalSize()
        print(stats.ns,tatalSize);
     }


执行:

mongo ip:port  11.sh >11.log
使用shell 排序



sort 命令，Linux sort 命令详解：对文本文件中所有行进行排序。 - Linux 命令搜索引擎

# -n是按照数字大小排序，-r是以相反顺序，-k是指定需要排序的栏位，-t指定栏位分隔符为冒号

sort -nrk 3 -t: sort.txt

sort -nrk 2  11.log
 排序好后,前一位的都是数据量占用最多的. 可以分析drop掉
————————————————
版权声明：本文为CSDN博主「我家小宝_朱朱」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/zhuchunyan_aijia/article/details/126236429