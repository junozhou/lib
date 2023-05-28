#2. utf8 & utf8mb4
#2.1 utf8
#是针对Unicode的一种可变长度字符编码。
#
#由于对可以用Ascll表示的字符，使用Unicode并不高效，因为Unicode比Ascll占用大一倍的空间，而对ASCII来说高字节的0对他毫无用处。
#
#为了解决这个问题，就出现了一些中间格式的字符集，他们被称为通用转换格式，即UTF（Unicode Transformation Format）。
#
#2.2 utf8mb4（mb4 = most bytes 4）
#所以utf8是utf8mb4的子集，除了将编码改为utf8mb4外不需要做其他转换。
#
#MySQL在5.5.3之后增加了这个utf8mb4的编码，mb4就是most bytes 4的意思，专门用来兼容四字节的unicode。好在utf8mb4是utf8的超集，除了将编码改为utf8mb4外不需要做其他转换。当然，为了节省空间，一般情况下使用utf8也就够了。
#
# 既然utf8应付日常使用完全没有问题，那为什么还要使用utf8mb4呢?
#
#低版本的MySQL支持的utf8编码，最大字符长度为 3 字节，如果遇到 4 字节的字符就会出现错误了。
#
#三个字节的 UTF-8 最大能编码的 Unicode 字符是 0xFFFF，也就是 Unicode 中的基本多文平面（BMP）。
#
#也就是说，任何不在基本多文平面的 Unicode字符，都无法使用MySQL原有的 utf8 字符集存储。
#
# 可以到以下的链接，看unicode编码区从1 ~ 126就属于传统utf8区,当然utf8mb4也兼容这个区,126行以下就是utf8mb4扩充区,什么时候你需要存储那些字符,你才用utf8mb4,否则只是浪费空间。
#————————————————
#版权声明：本文为CSDN博主「骑台风走」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/qq_52385631/article/details/123019036
#

原载于:转www.载for网站制作学习asp必.cn究
 Mysql 现在在创建数据库时，因为有表情等符号，需要创建utf8mb4 字符集，这样就在操作相关符号的时候就不会报错了。

但在创建 数据库时有个collation 数据集合时 有选择对应 utf8mb4_general_ci utf8mb4_bin 选择。

那 utf8mb4_general_ci utf8mb4_bin 有什么区别呢？ utf8_general_ci utf8_bin 又又什么区别呢？



对比

 utf8mb4_general_ci: 不区分大小写， utf8mb4_general_cs 区分大小写 　　

utf8mb4_bin: 将字符串每个字符串用二进制数据编译存储，区分大小写，而且可以存二进制的内容。 　　

utf8mb4_unicode_ci: 校对规则仅部分支持Unicode校对规则算法,一些字符还是不能支持；utf8mb4_unicode_ci不能完全支持组合的记号。 　　



说明

	ci 是 case insensitive, 即 "大小写不敏感", a 和 A 会在字符判断中会被当做一样的。

	bin 是二进制, a 和 A 会别区别对待。（例如你运行:SELECT * FROM table WHERE txt = 'a'， 那么在utf8mb4_bin中你就找不到 txt = 'A' 的那一行, 而 utf8mb4_general_ci 则可以。）

utf8mb4_general_ci 是一个遗留的校对规则，不支持扩展，它仅能够在字符之间进行逐个比较。这意味着utf8mb4_general_ci校对规则进行的比较速度很快，但是与使用 utf8mb4_unicode_ci的校对规则相比，比较正确性较差。



应用上的差别

	对于一种语言仅当使用utf8mb4_unicode_ci排序做的不好时，才执行与具体语言相关的utf8mb4字符集校对规则。例如，对于德语和法语，utf8mb4_unicode_ci工作的很好，因此不再需要为这两种语言创建特殊的utf8mb4校对规则。 　　

utf8mb4_general_ci 也适用德语、法语或者俄语，但会有不准。如果你的应用能够接受这些，那么应该使用 utf8mb4_general_ci，因为它速度快。否则，使用utf8mb4_unicode_ci，因为它比较准确。



使用

	utf8mb4_unicode_ci比较准确，utf8mb4_general_ci速度比较快。通常情况下，新建数据库时一般选用 utf8mb4_general_ci

转自：http://anna.52inlove.com/blog/202009151553.html



CREATE DATABASE IF NOT EXISTS test
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_0900_ai_ci;
