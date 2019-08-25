##微信小程序常用方法、API封装之网络请求（wx.request）+ 接口（API）封装

首先了解一下，为什么要封装网络请求和API。
我认为一切封装都是为了简化开发，便于维护。比如，wx,request这个网络请求的方法，完整的写下来，是这样的：

```
	wx.request({
	  url: 'test.php', //仅为示例，并非真实的接口地址
	  data: {
	    x: '',
	    y: ''
	  },
	  header: {
	    'content-type': 'application/json' // 默认值
	  },
	  success (res) {
	    console.log(res)
	  },
	  fail(err){
		console.log(err)
	  }
	})
```

如果每个请求都这么写的话，首先你的代码实在是太繁琐了，其次api就直接暴露了，在web上可能人家一眼就能看到你的接口地址，不安全，而且一旦API有改动，你还得找到对应的页面去进行修改。工作量无形之中会增加很多。
那么我们就需要对网络请求和接口进行统一的封装和管理。

**注意，此封装方法，也适用于VUE的AXIOS**

首先，封装网络请求，这里采用es6的promise进行封装，我直接写在util.js里（关于promise，不懂的同学自行百度）：

```
/**
 * 封装微信的的request
 */
 
function request(url, data = {}, method = "GET",contenType="") {
  let _this = this
  var token = wx.getStorageSync('token') //现在很多都是通过token来判断登录态的
  return new Promise(function (resolve, reject) {
    wx.request({
      url: url,//网络请求的url（接口地址）
      data: data,//网络请求的参数
      method: method,//网络请求的类型，默认get，传入post则为post
      header:contenType === "json" ? {'content-type':'application/json'} : {'content-type':'application/x-www-form-urlencoded'},//传入“json”这个字符串就是json请求头，否则是form请求头，这里甚至可以写“四元运算添加更多请求头”
      success: function (res) {
        if (res.statusCode == 200) {
          if (res.data.errno == 401) { //具体的值由自己后台决定，我是401，且字段为errno，有的可能是code
          	//我这里401表示未登录，需要进行登录处理
            let pages = getCurrentPages();
            let currPage = null;
            if (pages.length) {
              currPage = pages[pages.length - 1];
            }
            //需要登录后才可以操作
            //(登录页不需要提醒)
            if(currPage.__route__ !== 'pages/me/me'){
              console.log(currPage.__route__)
              //这里的wx.showMoadl可以封装为alert，具体请见我的另一篇文章**微信小程序常用方法、API封装之alert + showToast + 节流函数** https://blog.csdn.net/qq_43156398/article/details/91982034
              wx.showModal({ 
                title: '提示',
                content: '请先登录',
                showCancel:false,
                success: function (res) {
                  if (res.confirm) {
                    wx.removeStorageSync("userInfo");
                    wx.removeStorageSync("token");
                    wx.switchTab({
                      url: '/pages/me/me'
                    });
                  }
                }
              });
            }
          } else {
            resolve(res.data);
          }
        } else {
          reject(res.errMsg);
        }

      },
      fail: err=> {
        reject(err)
        _this.showErrorToast('请求超时')
      }
    })
  });
}

//输出该方法，便于子页面调用
module.exports = {
	request
}
```

第二步，创建api.js文件。这里介绍两种封装且管理api接口的方法：
1.单独封装
如果你是像我上面写的那样把网络请求当做变量传入的，就用这种方法

```
var baseUrl = 'http://localhost:8080/api' //定义域名+端口号+公共路径
module.exports = {
	//登录，比如你的登录接口是http://localhost:8080/api/login,且是post请求，由于在request封装里已经写了http://localhost:8080/api/，所以这里不用多写了,
	  AuthLoginByWeixin:`${baseUrl}/login`, //登录,post请求
	  getNewsList:`${baseUrl}/newsList`
}

//子页面
const util = require('../../utils/util.js');
const api = require('../../config/api.js');

login(){
	let data = {userName:'',password:''}  //对应封装里的data
	util.request(api.login,'POST',data).then(res=>{
		console.log(res) //成功回调
	}).catch(err=>{
		console.log(err) //失败回调
	})
}

getNewsList(){
	let data = {page:1,size:10}
	util.request(api.getNewsList,data).then(res=>{
		console.log(res) //成功回调
	}).catch(err=>{
		console.log(err) //失败回调
	})
}
```

