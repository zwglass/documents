##git同步项目至GitHub纯命令行步骤##

1. 在电脑上下载并安装git
2. 在GitHub上创建一个仓库
3. 将仓库的SSH连接复制下来
4. 克隆仓库 <label style="color:red">**git clone https://github.com/zwglass/react-hooks.git**</label>
5. 进入到.git 下载的文件夹内
6. 输入 <label style="color:red">**git add .**</label> 添加所有更改的文件到本地缓存
7. 输入 <label style="color:red">**git commit -m "为这次提交做注释"**</label>，提交到本地  -- 将修改从暂存区提交到本地版本库
8. 输入 <label style="color:red">**git push -u origin master**</label> 将更改过的代码推送打到GitHub中去(此为首次提交以后再提交只需要输入 <label style="color:red">**git push origin master**</label> 即可)
9. `git push origin HEAD:dev` 推送到远端特定分支 `dev`

- 冲突的出现：因为别人提交后，未先做更新就做提交，报

```
Updates were rejected because the remote contains work that you do 
```
的错误

- 解决方案：先合并再push

``` 
git pull origin master --allow-unrelated-histories
git push origin master
```

**创建分支**

***`HEAD`严格来说不是指向提交，而是指向`master`，`master`才是指向提交的，所以，`HEAD`指向的就是当前分支***

我们创建dev分支，然后切换到dev分支：

```
$ git checkout -b dev
Switched to a new branch 'dev'
```

`git checkout` 命令加上 `-b` 参数表示创建并切换，相当于以下两条命令：

```
$ git branch dev
$ git checkout dev
Switched to branch 'dev'
```

然后，用 `git branch` 命令查看当前分支：

`git branch` 命令会列出所有分支，当前分支前面会标一个*号。

```
$ git branch
* dev
  master
```

然后，我们就可以在dev分支上正常提交，比如对readme.txt做个修改，加上一行：

```
Creating a new branch is quick.
```

然后提交  并推送到GitHub仓库`git push origin HEAD:dev`：

```
$ git add readme.txt 
$ git commit -m "branch test"
[dev b17d20e] branch test
 1 file changed, 1 insertion(+)
$ git push origin HEAD:dev
```

现在，`dev`分支的工作完成，我们就可以切换回 `master` 分支：

```
$ git checkout master
Switched to branch 'master'
```

***把`dev`分支的工作成果合并到 `master` 分支上(一定要在`master`分支下操作)：***

```
$ git merge dev
Updating d46f35e..b17d20e
Fast-forward
 readme.txt | 1 +
 1 file changed, 1 insertion(+)
```

合并完成后，就可以放心地删除`dev`分支了：

```
$ git branch -d dev
Deleted branch dev (was b17d20e).
```

删除后，查看 `branch`，就只剩下`master`分支了：

```
$ git branch
* master
```

**switch**

我们注意到切换分支使用`git checkout <branch>`，而撤销修改则是`git checkout -- <file>`，同一个命令，有两种作用，确实有点令人迷惑。

实际上，切换分支这个动作，用`switch`更科学。因此，最新版本的Git提供了新的`git switch`命令来切换分支：

创建并切换到新的dev分支，可以使用：

```
$ git switch -c dev
```

直接切换到已有的`master`分支，可以使用：

```
$ git switch master
```

使用新的git switch命令，比git checkout要更容易理解。

**小结**

Git鼓励大量使用分支：

查看分支：`git branch`

创建分支：`git branch <name>`

切换分支：`git checkout <name>`或者`git switch <name>`

创建+切换分支：`git checkout -b <name>`或者`git switch -c <name>`

合并某分支到当前分支：`git merge <name>`

删除分支：`git branch -d <name>`