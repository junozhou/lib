cgcreate -t jxrttest:jxrttest -a jxrttest:jxrttest -g memory:jxrttest
echo 7G > /sys/fs/cgroup/memory/jxrttest/memory.limit_in_bytes
cat /sys/fs/cgroup/memory/jxrttest/memory.limit_in_bytes
cgexec -g memory:jxrttest ls