查看代理

env|grep -i proxy
1

关闭代理

 export http_proxy=""
 export https_proxy=""
 export HTTP_PROXY=""
 export HTTPS_PROXY=""


 设置代理
 export http_proxy="代理地址"



 export http_proxy=http://12.1.216.225:7701 && export https_proxy=https://12.1.216.225:7701 && source ~/.nvm/nvm.sh && nvm use 12 && npm install && npm run build && unset http_proxy && unset https_proxy