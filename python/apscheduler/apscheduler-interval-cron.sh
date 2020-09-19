python apscheduler interval/cron触发器详解 常用

##interval 触发器
#参数 说明
weeks (int) 间隔几周
days (int) 间隔几天
hours (int) 间隔几小时
minutes (int) 间隔几分钟
seconds (int) 间隔多少秒
start_date (datetime 或 str) 开始日期
end_date (datetime 或 str) 结束日期
timezone (datetime.tzinfo 或str) 时区

#每隔两分钟执行一次 job_func 方法
scheduler.add_job(job_func, 'interval', minutes=2)

#在 2017-12-13 14:00:01 ~ 2017-12-13 14:00:10 之间, 每隔两分钟执行一次 job_func 方法
scheduler.add_job(job_func, 'interval', minutes=2, start_date='2017-12-13 14:00:01' , end_date='2017-12-13 14:00:10')

##cron 触发器:
#参数 说明
year (int 或 str) 年，4位数字
month (int 或 str) 月 (范围1-12)
day (int 或 str) 日 (范围1-31)
week (int 或 str) 周 (范围1-53)
day_of_week (int 或 str) 周内第几天或者星期几 (范围0-6 或者 mon,tue,wed,thu,fri,sat,sun)
hour (int 或 str) 时 (范围0-23)
minute (int 或 str) 分 (范围0-59)
second (int 或 str) 秒 (范围0-59)
start_date (datetime 或 str) 最早开始日期(包含)
end_date (datetime 或 str) 最晚结束时间(包含)
timezone (datetime.tzinfo 或str) 指定时区

在每年 1-3、7-9 月份中的每个星期一、二中的 00:00, 01:00, 02:00 和 03:00 执行 job_func 任务
scheduler.add_job(job_func, 'cron', month='1-3,7-9',day='0, tue', hour='0-3')
scheduler.add_job(health_checks, 'cron',day_of_week='*',hour='9-21',minute="0,30", second="0")


作者：SkTj
链接：https://www.jianshu.com/p/3e996c023ac3
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。



