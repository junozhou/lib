#abc
#bbb

#目标
#abc,bbb


with open("ser.txt", "r") as fread:
    services = [x.strip() for x in fread]
print(','.join(services))