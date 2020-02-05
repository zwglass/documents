# 创建django程序

- 1. 新建python3虚拟环境 `env1`

```
python3 -m venv env1
```

- 2. 进入虚拟环境

```
source env1/bin/activate
```

- 3. 安装django, 创建django项目 helloworld, 创建应用app1

```
# 安装django
pip install django

# 创建django项目
django-admin startproject helloworld

# 进入helloword
cd helloworld

# 创建应用 app1
python manage.py startapp app1
```

- 4. VS code 打开创建helloworld的项目 并配置项目

```
# shift + command + p 组合键打开
Python: 选择解析器
# 如果没有刚刚创建的虚拟环境选项, 随便先选一个
# 左边的资源管理器会多一个 .vscode 的隐藏文件夹 修改文件夹下的settings.json 文件

{
    "python.pythonPath": "python3虚拟环境目录/bin/python3"
}

# 安装 mysql 连接文件 mysqlclient
pip install mysqlclient

# settings.py 设置 app1 连接 mysql

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    
    'app1',	# 添加 app1
]

DATABASES = {
    'default': {
        # 'ENGINE': 'django.db.backends.sqlite3',
        # 'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'db_name',   			# 数据库名称
        'USER': 'root',					# 数据库登陆用户名
        'PASSWORD': '',					# 登陆密码
        'HOST': '127.0.0.1',			# 数据库地址
        'PORT': '3306',					# 数据库端口
        'CHARSET': 'utf8',				# 数据库编码
        'ATOMIC_REQUEST': True,
        'OPTIONS': {
            'autocommit': True,
        },
    }
}

# 同步数据库
python manage.py makemigrations
python manage.py migrate
```

***Django REST framework 开发api 安装***

```
pip install djangorestframework
```