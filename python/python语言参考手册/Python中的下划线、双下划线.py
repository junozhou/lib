# 单下划线和双下划线在Python变量名和方法名中都有各自的含义。
# 有些仅仅是作为约定，用于提示开发人员；而另一些则对Python解释器有特殊含义。
#
# 总的来说有一下几种情况：
# 前置单下划线：_var
# 后置单下划线：var_
# 前置双下划线：__var
# 前后双下划线：__var__
# 单下划线：_
# 1. 前置单下划线：_var

# 当涉及变量名和方法名时，前置单下划线只有约定含义。
# 它对于程序员而言是一种提示——Python社区约定好单下划线表达的是某种意思，
# 其本身并不会影响程序的行为。
# 前置下划线的意思是提示其他程序员，以单下划线开头的变量或方法只在内部使用。
# 仅仅是提示的作用，没有任何的约束力。
#
# 例如：
# 如果实例化这个类并尝试访问在__init__构造函数中定义的am和_aomi属性，会发生什么情况？
class ceshi:
    def __init__(self):
        self.am = 2021
        self._aomi = 2022
t = ceshi()
print(t._aomi)

# 可以看到，_aomi前面的单下划线并没有阻止我们“进入”这个类访问变量的值。
# 这是因为Python中的前置单下划线只是一个公认的约定，至少在涉及变量名和方法名时是这样的。
# 但是前置下划线会影响从模块中导入名称的方式。
#
# 如：在my_module定义了两个方法，org_fun和_new_fun
#my_module.py

def org_fun():
    return 2021

def _new_fun():
    return 2022
# 测试导入：
# 如果使用通配符导入从这个模块中导入所有名称，Python不会导入带有前置单下划线的名称
#
# 顺便说一下，应避免使用通配符导入，因为这样就不清楚当前名称空间中存在哪些名称了。
# 10为了清楚起见，最好坚持使用常规导入方法。
# 与通配符导入不同，常规导入不受前置单下划线命名约定的影响。
# 2. 后置单下划线：var_

# 有时，某个变量最合适的名称已被Python语言中的关键字占用。
# 因此，诸如class或def的名称不能用作Python中的变量名。
# 在这种情况下，可以追加一个下划线来绕过命名冲突。
# 总之，用一个后置单下划线来避免与Python关键字的命名冲突是一个约定。
#
# 3. 前置双下划线：__var

# 双下划线前缀会让Python解释器重写属性名称，以避免子类中的命名冲突。
# 这也称为名称改写（name mangling），即解释器会更改变量的名称，
# 以便在稍后扩展这个类时避免命名冲突。
#
# 听起来很抽象，下面用代码示例来实验一下：

class Test:
    def __init__(self):
        self.foo = 11
        self._bar = 23
        self.__baz = 23
# 让我们用内置的dir()函数来看看这个对象的属性：
#
# >>> t = Test()
# >>> dir(t)
# ['_Test__baz', '__class__', '__delattr__', '__dict__', '__dir__',
#  '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__',
#  '__gt__', '__hash__', '__init__', '__le__', '__lt__', '__module__',
#  '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__',
#  '__setattr__', '__sizeof__', '__str__', '__subclasshook__',
#  '__weakref__', '_bar', 'foo']
# 以上是这个对象属性的列表。
# 让我们来看看这个列表，并寻找我们的原始变量名称foo，_bar和__baz - 我保证你会注意到一些有趣的变化。
#
# self.foo变量在属性列表中显示为未修改为foo。
# self._bar的行为方式相同 - 它以_bar的形式显示在类上。
# 就像我之前说过的，在这种情况下，前导下划线仅仅是一个约定。
# 给程序员一个提示而已。 然而，对于self.__baz而言，情况看起来有点不同。
# 当你在该列表中搜索__baz时，你会看不到有这个名字的变量。

# __baz出什么情况了？
# 如果你仔细观察，你会看到此对象上有一个名为_Test__baz的属性。
# 这就是Python解释器所做的名称修饰。 它这样做是为了防止变量在子类中被重写。
# 让我们创建另一个扩展Test类的类，并尝试重写构造函数中添加的现有属性：

class ExtendedTest(Test):
    def __init__(self):
        super().__init__()
        self.foo = 'overridden'
        self._bar = 'overridden'
        self.__baz = 'overridden'
# 现在，你认为foo，_bar和__baz的值会出现在这个ExtendedTest类的实例上吗？ 我们来看一看：

# >>> t2 = ExtendedTest()
# >>> t2.foo
# 'overridden'
# >>> t2._bar
# 'overridden'
# >>> t2.__baz
# AttributeError: "'ExtendedTest' object has no attribute '__baz'"
# 等一下，当我们尝试查看t2 .__ baz的值时，为什么我们会得到AttributeError？ 名称修饰被再次触发了！ 事实证明，这个对象甚至没有__baz属性：

# >>> dir(t2)
# ['_ExtendedTest__baz', '_Test__baz', '__class__', '__delattr__',
#  '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__',
#  '__getattribute__', '__gt__', '__hash__', '__init__', '__le__',
#  '__lt__', '__module__', '__ne__', '__new__', '__reduce__',
#  '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__',
#  '__subclasshook__', '__weakref__', '_bar', 'foo', 'get_vars']
# 正如你可以看到__baz变成_ExtendedTest__baz以防止意外修改：

