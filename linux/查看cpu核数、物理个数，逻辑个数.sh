# 查看物理CPU个数：主板上实际插入的cpu数量，可以数不重复的 physical id 有几个（physical id）
# 总核数 = 物理CPU个数 X 每颗物理CPU的核数
# 总逻辑CPU数 = 物理CPU个数 X 每颗物理CPU的核数 X 超线程数

# 查看物理CPU个数
cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l

# 查看每个物理CPU中core的个数(即核数)
cat /proc/cpuinfo| grep "cpu cores"| uniq

# 查看逻辑CPU的个数
cat /proc/cpuinfo| grep "processor"| wc -l




cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l

或grep 'physical id' /proc/cpuinfo | sort -u | wc -l



# 查看每个物理CPU中core的个数(即核数)：单块CPU上面能处理数据的芯片组的数量，如双核、四核等 （cpu cores）

cat /proc/cpuinfo| grep "cpu cores"| uniq

或者grep 'core id' /proc/cpuinfo | sort -u | wc -l



# 查看逻辑CPU的个数：简单来说，它可使处理器中的1颗内核，如2颗内核那样在操作系统中发挥作用。
#所有：逻辑cpu的个数=物理cpu个数*cpu的核数*2

cat /proc/cpuinfo| grep "processor"| wc -l

或者grep 'processor' /proc/cpuinfo | sort -u | wc -l

# 查看CPU信息（型号）
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c

或者dmidecode -s processor-version

#load average这个输出值

它所包含的信息是在一段时间内CPU正在处理及等待CPU处理的进程数之和的统计信息，也就是CPU使用队列的长度的统计信息。这三个值的大小一般不能大于系统逻辑CPU的个数。

比如一台服务器有4个逻辑CPU，如果load average的三个值长期大于4时，说明CPU很繁忙，负载很高，可能会影响系统性能；

但是偶尔大于4时，倒不用担心，一般不会影响系统性能。

CPU负载小于等于"内核数乘以0.5-0.7"算是一种理想状态。比如2个6核的cpu，理想的负载是小于等于2*6*0.5=6，最好不要超过超过8.4，否则性能多多少少都会受影响。