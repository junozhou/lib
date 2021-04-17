2、Git commit 后不小心执行git reset --hard HEAD^，然后想要找回最新的commit
git reflog //找到自己需要的commitID
git checkout commitid 然后执行
 git checkout -b <new-branch-name>
git checkout -b test2
如果有权限
可以直接把本地的test2分支，合并到自己想要合并的分支
git checkout feature-conf
git merge test2
git push