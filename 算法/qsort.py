

def qsort(arr):
    if len(arr) >= 2:
        left,right = [],[]
        mid = arr[(len(arr)-1)//2]
        arr.remove(mid)
        for i in arr:
            if i <= mid:
                left.append(i)
            elif i > mid:
                right.append(i)
        return qsort(left) + [mid] + qsort(right)
    else:
        return arr

if __name__ == '__main__':
    arr = [34,3,5,2,3,6,234,2,5,6,2,43,23,54,23,2,3,242,90]
    print(qsort(arr))