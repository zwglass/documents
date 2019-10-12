# Centos部署Python开发环境

**下载Python 3.7.4**

下载地址: https://www.python.org/downloads/release/python-374/

下载 源码安装版本 Gzipped source tarball (Source release)

可以使用 wget 方法下载

```
cd /var/download        #下载文件夹

wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz
```

**安装**

安装Python依赖包

```
yum -y install zlib-devel bzip2-devel openssl-devel libffi-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make
```

解压和安装pythonn tgz 软件包

```
tar -xzvf /var/download/Python-3.7.4.tgz -C /usr/local/src/  # src目录是存放源码的目录,解压到src目录

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

**安装虚拟环境**

```
# 新建空文件夹 venv
mkdir /usr/local/程序目录/venv

# 进入 venv 文件夹
cd /usr/local/程序目录/venv

# 安装虚拟环境 最后一个 . 表示安装在当前目录
python -m venv .

# 激活虚拟环境
source /usr/local/程序目录/venv/bin/activate

# 退出虚拟环境
deactivate
```

-------- python 安装完成 --------

***python安装模块时利用python setup.py install语句执行时，出现一下报错问题***

```
ModuleNotFoundError: No module named 'setuptools'
```

该问题出现的原因就是：python默认是没有安装setuptools这个模块的，这也是一个第三方模块，所以在利用setup.py时会报错。

 (1）执行“ wget http://pypi.python.org/packages/source/s/setuptools/setuptools-0.6c11.tar.gz”命令，下载setuptools安装包；

（2）执行“ tar -xvf setuptools-0.6c11.tar.gz”命令，将setuptools包解压缩；

（3）执行“cd setuptools-0.6c11”命令，切换到setuptools对应目录；

（4）执行“python setup.py build”命令，编译setuptools；

（5）执行“python setup.py install”命令，安装setuptools；

（6）此时setuptools模块就安装成功了，就可正常使用python安装其他模块。

