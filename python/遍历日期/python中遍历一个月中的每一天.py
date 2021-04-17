#coding = utf-8

CURRENTMONTH = "2018-05"

from datetime import date,timedelta

traverseDay = date(int(CURRENTMONTH[0:4]),int(CURRENTMONTH[5:7]),1)

intMonth = int(CURRENTMONTH[5:7])

while True:

    if intMonth == traverseDay.month:

        print(traverseDay.strftime('%Y-%m-%d') + " 00:00:00",traverseDay.strftime('%Y-%m-%d') + " 23:59:59")

        traverseDay = traverseDay + timedelta(days=1)

    else:

        break