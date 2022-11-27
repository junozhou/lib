1、TOP 10 执行次数排序

select *
from (select executions,username,PARSING_USER_ID,sql_id,sql_text
   from v$sql,dba_users where user_id=PARSING_USER_ID order by executions desc)
where rownum <=10;

2、TOP 10 CPU排序(单位秒=cpu_time/1000000)

select *
from (select CPU_TIME/1000000,username,PARSING_USER_ID,sql_id,ELAPSED_TIME/1000000,sql_text
   from v$sql,dba_users where user_id=PARSING_USER_ID order by CPU_TIME/1000000 desc)
where rownum <=10;

3、TOP 10 物理读排序（消耗IO排序，即最差性能SQL、低效SQL排序）

select *
from (select DISK_READS,username,PARSING_USER_ID,sql_id,ELAPSED_TIME/1000000,sql_text
   from v$sql,dba_users where user_id=PARSING_USER_ID order by DISK_READS desc)
where rownum <=10;

4、TOP 10 逻辑读排序（消耗内存排序）

select *
from (select BUFFER_GETS,username,PARSING_USER_ID,sql_id,ELAPSED_TIME/1000000,sql_text
   from v$sql,dba_users where user_id=PARSING_USER_ID order by BUFFER_GETS desc)
where rownum <=10;

5、查os内存使用率
SELECT * FROM v$osstat;

6、查os CPU使用率
SELECT
	( SELECT value FROM v$osstat WHERE stat_name = 'BUSY_TIME' ) / (
		NVL(( SELECT value FROM v$osstat WHERE stat_name = 'IDLE_TIME' ), 0 ) + NVL(( SELECT value FROM v$osstat WHERE stat_name = 'BUSY_TIME' ), 0 ) + NVL(( SELECT value FROM v$osstat WHERE stat_name = 'IOWAIT_TIME' ), 0 )
	)
FROM DUAL