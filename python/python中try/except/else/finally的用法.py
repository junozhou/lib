# 格式：
# 完整的格式顺序是：try —> except X —> except —> else—> finally
# 如果 else 和 finally 都存在的话，else 必须在 finally 之前，finally 必须在整个程序的最后。
# else 的存在是以 except 或 except X 的存在为前提，如果没有 except，而在 try 中使用 else 的话，会出现语法错误。
# 复制代码
def test():
    try:
        print(Nomal execution block)
    except A:
        Exception A handle
    except B:
        Exception B handle
    except:
        Other Exception handle
    else:
         if no exception, get here
    finally:
        print('finally')


# 说明：
# try：正常执行的程序，如果执行过程中出现异常，则中断当前的程序执行，跳转到对应的异常处理模块中；
# except：（可选）如果异常与A/B相匹配，则跳转到对应的except A/B中执行；如果A、B中没有相对应的异常，则跳转到except中执行。（这个except块是可选的，如果没有提供，则执行python默认的异常处理程序，即：中断执行，打印提示信息）
# else：（可选）如果try中的程序执行过程中没有发生错误，则会继续执行else中的程序；
# finally：无论是否发生异常，只要提供了finally程序，就在执行所有步骤之后执行finally中的程序。
# 总的来说：
# 正常执行的程序在try下面执行，在执行中如果发生了异常，则中断当前执行然后执行except中的部分，如果没有异常即不执行except的情况下，则会执行else中的语句，finally语句是最后无论是否有异常都要执行的代码。