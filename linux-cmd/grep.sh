#grep 同时满足多个关键字和满足任意关键字

① grep -E "word1|word2|word3"   file.txt #满足任意条件（word1、word2和word3之一）将匹配。—E 正则表达式
   egrep '123|abc' filename    # 用egrep同样可以实现

② grep word1 file.txt | grep word2 |grep word3 #必须同时满足三个条件（word1、word2和word3）才匹配。
   grep -n -E "Latest 10 commits as below|[ERROR]" *log -A 20 #-n 显示行号


