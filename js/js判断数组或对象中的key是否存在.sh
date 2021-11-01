var resource = {'1':{id:11},'2':{id:22},'3':{id:33},'4':{id:33},'5':{id:33},'6':{id:33},'7':{id:33},'8':{id:33}}；

方法一：
resource .hasOwnProperty('2');  // 返回true或者false

方法二：
'2' in resource  // 返回true或者false