# >>> t2._ExtendedTest__baz
# 'overridden'
# 但原来的_Test__baz还在：
#
# >>> t2._Test__baz
# 42
# 双下划线名称修饰对程序员是完全透明的。 下面的例子证实了这一点：

class ManglingTest:
    def __init__(self):
        self.__mangled = 'hello'

    def get_mangled(self):
        return self.__mangled

# >>> ManglingTest().get_mangled()
# 'hello'
# >>> ManglingTest().__mangled
# AttributeError: "'ManglingTest' object has no attribute '__mangled'"
# 名称修饰是否也适用于方法名称？ 是的，也适用。
# 名称修饰会影响在一个类的上下文中，以两个下划线字符（"dunders"）开头的所有名称：

class MangledMethod:
    def __method(self):
        return 42

    def call_it(self):
        return self.__method()

# >>> MangledMethod().__method()
# AttributeError: "'MangledMethod' object has no attribute '__method'"
# >>> MangledMethod().call_it()
# 42
# 这是另一个也许令人惊讶的运用名称修饰的例子：

_MangledGlobal__mangled = 23

class MangledGlobal:
    def test(self):
        return __mangled

# >>> MangledGlobal().test()
# 23
# 在这个例子中，我声明了一个名为_MangledGlobal__mangled的全局变量。
# 然后我在名为MangledGlobal的类的上下文中访问变量。
# 由于名称修饰，我能够在类的test()方法内，以__mangled来引用_MangledGlobal__mangled全局变量。
#
# Python解释器自动将名称__mangled扩展为_MangledGlobal__mangled，因为它以两个下划线字符开头。
# 这表明名称修饰不是专门与类属性关联的。
# 它适用于在类上下文中使用的两个下划线字符开头的任何名称。
#
# 有很多要吸收的内容吧。
# 老实说，这些例子和解释不是从我脑子里蹦出来的。我作了一些研究和加工才弄出来。
# 我一直使用Python，有很多年了，但是像这样的规则和特殊情况并不总是浮现在脑海里。

# 有时候程序员最重要的技能是"模式识别"，而且知道在哪里查阅信息。
# 如果您在这一点上感到有点不知所措，请不要担心。慢慢来，试试这篇文章中的一些例子。
#
# 让这些概念完全沉浸下来，以便你能够理解名称修饰的总体思路，以及我向您展示的一些其他的行为。
# 如果有一天你和它们不期而遇，你会知道在文档中按什么来查。
#
# 4. 双前导和双末尾下划线 _var_
# 也许令人惊讶的是，如果一个名字同时以双下划线开始和结束，则不会应用名称修饰。
# 由双下划线前缀和后缀包围的变量不会被Python解释器修改：

class PrefixPostfixTest:
    def __init__(self):
        self.__bam__ = 42

# >>> PrefixPostfixTest().__bam__
# 42
# 但是，Python保留了有双前导和双末尾下划线的名称，用于特殊用途。
# 这样的例子有，__init__对象构造函数，或__call__ --- 它使得一个对象可以被调用。
# 这些dunder方法通常被称为神奇方法 - 但Python社区中的许多人（包括我自己）都不喜欢这种方法。
# 最好避免在自己的程序中使用以双下划线（"dunders"）开头和结尾的名称，
# 以避免与将来Python语言的变化产生冲突。

# 5.单下划线 _
# 按照习惯，有时候单个独立下划线是用作一个名字，来表示某个变量是临时的或无关紧要的。
# 例如，在下面的循环中，我们不需要访问正在运行的索引，我们可以使用"_"来表示它只是一个临时值：

# >>> for _ in range(32):
#     ...    print('Hello, World.')
# 你也可以在拆分(unpacking)表达式中将单个下划线用作"不关心的"变量，以忽略特定的值。
# 同样，这个含义只是"依照约定"，并不会在Python解释器中触发特殊的行为。
# 单个下划线仅仅是一个有效的变量名称，会有这个用途而已。
#
# 在下面的代码示例中，我将汽车元组拆分为单独的变量，但我只对颜色和里程值感兴趣。
# 但是，为了使拆分表达式成功运行，我需要将包含在元组中的所有值分配给变量。
# 在这种情况下，"_"作为占位符变量可以派上用场：

# >>> car = ('red', 'auto', 12, 3812.4)
# >>> color, _, _, mileage = car
#
# >>> color
# 'red'
# >>> mileage
# 3812.4
# >>> _
# 12
# 除了用作临时变量之外，"_"是大多数Python REPL中的一个特殊变量，
# 它表示由解释器评估的最近一个表达式的结果。
#
# 这样就很方便了，比如你可以在一个解释器会话中访问先前计算的结果，或者，
# 你是在动态构建多个对象并与它们交互，无需事先给这些对象分配名字：

# >>> 20 + 3
# 23
# >>> _
# 23
# >>> print(_)
# 23
#
# >>> list()
# []
# >>> _.append(1)
# >>> _.append(2)
# >>> _.append(3)
# >>> _
# [1, 2, 3]
# Python下划线命名模式 - 小结
# 以下是一个简短的小结，即"速查表"，罗列了我在本文中谈到的五种Python下划线模式的含义：
#
# 同目录下的png

# ————————————————
# 版权声明：本文为CSDN博主「围城客」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
# 原文链接：https://blog.csdn.net/u014612521/article/details/122298168