# 时间复杂度
# 算时间复杂度的时候，看有没有for/while循环，
# 如果有一般是O(n)、O(log n)等
# 没有，则一般是常量，执行时间不受num规模的影响。O(1)

def test(num):
    total = 0     # 执行时间记作a
    for i in range(num):
        total += i  #执行时间记作b
    return total    #执行时间记作c

# 总执行时间是 = a + b*num + c
# 计算时间复杂度的时候，不考虑系数，而对时间影响最大的是num的规模，所以此函数的时间复杂度记为：O(n)

# O(1)
def O1(num):
    i = num     # 执行时间记作 a
    j = num * 2 # 执行时间记作 b
    return i+j

# 执行时间为：a + b

# O(n)
def on(num):
    total = 0
    for i in range(num):
        total += i
    return total

# O(log n)
def ologN(num):
    i = 1
    while (i < num):
        # 执行时间 a ，i = i * 2执行次数为 log2^n，算法时间复杂度 记作O(log n)。
        # 这条语句每次执行完后与num进行比较，小于num则继续执行这条语句，其他则返回i
        i = i * 2
    return i

# O(m+n)
# 表示有两个循环,是并列的
def omn(num1, num2):
    total = 0
    for i in range(num1):
        total += i
    for j in range(num2):
        total += j
    return total

# O（nlogN）
# 两个循环，是嵌套的
def onlogn(num1,num2):
    total = 0
    j = 0
    for i in range(num1):
        while(j < num2):
            total += i + j
            j = j * 2

    #     以上两条语句执行时间算在一块儿，当作 a。j = j * 2表示内层循环执行 logn次，算上外层循环，算法复杂度为：O(nlogn)
    return total

# O(n^2)

def on2(num):
    total = 0
    for i in range(num):
        for j in range(num):
            total += i + j
    #     以上两条语句执行时间算在一块儿，当作 a。total += i + j表示内层循环执行 n次，算上外层循环，算法复杂度为：O(n^2)
    return total

# O(1) < O(logn) < O(n) < O(nlogn) < O(n2)
#        二分查找          排序多为这个

if __name__ == '__main__':
    print(ologN(10))


