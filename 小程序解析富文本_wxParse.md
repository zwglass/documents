## 小程序解析富文本 wxParse

###第一步：下载wxParse

下载地址：https://github.com/icindy/wxParse

![down](https://github.com/zwglass/MyImages/blob/master/wxParse/github_down.jpeg?raw=true)

**点击下载**

![down path](https://github.com/zwglass/MyImages/blob/master/wxParse/github_downed_path.jpeg?raw=true)

**压缩包包含的文件，【红框文件】需要拷贝到小程序根目录**

![downPath exists](https://github.com/zwglass/MyImages/blob/master/wxParse/path_exists.jpeg?raw=true)

###第二步：使用教程

**1. 配制xx.wxml文件(配制到你用到的页面中)**

```
<import src="../../wxParse/wxParse.wxml"/> 
```

**2. 配制xx.wxss文件(配制到你用到的页面中)**

```
@import "../../wxParse/wxParse.wxss";
```

**3. 配制xx.js文件（配制到你用到的页面中）**

头部引用

```
var WxParse = require('../../wxParse/wxParse.js');
```

![parser config](https://github.com/zwglass/MyImages/blob/master/wxParse/config.jpeg?raw=true)

***onLoad()方法里使用***

```
article_content:WxParse.wxParse('article_content', 'html', res.data.article_content, that, 5)

/** 
* WxParse.wxParse(bindName , type, data, target,imagePadding) 
* 1.bindName绑定的数据名(必填) 
* 2.type可以为html或者md(必填) 
* 3.data为传入的具体数据(必填) 
* 4.target为Page对象,一般为this(必填) 
* 5.imagePadding为当图片自适应是左右的单一padding(默认为0,可选) 
*/
```

**4. xx.wxml文件里引用（引用到你用到的页面）**

```
<view><template is="wxParse" data="{{wxParseData:content.nodes}}" /></view>
```


<mark>完成这 4 步，就完美完成了，但是有的编辑器里面的图片不是绝对地址，所以会引起图片不显示的问题<mark>

######图片不显示问题

![wxParse bug](https://github.com/zwglass/MyImages/blob/master/wxParse/bug.jpeg?raw=true)

######代码所在位置

![wxParse bugLine](https://github.com/zwglass/MyImages/blob/master/wxParse/bug_line.jpg?raw=true)

<mark>这里的【server_url】就是指你的域名，我是直接在顶部【 ver】了一个变量【server_url】赋值的域名地址，所以你看到的这块代码出现了【server_url】！<mark>



