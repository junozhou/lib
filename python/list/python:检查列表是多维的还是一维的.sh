>>> a = [1, 2, 3, 4]
>>> isinstance(a, list)
True
>>> isinstance(a[0], list)
False
>>> isinstance(a[0], int)
True
>>> b = [[1,2,3], [4, 5, 6], [7, 8, 9]]
>>> isinstance(b[0], list)
True