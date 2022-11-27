1.1一次性定时器
//第二个参数是毫秒数
let timer = setTimeout(() => {
  //需要定时执行的代码
  console.debug("Hello World");
  }, 3000)


  1.2 指定时间间隔触发定时器
  let timer = setInterval(() => {
       //需要定时执行的代码
  },5000)

1.3 清除定时器
//清除一次性定时器
clearTimeout(timer)

//清除多次执行定时器
clearInterval(timer)


this.timer2 = setTimeout(this.get_ser_ukey_value, 60 * 1000 * this.close_time+20 * 1000);

beforeDestroy() {
        if (this.timer2) {
          clearTimeout(this.timer2);
          this.timer2 = null
        }
      },