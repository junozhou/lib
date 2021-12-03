# 冒泡排序
# 相邻两个元素进行比较
# 算法推论
## 第一个元素与后面的元素比较n-1次，当第一个元素比较完，还剩下n-1个无需当元素，以此类推
## 比较次数为 n-1+...+0, 即n*(n-1)/2次
# 用O()表示即为O(n2)


def buble_sort(arr):
    for i in range(len(arr)-1):
        for j in range(len(arr) - 1 - i):
            if arr[j] > arr[j+1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
    print(arr)
    return arr

if __name__ == '__main__':
    arr = [9,4,53,83,2,0,2]
    buble_sort(arr)