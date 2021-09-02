#看这个之前想要解决的问题，当一个类定义了两个属性，都赋值为None
# ，实例话一个对象，如何判断这个实例是空都


class Stu(object): #无合适的继承类，就使用object，是所有的类最终都会继承都类
    pass

class Stu2(object):
    def __init__(self, name, score=None):
        # __init__ 方法第一个参数永远是self，表示创建的实例本身，
        # 因此，在__init__方法内部，就可以把各种属性绑定到self，因为self就指向创建的实例本身
        # # 有了__init__方法，创建实例的时候，就不能传入空的参数了，必须传入与__init方法匹配的参数
        # ？如果绑定的属性有默认值，就不用手动传参数吧，对，如果没有默认参数，实例化的时候会报错
        # TypeError: __init__() missing 1 required positional argument: 'name'
        self._name = name
        self._score = score

if __name__ == "__main__":
    s = Stu()
    print(s) #<__main__.Stu object at 0x100f2dd30> ，
             # 变量s指向都就是一个Stu都object，后面的0x100f2dd30是内存地址，每个object的地址不一样
    print(Stu)#<class '__main__.Stu'>
    s.name = "hhh"
    print(s.name) # 可以自由的给一个实例变量绑定属性，如左边
                  # 由于类可以起到模版的作用，因此，可以在创建实例的时候，
                #把一些我们认为必须绑定的属性强制填进去。
                #通过定义一个特殊的__init__方法，在创建实例的时候把name等属性绑上去
    a = Stu2()
    print("===")
    print(a==None)





