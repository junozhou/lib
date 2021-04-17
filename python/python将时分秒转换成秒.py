def time2sec(dictDeployment,deploymentName, runTime):
    if 'd' in runTime and 'h' in runTime:
        tmpRunTime = int(runTime[:runTime.index('d')])*(60*60*24)+int(runTime[runTime.index('d')+1:runTime.index('h')])*(60*60)
        dictDeployment[deploymentName]=tmpRunTime
    elif 'd' in runTime:
        tmpRunTime = int(runTime[:runTime.index('d')])*(60*60*24)
        dictDeployment[deploymentName]=tmpRunTime
    elif 'h' in runTime and 'm' in runTime:
        tmpRunTime = int(runTime[:runTime.index('h')])*(60*60)+int(runTime[runTime.index('h')+1:runTime.index('m')])*60
        dictDeployment[deploymentName]=tmpRunTime
    elif 'h' in runTime:
        tmpRunTime = int(runTime[:runTime.index('h')])*(60*60)
        dictDeployment[deploymentName]=tmpRunTime
    elif 'm' in runTime and 's' in runTime:
        tmpRunTime = int(runTime[:runTime.index('m')])*60+int(runTime[runTime.index('m')+1:runTime.index('s')])
        dictDeployment[deploymentName]=tmpRunTime
    elif 'm' in runTime:
        tmpRunTime = int(runTime[:runTime.index('m')])*60
        dictDeployment[deploymentName]=tmpRunTime
    elif 's' in runTime:
        tmpRunTime = int(runTime[:runTime.index('s')])
        dictDeployment[deploymentName]=tmpRunTime
    return dictDeployment
