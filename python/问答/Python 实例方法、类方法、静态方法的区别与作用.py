
# https://www.cnblogs.com/wcwnina/p/8644892.html
# 实例方法和类方法的区别 python
# 有区别的，最主要的区别在于，定义类方法主要是要加一个装饰器，@classmethod
#
# 而实例方法没有这个装饰器。这是区别实例方法和类方法的最主要的区别。
#
# 在调用上的区别在于，实例方法要先实例化一个对象再调用这个实例化方法，而类方法不需要有类的实例，直接类名.方法名就可以调用。
#
# 实例方法至少有一个参数，通常用self，这个参数里面是这个实例本身。类方法至少有一个参数，通常用cls，这个参数里面是这个类本身。
#
# 实例方法由于有实例，所以实例的属性对其实可见的，但类方法显然没有属性。
#
# 本质上来讲，类方法和实例方法没有本质区别，只不过在调用的时候，实例方法把这个实例本身当做参数传过去了。
#
# 以下是示例代码，感受一下。

class myclass:
         @classmethod
     def classMethod(cls):
         print('class method')
         print('parameter : %s'%cls)
         pass
     def instanceMethod(self):
         print('instance method')
         print('parameter : %s' % self)
         pass
m=myclass()
m.instanceMethod()#实例来调用实例方法
myclass.classMethod()#类名.方法名调用类方法
myclass.instanceMethod(m)#类名.方法名，并将实例作为参数传入，和实例调用实例方法一样