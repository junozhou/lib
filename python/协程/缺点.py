1.多核资源不能用：协同学的本质是单线程，不能同时使用多核和单个CPU的协同学。

2.在多个CPU上运行需要与进程协调。

当然，大多数每天编写的应用程序都是不必要的。

除非是cpu密集型应用。

3.阻塞操作(如IO)会阻塞整个程序。

