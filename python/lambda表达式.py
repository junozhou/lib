# 6.14. lambda 表达式
# lambda_expr        ::=  "lambda" [parameter_list] ":" expression
# lambda_expr_nocond ::=  "lambda" [parameter_list] ":" expression_nocond
# lambda 表达式（有时称为 lambda 构型）被用于创建匿名函数。 表达式 lambda parameters: expression 会产生一个函数对象 。 该未命名对象的行为类似于用以下方式定义的函数:

# def <lambda>(parameters):
#     return expression
# 如：
# sortedlist=sorted(dictApps, key=lambda x: x['duration'])

# 例1:传入多个参数的lambda函数

def sum(x,y):
    return x+y
# 用lambda来实现：



p = lambda x,y:x+y
print(p(4,6))
