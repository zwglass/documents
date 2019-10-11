# centos7 MariaDB详细教程

***目前Centos下默认支持的数据库是MariaDB,MariaDB是mysql的增强版本***

**Centos上安装MariaDB非常简单（使用前要测试Centos环境下网络是否是可用的）
首先先检查是否已经有MariaDB或者mysql的包，选择全部删除。**

```
rpm -qa | grep mariadb              #查询mariadb包

# 如果有的话，全部删除
rpm -e --nodeps mariadb-*           #删除所有包

# 删除mysql
rpm -e mysql-*

# 一键安装MariaDB
yum install mariadb-server mariadb
```

**常用命令**

```
systemctl start mariadb                    #启动服务
systemctl enable mariadb                   #设置开机启动
systemctl restart mariadb                  #重新启动
systemctl stop mariadb.service             #停止MariaDB
```

**登录 MariaDB 验证是否成功(初始密码为空直接跳过即可)**
```
mysql -u root -p
```

**进行MariaDB的相关简单配置,使用mysql_secure_installation命令进行配置(设置密码等等)**

```
mysql_secure_installation
```