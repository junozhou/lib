import sys
def create():
    print(f"当前方法名：{sys._getframe().f_code.co_name}")

create()
# >>> 当前方法名：create