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

**进行MariaDB的相关简单配置,使用`mysql_secure_installation`命令进行配置(设置密码等等)**

```
mysql_secure_installation
```

**设置 MariaDB 字符集 utf-8**

```
# 登录 MariaDB
mysql -u root -p

# 查看当前使用的字符集，应该有好几个不是UTF-8格式
SHOW VARIABLES LIKE 'character%

# 退出MariaDB
exit; 
```

修改相应的配置文件

```
# 编辑/etc/my.cnf
vim /etc/my.cnf

# 在[mysqld]标签下添加下面内容
default-storage-engine = innodb
innodb_file_per_table
max_connections = 4096
collation-server = utf8_general_ci
character-set-server = utf8

# 编辑/etc/my.cnf.d/client.cnf
vim /etc/my.cnf.d/client.cnf

# 在[client]标签下添加下面内容
default-character-set=utf8

# 编辑/etc/my.cnf.d/mysql-clients.cnf
vim /etc/my.cnf.d/mysql-clients.cnf

# 在[mysql]标签下添加下面内容
default-character-set=utf8
```

重启 MariaDB

```
systemctl restart mariadb
```

登录 MariaDB 再次检查编码

```
>show variables like 'character%'; 
+--------------------------+----------------------------+ 
| Variable_name | Value | 
+--------------------------+----------------------------+ 
| character_set_client | utf8 | 
| character_set_connection | utf8 | 
| character_set_database | utf8 | 
| character_set_filesystem | binary | 
| character_set_results | utf8 | 
| character_set_server | utf8 | 
| character_set_system | utf8 | 
| character_sets_dir | /usr/share/mysql/charsets/ | 
+--------------------------+----------------------------+
```

***说明:***

已建的库和表，编码不会改变。如果在已有库中继续建表，表依然会继承来自库的过去使用的编码;

***编码解释:***
 
- character_set_client为客户端编码方式;
- character_set_connection为建立连接使用的编码;
- character_set_database数据库的编码;
- character_set_results结果集的编码;
- character_set_server数据库服务器的编码;

只要保证以上四个采用的编码方式一样，就不会出现乱码问题。