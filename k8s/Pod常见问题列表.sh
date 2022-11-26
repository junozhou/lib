######Pod常见问题列表：

ImagePullBackOff
CrashLoopBackOff
RunContainerError
处于Pending状态的Pod
处于未就绪状态的Pod

######ImagePullBackOff

#当Kubernetes无法获取到Pod中某个容器的镜像时，将出现此错误。

#可能原因：

-镜像名称无效，例如拼错镜像名称，或者镜像不存在。
-您为image指定了不存在的标签。
-您检索的镜像是私有registry，而Kubernetes没有凭据可以访问它。
解决方法：

-前两种情况可以通过修改镜像名称和标记来解决该问题。
-第三种情况，您需要将私有registry的访问凭证，通过Secret添加到Kubernetes中并在Pod中引用它。
######CrashLoopBackOff

如果容器无法启动，则Kubernetes将显示错误状态为：CrashLoopBackOff。

可能原因：

-应用程序中存在错误，导致无法启动。
-未正确配置容器。
-Liveness探针失败太多次。
解决方法:

-您可以尝试从该容器中检索日志以调查其失败的原因。如果容器重新启动太快而看不到日志，则可以使用命令：$ kubectl logs <pod-name>--previous。
########RunContainerError

当容器无法启动时，出现此错误。

可能原因：

-挂载不存在的卷，例如ConfigMap或Secrets。
-将只读卷安装为可读写。
解决方法：

-请使用kubectl describe pod命令收集和分析错误。
##########处于Pending状态的Pod

当创建应用时，在变更记录中该Pod一直Pending状态。

可能原因：

-集群没有足够的资源（例如CPU和内存）来运行Pod。
-当前的命名空间具有ResourceQuota对象，创建Pod将使命名空间超过配额。
-该Pod绑定到一个处于pending状态的PersistentVolumeClaim。
解决方法：

-检查$ kubectl describe pod<pod name>命令输出的“事件”部分内容或者在控制台查看应用事件。
-对于因ResourceQuotas而导致的错误，可以使用$ kubectl get events--sort-by=.metadata.cre-ationTimestamp命令检查集群的日志。
############处于未就绪状态的Pod

如果Pod正在运行但未就绪（not ready），则表示readiness就绪探针失败。

可能原因：

-当“就绪”探针失败时，Pod未连接到服务，并且没有流量转发到该实例。
解决方法：

-就绪探针失败是应用程序的特定错误，请检查$ kubectl describe pod<pod name>命令输出的“事件”部分内容，或者在控制台查看对应的应用事件。