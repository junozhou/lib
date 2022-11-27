# https://zhuanlan.zhihu.com/p/141615409 好
### 作用
# Python assert（断言）用于判断一个表达式，在表达式条件为 false 的时候触发异常。
### 断言是一个调试工具。它用于发现异常，而不是用于处理异常。##
# 从这句话看在接口测试中比较适合，不需要打多个断点，直接在异常处设置断言，然后看异常结果。不过这还是自己的猜测，需要被验证

# assert bool_expr, optional_expr
# 如果bool_expr的估值（表达式的最终计算结果）为False，系统就会抛出一个AsesertionError异常。这个异常包含了必要的栈信息，所以它能够为解决这个“意外”提供很多的信息。
#
# 如果提供了可选的optional_expr，则optional_expr是异常AsesertionError的构造函数参数。optional_expr可为异常提供了额外的信息，所以它是非常有用的。



### 用法
# 语法格式如下：

assert expression
# 等价于：

if not expression:
    raise AssertionError
assert 后面也可以紧跟参数:

assert expression [, arguments]
# 等价于：

if not expression:
    raise AssertionError(arguments)

# 以下实例判断当前系统是否为 Linux，如果不满足条件则直接触发异常，不必执行接下来的代码：
import sys
assert ('linux' in sys.platform), "该代码只能在 Linux 下执行"

# 接下来要执行的代码
# 从这个例子看出，断言适合遇到异常就返回的场景，但是返回的数据如何定义还需要继续看
# 如linux 这个例子， "该代码只能在 Linux 下执行" 就是返回的数据吧

# 2、怎么关闭assert
# 正如第0节所说的，assertion是一个调试工具，在功能开发并测试完毕之后，正式发布之前，应该先把assertion语句全部去掉（或者使其失效）。在C＋＋中，assert语句在release版本中是一个空语句，在编译阶段就可以被处理。但在Python3是脚本语言，所以我们需要用不同的方式来处理。
#
# 第一种是通过给python解析器传递－O参数，其实命令形式如下：
#
# python -O program.py
# 另外一种，也是比较直观和暴力的方法，就是直接注释（或者删除）所有的assert语句。
### 优点

void ReverseStr(char *str)
{
if (NULL == str)
{
# // str传入NULL，是一个意料之中的“错误”，我们应该直接处理它
#                           // 严格意义上来说，这个处理也是功能的一部分
return;
}

int len = strlen(str);

# // 如果一个字符串的长度过长，可能会是一个错误，其中有种可能是str未以0结尾；
# // 或者由于其它不可描述的原因导致
#    // 如果逻辑上，len不可能大于10240，但莫名地出现这种情况，我们就可以使用asser来定位问题了
#                                      // 在release版本中，下面的语句将会是一个空语句，因为它不是这个函数实现的一部分。
assert(len < 10240);

# // 余下的代码
}
# 在这个例子中，if语句用于“错误”（异常）处理，它是功能的一部分，会一直存在。而assert语句用于发现异常，在我们解决了这个异常之后，我们就会让assert语句失效（去掉代码，或者借助于编译器）。

### 缺点
### 适用那些场景
# assert是调试工具之一，而非全部。
#
# 每个类型的问题，会用到不同类型的调试工具。
### 不适用那些场景