JS数组合并的8种常见方法
1.ES6 解构
[...arr, ...array]
不改原数组值，生成新的数组。

2.遍历添加
array.forEach(item => {
    arr.push(item)
})
遍历方法：forEach、map、filter、every、for、for in、for of等。

添加方法：push（后追加）、unshift（前追加）等。

arr值改变成追加后的样子，array值不改变

3.concat
arr.concat(array)
不改原数组值，生成新的数组。

4.join & split
(arr.join(',') + ',' + array.join(',')).split(',')
原数组值不改变。

默认会把数组中的数字类型转成字符串类型。

数组的项是引用类型时会自动生成'[object Object]'，造成数据丢失或错误。

5.解构添加
arr.push(...array)
arr.unshift(...array)
arr变成合并后的样子，array值不变。

6.splice解构
arr.splice(arr.length, '', ...array)
原数组值不变，返回空数组。

7.apply
arr.push.apply(arr, array)
arr.unshift.apply(arr, array)
原数组值不改变，返回拼接后数组的长度。

8.call
arr.push.call(arr, ...array)
arr.unshift.call(arr, ...array)
原数组值不改变，返回拼接后数组的长度。
————————————————
版权声明：本文为CSDN博主「tengxi_5290」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/tengxi_5290/article/details/124825523