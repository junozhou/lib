select count(a.service_name) as build_count,a.service_name,a.create_time,a.namespace,a.id,a.build_time,CAST(AVG(a.build_time) AS DECIMAL(10,2)) from build_history AS a
where 20 > (
	select count(*) from build_history
	where service_name = a.service_name and create_time > a.create_time
) GROUP BY a.service_name order by a.service_name,a.update_time desc;



select count(a.service_name) as restart_count,a.service_name,a.create_time,a.namespace,a.id,a.startup_time,CAST(AVG(a.startup_time)/60 AS DECIMAL(10,2)) from service_restart_history AS a
where 20 > (
	select count(*) from service_restart_history
	where service_name = a.service_name and create_time > a.create_time AND result =1
) GROUP BY a.service_name order by a.service_name,a.update_time desc;
