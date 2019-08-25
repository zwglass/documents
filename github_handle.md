##GitHub 操作

**1. 首先你要有个GitHub账号，登录网址注册：https://github.com/**

**2. 进入你的Github，点击New repository新建一个项目**

![repository create](https://github.com/zwglass/MyImages/blob/master/githubHandle/github_repository.png?raw=true)

**3. 取一个Repository name，不能和自己的其他项目冲突**

![repository name](https://github.com/zwglass/MyImages/blob/master/githubHandle/repository_name.png?raw=true)

<mark>PS：<mark>

Repository name: 仓库名称

Description(可选): 仓库描述介绍

Public, Private : 仓库权限（公开共享，私有或指定合作者）

Initialize this repository with a README: 添加一个README.md

gitignore: 不需要进行版本管理的仓库类型，对应生成文件.gitignore

license: 证书类型，对应生成文件LICENSE
并在下面Add a license选择一个：

![license select](https://github.com/zwglass/MyImages/blob/master/githubHandle/repository_licenese.png?raw=true)

***然后点击Create repository继续。***

**4. 然后复制如下界面的Clone or download的网址**

![clone dowload](https://github.com/zwglass/MyImages/blob/master/githubHandle/clone_download.png?raw=true)

**5. 下面就需要在本地操作了，我用的cygwin终端**

进入一个文件夹

![terminal path](https://github.com/zwglass/MyImages/blob/master/githubHandle/terminal_path.png?raw=true)

然后输入git clone，把github上面的仓库克隆到本地：

git clone https://github.com/**/Geophysics.git(这个网址即为你上面复制的网址)

![terminal clone](https://github.com/zwglass/MyImages/blob/master/githubHandle/terminal_clone.png?raw=true)

**6. 然后在你当前的路径下就会生成一个Geophysics文件夹**

![new path](https://github.com/zwglass/MyImages/blob/master/githubHandle/github_new_path.png?raw=true)

把需要上传的代码、文件放到这个文件夹中并进入这个文件夹(此处我放入的东西就不截图了)

![terminal newPath](https://github.com/zwglass/MyImages/blob/master/githubHandle/save_file.png?raw=true)

**7.然后就可以在终端下输入下面的代码了！**

$ git add .  “注意这里有个'.'，此操作是把Test文件夹下面的文件都添加进来”

![terminal gitAdd](https://github.com/zwglass/MyImages/blob/master/githubHandle/terminal_add.png?raw=true)

$ git commit -m "first commit"  “first commit为提交信息，自定义”

执行指令后，会显示create mode了该文件夹下的所有文件

$ git push -u origin master “此操作是将本地项目push到GitHub上去，中途会提示输入用户名和密码”
然后就完了，你的GitHub的项目里就有了你本地的这些文件。

![success](https://github.com/zwglass/MyImages/blob/master/githubHandle/success.png?raw=true)

参考文章：http://www.cnblogs.com/cxk1995/p/5800196.html

***其他一些git指令：***

```
$ git init                    #把当前目录变成git可以管理的仓库
$ git add readme.txt          #添加一个文件，也可以添加文件夹
$ git add -A                  #添加全部文件
$ git commit -m "some commit" #提交修改
$ git status                  #查看是否还有未提交
$ git log                     #查看最近日志
$ git reset --hard HEAD^      #版本回退一个版本
$ git reset --hard HEAD^^     #版本回退两个版本
$ git reset --hard HEAD~100   #版本回退多个版本
$ git remote add origin +地址 #远程仓库的提交（第一次链接）
$ git push -u origin master   #仓库关联
$ git push                    #远程仓库的提交（第二次及之后）
```

$ End





