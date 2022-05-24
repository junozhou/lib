
def bubble_sort(li):
    for i in range(len(li)-1):
        for j in range(len(li)-i-1):
            if li[j] > li[j+1]:

                li[j],li[j+1] = li[j+1],li[j]


def select_sort(li):
   for i in range(len(li)-1):
       minvalue = li[i]
       for j in range(len(li)-i-1):
           if li[j] < minvalue:
               minvalue = li[j]


def partion(li,left,right):
    tmp = li[left]
    while left < right:
        while left < right and li[right] >= tmp:
            right -= 1
        li[left] = li[right]
        while left < right and li[left] <= tmp:
            left += 1
        li[right] = li[left]
    li[left] = tmp


if __name__ == '__main__':
    li = [3,4,5,8,9,0,2,1,6,7]
    partion(li,1,len(li)-1)
    #bubble_sort(li)
    print(li)