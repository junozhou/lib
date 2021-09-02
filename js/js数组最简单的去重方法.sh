   var arr = [1, 2, 2,3,4,4,5,5,6,6,7,8]
#//第一种
   var newArr = Array.from(new Set(arr));
#//第二种
   var att = [...new Set(arr)];
# //第三种
   var newarr = [];
  	for (var i = 0; i < arr.length; i++) {
    	if (newarr.indexOf(arr[i]) < 0) {
      	newarr.push(arr[i])
    	}
  	}
#————————————————
#版权声明：本文为CSDN博主「谜i」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/weixin_45214116/article/details/110926994