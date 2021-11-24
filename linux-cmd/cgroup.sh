cgcreate -t jxrttest:jxrttest -a jxrttest:jxrttest -g memory:jxrttest
echo 7G > /sys/fs/cgroup/memory/jxrttest/memory.limit_in_bytes
cat /sys/fs/cgroup/memory/jxrttest/memory.limit_in_bytes
cgexec -g memory:jxrttest ls
cgexec -g memory:jxrttest nohup python3 qa_portal.py >> /var/package/portal.log 2>&1 &