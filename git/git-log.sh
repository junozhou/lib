git log --pretty=oneline
git log --pretty=short
git log --pretty=full
git log --pretty=fuller
git log --pretty=format:'[%cn]  %cd : %s' --no-merges
git log --pretty=format:"SHA-1:%h - 创建人:%an 时间:%ad 提交信息:%s" --date=format:"%y-%m-%d %H:%M:%S" --shortstat --since=2.weeks
git log --pretty=format:"SHA-1:%h - 创建人:%an 时间:%ad 提交信息:%s" --date=format:"%y-%m-%d %H:%M:%S" --no-merges


