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
#https://s-z-q.blog.csdn.net/article/details/119922715
#再次运行后成功

# 以下方法才可行得通
#Vue父组件调用子组件的方法并传参的两种方式（用$refs.refName.functionName、window.function）
#父组件，
import Gantt from '../components/Gantt.vue';
  created() {
    window.clickGridButton = this.clickGridButton; #声明全局方法（直男模式）
  },

#子组件 Gantt.vue
mounted: function () {
  var colHeader = '<div class="gantt_grid_head_cell gantt_grid_head_add" onclick="gantt.createTask()"></div>',
          colContent = function (task) {
            return (
                '<i class="fa gantt_button_grid gantt_grid_edit fa-pencil" onclick="clickGridButton(' + task.id +
                ', \'edit\')"></i>' +
                '<i class="fa gantt_button_grid gantt_grid_delete fa-times" onclick="clickGridButton(' + task.id + ', \'delete\')"></i>');
          };

}