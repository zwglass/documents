## django model 的操作

### 一. 字段
**1.Django 的字段**

```
datetime.date
datetime.datetime

AutoField
BigAutoField
BigIntegerField
CharField
DateField'     
DateTimeField
EmailField
Empty
FilePathField',
FloatField
IPAddressField
IntegerField
SmallIntegerField
TextField
TimeField
URLField

ManyToManyField(to='')  # 多对多 在数据库会多一个这两个id关系的表; 而外键是名字后多了一个_id

birth=models.DateTimeField(auto_now_add=True)    添加时,时间自动更新

birth=models.DateTimeField(auto_now=True)    修改时, 时间自动更新
```

**2. 例子**

```
from django.db import models


class User(models.Model):
    """
    用户表
    """
    USER_TITLE_CHOICES = (
        (1, 'Root'),
        (2, 'Administrator'),
    )
    mobile = models.CharField(verbose_name='用户手机', max_length=12, unique=True, db_index=True)
    name = models.CharField(verbose_name='名称', max_length=32, default='', blank=True)
    avatar = models.CharField(verbose_name='用户头像网络地址', max_length=255, default='', blank=True)
    title = models.IntegerField(verbose_name='职务', choices=USER_TITLE_CHOICES, default=1)
    password = models.CharField(verbose_name='密码', max_length=64, blank=True, default='')
    join_data = models.DateField(verbose_name='入职时间', auto_now_add=True)
    on_job = models.BooleanField(verbose_name='是否在职', default=True)

    class Meta:
    	 ordering = ['id']
        verbose_name = "用户表"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name
```

**3. 字段属性**

1. CharField(null =True )   null 什么都没有
2. CharField(blank =True )  blank 表示空白
3. name=models.CharField (db_column='myname')   指定名字取代'name'  但是使用还是用name
4. primary_key 主键
5. unique  唯一
6. sex=models.CharField (choices=(   ('1',''男), ('2','女')   ))      1,2实际存在数据库中


### 二. models 数据表属性(表)

```
class Person:

          class Meta:
                 ordering=('id')  # 排序 可以多个参数  
                 db_table= "Person2"  # 修改 表名     
                 verbose_name_plural=" 所有信息"  # 修改 在admin网页中的显示效果
                 verbose_name= " 个人信息"  # 修改 在admin网页中的显示效果
```

### 三. model 操作

1. ret = models.Person.object.all()  # 拿到所有对象; 返回值:对象列表 
2. ret = models.Person.object.all().values() # 拿到所有值; 返回值:整个是对象列表,元素每个字段的组成的字典或元组; value 可以指定条件: 例如values( 'id', 'name')          values_list('id', ' name')  
3. edit_obj= models.Person.object.get(id=1)  # 条件(id=1) 返回值: 一个对象,查询不到报错 


***修改到对象时  需要save()***

```
edit_obj.name=new_name
edit_obj.save()

# 也可以用
models.Person.object.filter(id=1).update(name)='new name'
```

4. ret=models.Person.object.filter(id=1)  # 过滤条件  拿到所有符合的 对象列表 不存在为空
5. ret=models.Person.object.exclude(id=1)  # 排除条件中的 
6. ret = models.Person.object.all().order_by( '-id ')  # 拿取时的顺序  -倒序  可以有多个条件; .reverse() 可以反序
7. distinct  # 对象去重
8. ret=models.Person.object.count()  # 计数     
9. ret=models.Person.object.first()  /  .last()      取对象列表的 第一个/最后一个 为空时 为None
10. ret=models.Person.object.first().exiss()         判断是否存在 `filter()`   `all()` 有这个方法 `get()` 没有 
11. models.Person.object.create(id=1,name=' wyc')  # 创建

### 四. 数据查询

- 单条查询 双下划线 查询

```
# __gt: >;  __gte: >=;
ret=models.Person.object.filter(id__gt =1)  # id>1的结果

# __lt: <; lte: <=;
ret=models.Person.object.filter(id__lt =4)  # id<4的结果

# __in: 列表中包含的内容;
ret=models.Person.object.filter(id__in =[1,3])  # id 为1,3 的结果

# __range: 之间的值
ret=models.Person.object.filter(id__range=[1,3])  # 1=< id <=3 的结果; 相当于filter(id__gt =1, id__lt=3)

# __contains: 字符串包含,忽律大小写
ret=models.Person.object.filter ( name__contains='e')  # name中包含 'e'的 结果

# __startwith: 开头包含, 忽律大小写
ret=models.Person.object.filter(name__startwith='e')  # name中以 'e'开头的结果

# __isnull: 为空的字段
name__isnull=True  # 取出name字段为空的
```

- 外键查询

```
1. 查询时 假如 book 是主键  press 是外键名字 出版社被关联

# book_obj.title  book_obj.price   拿到书名和价格
# book_obj.press_id  拿到book表中  id=1的 press_id 的值  book_obj.press 拿到的是出版社对象 
book_obj = models.Person.object.get(id=1) 

# 这样查询两次 才能才到出版社对象 查询慢
# 拿到书中 出版社为 北京出版社的书   正向查询__的作用
ret=models.book.object.filter(press__name='北京出版社')

#反向:
ret=models.press.object.get(id='1')
# ret.book_set 表名_set  django封装的方法 拿到的是管理对象
# ret.book_set.all()  拿到列表对象
```

- 聚合和分组

```
# 对一组数据 得到一个结果
from django.db.models import Max,Min,Sum,Avg,Count

# 聚合函数不能再 .了 终止语句

# 返回值为一个字典
ret=models.Book.objects.aggregate(Max('price'), Min('price'))

ret={'prcice_max':100,'price_min':27}              

# 改变key的名字
ret=models.Book.objects.aggregate(max=Max('price')){'max':100}     

# 分组

# 返回值:列表对象 每一个元素是字典按照book的id 去分组,
# 把这本书的author的作者数,添加到每一个字典中 {.....,'author__count':3 }
ret=models.Book.objects.annotate(Count('author')).values()

# 以初版社 本身id 分组 查询每组中最便宜的书
# 需要跨表查询书的价格  后加.values() 的作用是看列表对象
models.public.objects.annotate(Min('book_price'))

# 以书的出版社id 分组 查询每组 最便宜的书:
# 需要跨表查询出版社本身的id  如果再加values会出错
# .values('press__id')  这的values 是以什么分组以书分组,拿到书的作者个数 大与1的 书

models.book.objects.values('press__id').annotate(Min('price'))

# 一个列表加.values() 拿值
models.book.objects.annotate(Count('author')).filter(count__gt=1)
```

### FQ

***from django.db.models import F,Q***

##### 查询一个书的 表格中销量大于库存时的书有哪些:

```
ret= models.Book.objects.filter(sale__gt=F('kucun')).values
# 拿值返回一个列表 包含字段的字典 
```

例二: 让书的库存翻倍

```
models.Book.objects.all().update(kucun=F('kucun')*2)   
# F('name') 的作用就是动态的拿到name字段的值
```

Q: 有 &符号(且符号); |符号(或符号); ~符号(条件取反)

```
ret= models.Book.objects.filter(Q(id__lte=3) | Q(id__gte=6))
# 拿书的id 小于等于3 或 大于等于 6的
ret=models.Book.objects.filter(Q(price__lte=25) | Q(sale__gte=100))
# 拿书的price 小于等于25或 书的销量 大于等于100的
```


