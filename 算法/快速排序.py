# 快速排序算法通过多次比较和交换来实现排序，其排序流程如下： [2]
# (1)首先设定一个分界值，通过该分界值将数组分成左右两部分。 [2]

def quick_sort(arr):
    if len(arr) >= 2:
        left,right = [],[]
        mid = arr[(len(arr)-1)//2]
        arr.remove(mid)
        for item in arr:
            if item > mid:
                right.append(item)
            elif item <= mid:
                left.append(item)
        return quick_sort(left) + [mid] + quick_sort(right)
    else:
        return arr

if __name__ == '__main__':
    arr = [8,2,9,23,18,89,34,1,3,13,12,42,16,0,82,7,1,48,2,3,3,4,5]
    print(quick_sort(arr))