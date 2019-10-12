# Centos部署Python开发环境

**下载Python 3.7.4**

下载地址: https://www.python.org/downloads/release/python-374/

下载 源码安装版本 Gzipped source tarball (Source release)

可以使用 wget 方法下载

```
cd /usr/local/download        #下载文件夹

wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz
```

**安装**

安装Python依赖包

```
yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make
```

解压和安装pythonn tgz 软件包

```
tar -xzvf /usr/local/download/Python-3.7.4.tgz -C /usr/local/src/  # src目录是存放源码的目录,解压到src目录

cd /usr/local/src/Python-3.7.4    # 进入python目录

./configure --prefix=/usr/local/python3   # 生成 Makefile

make && make install     # 编译和安装
```

添加环境变量 

(***/etc/profile.d/ 比 /etc/profile好维护，不想要什么变量直接删除/etc/profile.d/下对应的shell脚本即可，不用像/etc/profile需要改动此文件***)

```
echo $PATH           # 打印环境变量 查看是否包含/usr/local/python3/bin

cd /etc/profile.d/   # 进入profile.d 文件夹

vi python3.sh        # 新建python3.sh文件

	# python3.sh文件中插入下面一行 并保存退出
	export PATH="$PATH:/usr/local/python3/bin"

source ../profile    # 重载文件 或者 ../profile
# 错误:permission denied  (~~ 没有错误忽略这一步 ~~)
chmod 777 ../profile # 更改为 777 权限

echo $PATH           # 查看当前环境变量是否添加
```