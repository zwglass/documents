# macOS下配置全局node命令行指令

项目中为了方便管理npm源，在全局安装了nrm源管理器，但却提示命令找不到。

Terminal里执行npm install -g nrm .
检查是否安装到全局 npm list -g --depth 0，列表里会显示全局安装的包名和对应的版本号，找到nrm说明全局安装成功了


```
npm list -g --depth 0
/usr/local/Cellar/node/10.9.0/lib
├── cnpm@6.0.0
├── mocha@5.2.0
└── nrm@1.0.2
```

加载配置的文件 
macOS Catalina(10.15) 以上为 ~/.zshrc

```
source ~/.bash_profile
source ~/.zshrc            # macOS Catalina(10.15)
```

***如果还是报错 执行下面方法***


此时执行nrm add {仓库地址} 会提示command not found，出现该问题的原因是没有配置环境变量，解决方案:
打开bash_profile文件  macOS Catalina(10.15) 以上为 ~/.zshrc

```
vi ~/.bash_profile
vi ~/.zshrc            # macOS Catalina(10.15)
```

如果系统里不存在该文件，该命令会自动生成一个。

```
// $PATH: 后面的路径即是第二步查看全局安装依赖时打印出来的路径
export PATH="$PATH:/usr/local/Cellar/node/10.9.0/bin" 
```

输入:wq!保存并退出

输入

```
source ~/.bash_profile
source ~/.zshrc            # macOS Catalina(10.15)
```

加载刚刚配置的文件。
现在就可以愉快的使用nrm指令了，以后安装的全局node指令也都可以正常使用了。