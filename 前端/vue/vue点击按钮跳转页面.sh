1.给按钮添加点击事件

<button @click="register">登录</button>
2.实现跳转 在methods里面写入一下代码

register () {
      //跳转到上一次浏览的页面
      this.$router.go(-1)

      //指定跳转的地址
      this.$router.replace('/将要跳转的路由名称')

      //指定跳转的路由的名字下
      this.$router.replace({name:'指定路由名称'})

      //通过push进行跳转
      this.$router.push('/将要跳转的路由名称')
      this.$router.push({
                path: '/addTask'
              })
    }
3.通过 <router-link to=""></router-link>跳转

<router-link :to="
   path:' index.js 里面配置的路由路径'，
或者
   name：' index.js 里面配置路由 name'
">点我跳转</router-link>