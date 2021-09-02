def test():
    client = InfluxDBClient('127.0.0.1', 8086, 'root', 'root')
    monitorDbNames = []
    allDbNames = client.get_list_database()

    for i in allDbNames:

        dbName = i
        print(dbName)
        client.switch_database(dbName)
        sql = 'CREATE RETENTION POLICY "3_hours" ON {} DURATION 3h REPLICATION 1 DEFAULT'.format(i["name"])
        client.query(sql)
        sql1 = "SHOW RETENTION POLICIES ON {}".format(i["name"])
        client.query(sql1)