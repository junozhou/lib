#!/bin/env python
# encoding: utf-8
import json
import requests
from influxdb import InfluxDBClient

def env_use_test_add():
    data = {"envuse_desc":"测试一下机器人消息问题",
         # "envuse_test":"case-manage",
         "envuse_test":"t4",
         "envuse_team":"1团队",
         "envuse_user":"",
            "msg_type" : "add",
         "envuse_branch":"s9",
         "start_date":"2021-11-18 00:00",
         "end_date":"2021-11-20 23:59",
         "duration_time":0,
         "percent_p":0,
         "type":"project",
         # "updatePerson":"zhangnannan"}
         "updatePerson":"zhouxiaoyan"}

    headers = {'content-type': "application/json"}
    url = "http://127.0.0.1:5000/envuseapi/add_envuse_plan"
    response = requests.post(url, json=data, headers=headers)
    response.encoding = 'utf-8'
    print(response.text)
    print(response.status_code)
def env_use_test_up():
    data = {"_id":"6188ffb48cf0766953948c57","envuse_desc":"s",
            # "envuse_test":"case-manage",
            "envuse_test":"t1",
            "envuse_team":["1团队","2团队"],"envuse_user":"","start_date":"2021-11-08 00:00",
            "end_date":"2021-11-27 23:59","envuse_branch":"s279",
            "msg_type" : "update",
            "duration_time":1727940000,"percent_p":0,"type":"project",
            "updatePerson":"zh"}

    headers = {'content-type': "application/json"}
    url = "http://127.0.0.1:5000/envuseapi/up_envuse_plan"
    response = requests.post(url, json=data, headers=headers)
    response.encoding = 'utf-8'
    print(response.text)
    print(response.status_code)


def test2():
    client = InfluxDBClient('127.0.0.1', 8086, 'root', 'root')
    monitorDbNames = []
    allDbNames = client.get_list_database()

    for i in allDbNames:

        dbName = i
        print(dbName)
        client.switch_database(i["name"])
        sql = 'CREATE RETENTION POLICY "24_hours" ON "{}" DURATION 24h REPLICATION 1 DEFAULT'.format(i["name"])
        client.query(sql)
        sql1 = 'SHOW RETENTION POLICIES ON "{}"'.format(i["name"])
        client.query(sql1)



if __name__ == '__main__':
    env_use_test_up()