# centos7 sendmail邮件服务安装

**安装**

```
yum install -y sendmail
yum install -y sendmail-cf
```

**查看安装结果**

```
[root@VM_0_11_centos tmp]# rpm -qa |egrep 'sendmail|mailx'
libreport-plugin-mailx-2.1.11-32.el7.centos.x86_64
sendmail-8.14.7-5.el7.x86_64
mailx-12.5-19.el7.x86_64
sendmail-cf-8.14.7-5.el7.noarch
```

**启动sendmail.service服务，进行SMTP验证**

```
systemctl start sendmail.service   # 启动

systemctl stop sendmail.service    # 停止

systemctl restart sendmail.service   # 重启

systemctl status sendmail.service   # 查看状态
```

**配置邮件服务 (关闭防火墙)**

```
1）配置Senmail的SMTP认证
将下面两行内容前面的dnl去掉。在sendmail文件中，dnl表示该行为注释行，是无效的，
    因此通过去除行首的dnl字符串可以开启相应的设置行。
[root@slave-node ~]# vim /etc/mail/sendmail.mc
......
TRUST_AUTH_MECH(`EXTERNAL DIGEST-MD5 CRAM-MD5 LOGIN PLAIN')dnl
define(`confAUTH_MECHANISMS', `EXTERNAL GSSAPI DIGEST-MD5 CRAM-MD5 LOGIN PLAIN')dnl

2) 设置Sendmail服务的网络访问权限（如果是直接本机调用，可以不用操作，采用默认的127.0.0.1。不过最后还是改成0.0.0.0）
将127.0.0.1改为0.0.0.0，意思是任何主机都可以访问Sendmail服务。
如果仅让某一个网段能够访问到Sendmail服务，将127.0.0.1改为形如192.168.1.0/24的一个特定网段地址。
[root@slave-node ~]# vim /etc/mail/sendmail.mc
......
DAEMON_OPTIONS(`Port=smtp,Addr=0.0.0.0, Name=MTA')dnl

3）生成配置文件
Sendmail的配置文件由m4来生成，m4工具在sendmail-cf包中。如果系统无法识别m4命令，说明sendmail-cf软件包没有安装
[root@slave-node ~]# m4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf

4）启动服务（如果发现sendmail dead but subsys locked，那就执行"service postfix status"查看postfix是否默认开启了，如果开启的话，就关闭postfix，然后再启动或重启sendmail服务即可。）
[root@slave-node ~]# systemctl start sendmail.service
Starting sendmail: [ OK ]
Starting sm-client: [ OK ]
systemctl restart sendmail.service
Stopping saslauthd: [ OK ]
Starting saslauthd: [ OK ]

将服务加入自启行列
[root@slave-node ~]# chkconfig sendmail on
[root@slave-node ~]# chkconfig saslauthd on
[root@slave-node ~]# chkconfig --list |grep sendmail
sendmail 0:off 1:off 2:on 3:on 4:on 5:on 6:off
[root@slave-node ~]# chkconfig --list |grep saslauthd
saslauthd 0:off 1:off 2:on 3:on 4:on 5:on 6:off
```

**测试发送邮箱**

```
（1）第一种方式：安装sendmail即可使用。
[root@slave-node ~]# yum -y install mailx

创建一个邮件内容文件，然后发邮件（注意-s参数后的邮件标题要用单引号，不能使用双引号，否则发邮件会失败！）
[root@slave-node ~]# echo 'This is test mail'>/root/content.txt 
[root@slave-node ~]# cat /root/content.txt
This is test mail
[root@slave-node ~]# mail -s 'Test mail' wang_shibo***@163.com < /root/content.txt
```