import re

if __name__ == '__main__':

    m = "http://xxx.com/xx/xxx/xxx.git"
    m = '@RequestMapping(value = "xxx" ,   method = RequestMethod.POST)'
    # m = '@RequestMapping(method = RequestMethod.GET, value = "xxx")'
    m = '@RequestMapping("/biz/ejt")'
    # m = "http://xxx.com/xx/xxx/xxx"
    # m = "http://xxx.com/xx/xxx.git"
    # m = "http://xxx.com/xx/xxx"
    # strPatternGitaddr = '.com/(.*)/(.*)/(.*).git|.com/(.*)/(.*)/(.*)|.com/(.*)/(.*).git|.com/(.*)/(.*)'
    strPatternGitaddr = 'value.*"(.*)".*RequestMethod.(.*)\)|RequestMethod.(.*).*,.*value = "(' \
                        '.*)".*\)|@RequestMapping\("(.*)"\)'
    mat = re.search(strPatternGitaddr, m)

    if mat != None:

        tmps = list(mat.groups())
        tmp = list(filter(lambda tmps: tmps and tmps.strip(),tmps))
        print(tmp)
        group = tmp[0]
        tmp.remove(tmp[0])

        print("====")
        print(group)
        print("aaa=")
        print(tmp)
        print("b=")
        ltmp = "/".join(tmp)
        print(ltmp)