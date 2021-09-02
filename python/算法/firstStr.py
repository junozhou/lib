def fistshow(st):
    st = list(st)
    fs = {}
    for i in range(len(st)):
        if st[i] in fs:
            fs[st[i]] -= 1
        else:
            fs[st[i]] = 1
    for iv,v in fs.items():
        if v == 1:
            print(iv)
            return iv


if __name__ == "__main__":
    fistshow("dddss3ji")