# 选择排序的思路是：
# 第一轮的时候，所有的元素都和第一个元素进行比较，
# 如果比第一个元素大，就和第一个元素进行交换，在这轮比较完后，就找到了最小的元素；
# 第二轮的时候所有的元素都和第二个元素进行比较找出第二个位置的元素，以此类推。

import sys
def selection_sort(list):
    print(selection_sort.__name__)
    print(f"当前方法名：{sys._getframe().f_code.co_name}")
    length = len(list)
    for i in range(length - 1, 0, -1):
        for j in range(i):
            print(i,j)
            if list[j] > list[i]:
                list[j], list[i] = list[i], list[j]
    return list

if __name__ == '__main__':
    arr = [8,2,9,23,18,89,34,1,3,13,12,42,16,0,82,7,1,48,2,3,3,4,5]
    print(selection_sort(arr))
