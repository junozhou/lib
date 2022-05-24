# 方法1 使用file.seek，从文件尾部指定字节读取（推荐）：#
# 参考：Python read,readline,readlines和大文件读取
#
# Copy
def tail(filepath, n, block=-1024):
    with open(filepath, 'rb') as f:
        f.seek(0,2)
        filesize = f.tell()
        while True:
            if filesize >= abs(block):
                f.seek(block, 2)
                s = f.readlines()
                if len(s) > n:
                    return s[-n:]
                    break
                else:
                    block *= 2
            else:
                block = -filesize


if __name__ == '__main__':
    lines = tail('million_line_file.txt', 10)
    for line in lines:
        print(line)
# 注意：只有用b二进制的方式打开文件，才可以从后往前读！！！seek()方法才能接受负数参数
#
# 方法2 使用linecache：#
# 参考：Python读取大文件的最后N行
#
# Copy
import linecache

# 放入缓存防止内存过载
def get_line_count(filename):
    count = 0
    with open(filename, 'r') as f:
        while True:
            buffer = f.read(1024 * 1)
            if not buffer:
                break
            count += buffer.count('\n')
    return count


if __name__ == '__main__':
    # 读取最后30行
    file = 'million_line_file.txt'
    n = 30
    linecache.clearcache()
    line_count = get_line_count(file)
    print('num: ', line_count)
    line_count = line_count - 29
    for i in range(n):
        last_line = linecache.getline(file, line_count)
        print(line_count, last_line)
        line_count += 1

# 经测试，写入一个简单的一千万行的txt文件，在老的macbookpro上需要15-20秒，
# 使用这个方法，读取这个文件最后30行，只需要5秒左右。
#
# 作者： 王延刚
#
# 出处：https://www.cnblogs.com/wangyangang/p/python-read-big-file-last-n-lines.html
#
# 版权：本文采用「署名-非商业性使用-相同方式共享 4.0 国际」知识共享许可协议进行许可。