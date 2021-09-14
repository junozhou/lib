1、Mac docker daemon配置文件
vim ~/.docker/daemon.json
2、Docker 报错Error response from daemon: Get https://xx.xx.xx.xx/v2/: Service Unavailable

mac桌面可以在Preferences-->Docker Engine里配置以下代码，xx.xx.xx.xx是自己私有库的地址。
{
    "insecure-registries":[
        "xx.xx.xx.xx"
    ]
}
insecure-registries 正确配置后，成功登录

3、本机docker配置


{
  "builder": {
    "gc": {
      "defaultKeepStorage": "20GB",
      "enabled": true
    }
  },
  "experimental": false,
  "debug": true,
  "insecure-registries":[
        "127.0.0.1"
    ],
  "registry-mirrors": [
    "http://127.0.0.1/",
    "http://hub-mirror.c.163.com"
  ]
}