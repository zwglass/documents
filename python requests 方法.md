## python爬虫之网页的获取requests的使用

```
import requests

response  = requests.get("https://www.baidu.com")
print(type(response))
print(response.status_code)
print(type(response.text))
print(response.text)
print(response.cookies)
print(response.content)
print(response.content.decode("utf-8"))
```

**关于请求乱码问题, 下面两种方法解决：**

```
# 方法1
response.content.decode("utf-8)

# 方法2 
response.encoding="utf-8"
```

**请求：**

GET请求: URL查询字符串传递数据，通常我们会通过httpbin.org/get?key=val方式传递

```
data = {
    "name": "mike",
    "age": 18
}
response = requests.get("http://www.zwglass.com/person", params=data)

# 如果字典中的参数为None则不会添加到url上
```

**解析json:**

requests里面集成的json其实就是执行了json.loads()方法，两者的结果是一样的

获取二进制数据：在上面提到了response.content，这样获取的数据是二进制数据，同样的这个方法

也可以用于下载图片以及视频资源

添加请求头（headers）：

```
headers = {
	"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
}

response =requests.get("https://www.zwglass.com", headers=headers)
```

基本POST请求：
通过在发送post请求时添加一个data参数，这个data参数可以通过字典构造成，这样对于发送post请求就非常方便。

**响应：**

可以通过response获得很多属性

```
response.status_code    # 状态码
response.headers        # 请求头
response.cookies  		 # cookie
response.url
response.history
```

**requests高级用法**

文件上传

```
files= {"files":open("git.jpeg","rb")}

response = requests.post("http://httpbin.org/post",files=files)
        
# 获取cookie
for key,value in response.cookies.items():
    print(key+"="+value)
# 会话维持
s = requests.Session()
s.get("http://httpbin.org/cookies/set/number/123456")
esponse = s.get("http://httpbin.org/cookies")
```            

**证书验证**

现在的很多网站都是https的方式访问，所以这个时候就涉及到证书的问题

利用：`verify=False`

```
response = requests.get("https://www.12306.cn",verify=False)

# 代理设置
proxies= {
    "http":"http://127.0.0.1:9999",
    "https":"http://127.0.0.1:8888"
}
response  = requests.get("https://www.baidu.com",proxies=proxies)

# 如果代理需要设置账户名和密码,只需要将字典更改为如下：
proxies = {
		"http":"http://user:password@127.0.0.1:9999"
    }
    
# 如果你的代理是通过sokces这种方式则需要pip install "requests[socks]"

proxies= {
	"http": "socks5://127.0.0.1:9999",
	"https": "sockes5://127.0.0.1:8888"
}

# 超时设置
# 通过timeout参数可以设置超时的时间
# 认证设置（碰到需要认证的网站）
from requests.auth import HTTPBasicAuth

response = requests.get("http://120.27.34.24:9001/", auth=HTTPBasicAuth("user","123"))

# 或者
response = requests.get("http://120.27.34.24:9001/", auth=("user","123"))

```