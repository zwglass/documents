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