2.独立封装，我们在项目中常用的网络请求一般是以下几种：get,post,upLoad,deletes，put，那么，我们可以将这些请求进行独立封装，其实就是复制粘贴，命名不同，然后请求类型写死，比如

```
var baseUrl = 'http://localhost:8080/api'  //注意，现在把baseUrl写到封装里了
function _get(url, data = {},contenType="") { //函数名为_get
//function _post(url, data = {},contenType="") {//函数名为_post。这里我就不复制整段了，有变动的地方，我就注释起来标注
  let _this = this
  url = baseUrl + url
  var token = wx.getStorageSync('token') //现在很多都是通过token来判断登录态的
  return new Promise(function (resolve, reject) {
    wx.request({
      url: url,//网络请求的url（接口地址）
      data: data,//网络请求的参数
      method: 'GET',//网络请求的类型，写死GET
      //method: 'POST',//网络请求的类型，写死POST
      header:contenType === "json" ? {'content-type':'application/json'} : {'content-type':'application/x-www-form-urlencoded'},//传入“json”这个字符串就是json请求头，否则是form请求头，这里甚至可以写“四元运算添加更多请求头”
      success: function (res) {
        if (res.statusCode == 200) {
          if (res.data.errno == 401) { //具体的值由自己后台决定，我是401，且字段为errno，有的可能是code
          	//我这里401表示未登录，需要进行登录处理
            let pages = getCurrentPages();
            let currPage = null;
            if (pages.length) {
              currPage = pages[pages.length - 1];
            }
            //需要登录后才可以操作
            //(登录页不需要提醒)
            if(currPage.__route__ !== 'pages/me/me'){
              console.log(currPage.__route__)
              //这里的wx.showMoadl可以封装为alert，具体请见我的另一篇文章**微信小程序常用方法、API封装之alert + showToast + 节流函数** https://blog.csdn.net/qq_43156398/article/details/91982034
              wx.showModal({ 
                title: '提示',
                content: '请先登录',
                showCancel:false,
                success: function (res) {
                  if (res.confirm) {
                    wx.removeStorageSync("userInfo");
                    wx.removeStorageSync("token");
                    wx.switchTab({
                      url: '/pages/me/me'
                    });
                  }
                }
              });
            }
          } else {
            resolve(res.data);
          }
        } else {
          reject(res.errMsg);
        }

      },
      fail: err=> {
        reject(err)
        _this.showErrorToast('请求超时')
      }
    })
  });
}

module.exports = {
	_post,
	_get
}
```

也就是每个请求独立一段封装，改掉函数名和请求类型。封装文件的代码量会很多，但是它有个更方便的功能：把API和网络请求再次封装。这时候，我们api.js里就可以改一下了

```
//引入util里的get,post以及你独立封装的其它方法，我拿post和get举例

 import {_get,_post} from '../common/util'
 //这里就不用写var baseUrl = 'XXX'了，因为我们封装里有
 module.exports = {
	login(params){ //params对应封装里的data,变量而已，名字你们自己随便取
		return _post('/login',params)
	},
	getNewsLiss(params){
		return _get('/newsList',params)
	}
}

//子页面 js
	const api = require('../../config/api.js');
	login(){
		let data = {userName:'',password:''}
		api.login(data).then(res=>{
			console.log(res) //成功回调
		}).catch(err=>{
			console.log(err) //失败回调
		})
	},
	
	getNewsList(){
		let data = {page:'1',size:'10'}
		api.getNewsList(data).then(res=>{
			console.log(res) //成功回调
		}).catch(err=>{
			console.log(err) //失败回调
		})
	},
```

是不是简单了很多？
还有人可能会问，如果我接口上的参数是路径拼接的，比如http://localhost:8080/api/newsList/1/10（新闻列表，页数传1，每页请求数量为10条），那么这种如何操作呢？其实非常简单，我拿第二种独立封装举例```

这里我就不单独写了，直接写一起

```
getNewsLiss(params,page,size){
	//如果还需要传对象参数，可以保留params，如果不需要传，可以去掉，page为页数，size每页数量
	return _post('/newsList',params,page,size)
	}

	//子页面
	data:{
		page:1,
		size:10
	}

	getNewsList(){
		api.getNewsList(this.data.page,this.data.size).then(res=>{
			console.log(res) //成功回调
			}).catch(err=>{
			console.log(err) //失败回调
		})
	}
```


