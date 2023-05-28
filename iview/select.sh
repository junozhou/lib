Vue2.x-05 iview的Select控件点击从后台加载数据 原创
  <Select v-model="chooseResourceObj.equipId"
                          @on-change="equipChange"
                          @on-open-change="(flag)=>{selectOpenChange(flag,'equip')}"
                          filterable
                          remote
                          label-in-value
                          :remote-method="equipQuery"
                          :loading="equipLoading"
                          :transfer="transfer">
 // 下拉列表展开事件
      selectOpenChange (flag, queryType) {
        if (flag) {
          if (queryType === 'equip') {
            this.equipQuery('')
          } else if (queryType === 'port') {
            this.portQuery('')
          }
        } else {
          console.log('*****flag=:' + flag)
        }
      }


      selectOpenChange 和 equipQuery 都是自定义的function, equipQuery 中通过localAxios发起后台请求获取数据。

#重点记录语法："(flag)=>{selectOpenChange(flag,'equip')}"