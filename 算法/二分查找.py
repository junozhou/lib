# 二分查找
## 前提是有序列表
# 每次将列表取半，进行比较再取半，如此以往
# 将表中间位置记录的关键字与查找关键字比较，如果两者相等，则查找成功；
# 否则利用中间位置记录将表分成前、后两个子表，如果中间位置记录的关键字大于查找关键字，则进一步查找前一子表，否则进一步查找后一子表
# 算法的时间复杂度是O(logN)
## 算法推演
# 如：列表长度为
# 1 -时间 1
# 2 -时间 1
# 4 -时间 2

def bin_find(arr, item):
    low = 0;
    high = len(arr) - 1
    while low <= high:
        mid = (low + high)//2
        if arr[mid] > item:
            high = mid - 1
        elif arr[mid] == item:
            return mid
        elif arr[mid] < item:
            low = mid + 1
        else:
            return -1

if __name__ == '__main__':
    arr = [0,4,5,6,7,8,89,99]
    print(bin_find(arr,9))