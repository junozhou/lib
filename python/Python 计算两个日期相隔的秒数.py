import datetime

def date_delta(start,end):
    start = datetime.datetime.strptime(start,"%Y-%m-%d %H:%M:%S")
    end = datetime.datetime.strptime(end,"%Y-%m-%d %H:%M:%S")
    return (end-start).total_seconds()

start = input()
end = input()
print(date_delta(start,end))

