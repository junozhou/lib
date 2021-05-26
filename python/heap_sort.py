import heapq
def heap_sort(iter):
    h = []
    for i in iter:
        heapq.heappush(h,i)
    h_sort = [heapq.heappop(h) for i in range(len(h))]
    print(h_sort)
    return h_sort

if __name__ == '__main__':
    i = [9,3,38,673,0,38733,278]
    heap_sort(i)
