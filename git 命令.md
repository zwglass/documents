##git同步项目至GitHub纯命令行步骤

1. 在电脑上下载并安装git
2. 在GitHub上创建一个仓库
3. 将仓库的SSH连接复制下来
4. 克隆仓库 <label style="color:red">**git clone https://github.com/zwglass/react-hooks.git**</label>
5. 进入到.git 下载的文件夹内
6. 输入 <label style="color:red">**git add .**</label> 添加所有更改的文件到本地缓存
7. 输入 <label style="color:red">**git commit -m "为这次提交做注释"**</label>，提交到本地
8. 输入 <label style="color:red">**git push -u origin master**</label> 将更改过的代码推送打到GitHub中去(此为首次提交以后再提交只需要输入 <label style="color:red">**git push origin master**</label> 即可)

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