# nginx操作

## 基本命令

```
cd /usr/local/nginx/sbin/
./nginx             # 启动
./nginx -s stop     # 停止 先查出nginx进程id再使用kill命令强制杀掉进程
./nginx -s quit     # 此方式停止步骤是待nginx进程处理任务完毕进行停止
./nginx -s reload   # 重启

ps aux|grep nginx   # 查询nginx进程
```

**nginx 配置ssl**

```
server {
        #SSL 访问端口号为 443 1.15版本后 加ssl
        listen 443 ssl;
        #填写绑定证书的域名
        server_name www.zwglass.cn;
        #启用 SSL 功能; 1.15版本后不建议(ssl on;) listen 443 ssl; 
        # ssl on; 
        #证书文件名称
        ssl_certificate 1_www.XXX.cn_bundle.crt;
        #私钥文件名称
        ssl_certificate_key 2_www.XXX.cn.key;
        ssl_session_timeout 5m;
        #请按照这个协议配置
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        #请按照这个套件配置，配置加密套件，写法遵循 openssl 标准。
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
        ssl_prefer_server_ciphers on;
        # error_page  404           /404.html;
        # error_page   500 502 503 504  /50x.html;
        # 指定项目路径uwsgi
        location / {
            include uwsgi_params;
            uwsgi_connect_timeout 30;
            uwsgi_pass unix:/usr/local/emarket/script/uwsgi.sock;
        }
        # 指定静态文件路径
        location /static/ {
            alias  /usr/local/emarket/glasses_market_v1/static_assets/;
            index  index.html index.htm;
        }
    }
```

**nginx: [error] invalid PID number “” in “/run/nginx.pid” 错误解决方法**

```
nginx -c /etc/nginx/nginx.conf

# nginx.conf文件的路径可以从nginx -t的返回中找到。

nginx -s reload
```