１．分割 -- split命令

可以指定按行数分割和按字节大小分割两种模式。
(1) 按行数分割
split -l 300 large_file.txt new_file_prefix

加上-d，使用数字后缀；加上--verbose，显示分割进度
split -l 50000 -d large_file.txt part_ --verbose

(2) 按字节大小分割
split -b 10m large_file.log new_file_prefix

2.合并 -- cat命令
cat part_* > merge_file.txt

