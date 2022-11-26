k8s kubectl 在本地和容器之间复制文件
从容器复制文件到本地
kubectl cp <namespace>/<pod>:<root_dir>/<parent_dir>/<file_name> ./<file_name>
#注：pod冒号后直接加根目录，不能加“/”，否则报错
#tar: removing leading ‘/’ from member names
#如：
kubectl cp namespace-t4/api-web2022:app/api-web-2.0.0-SNAPSHOT.jar ./api-web-2.0.0-SNAPSHOT.jar


从本地复制到容器
kubectl cp ./<file_name> <namespace>/<pod>:/<root_dir>/<parent_dir>/<file_name>