#项目使用的是ext框架，版本是ext4.2
#
#出现的问题代码如下：

1 renderer : function(value){
2     var html = "<a href=\"javascript:void(0);\" onclick=\"editServer('"+value+"')\" style=\"text-decoration:underline;color:blue;\">编辑</a>&nbsp;&nbsp;"+
3           "<a href=\"javascript:void(0);\" onclick=\"accountBalance('"+value+"')\" style=\"text-decoration:underline;color:blue;\">余额</a>";
4     return html;
5  }
#而下面已经定义了editServer方法

 1 function editServer(value){
 2     Ext.create('Ext.window.Window', {
 3         y : 50,
 4         x : 150,
 5         title : '编辑渠道',
 6         modal : true,
 7         width : 680,
 8         height : 330
 9             ......
10 }
#但是运行的时候却一直报没有定义：

#ReferenceError: editServer is not defined

#解决方法：
#　　将方法改为：

window.editServer= function(value){

#　　　　　......

}
#
#再次运行后成功