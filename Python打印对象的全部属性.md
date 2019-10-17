# Python打印对象的全部属性

## __dict__方法

遇到这样一个情况，要打印出一个对象的各种属性。但是不同对象的属性名都不一样，结构也不同，无法写一个代码来实现。然后我找到了__dict__，使用这个属性，可以动态获取到对象的所有属性，不包括公用属性。

```
class Teacher(object):
    display = "教师"  # 有公有属性
    def __init__(self,name,age,course,salary):
        self.name = name
        self.age = age
        self.course = course
        self.__salary = salary  # 也有私有属性
# 在定义一个别的类
class Student(object):
    display = "学生"
    def __init__(self,name,sid,classes,score):
        self.name = name
        self.sid = sid
        self.calssed = classes
        self.__score = score
def print_obj(obj):
    "打印对象的所有属性"
    print(obj.__dict__)
t1 = Teacher("Jerry",36,"Python",20000)
s1 = Student('Barry',12,"python01","B")
print_obj(t1)
print_obj(s1)
```

通过__dict__，就可以动态的获取到对象的全部属性。获得的是一个字典，属性名是字典的key，属性值是字典的value。从输出看，私有属性也可以获得，只是不包括公有属性。
然后，如果只想要属性值的话，可以对字典再加工。复习一下字典的3个方法：

dict.items() ：用元祖来存放key和vlaue
dict.keys() ： 只包含key
dict.values() ： 只包含value
上面3个方法返回的都是一个可迭代对象，可以用for遍历，但不是迭代器，不能用next方法。
然后用下面的方法打印


```
# 直接用字典了
dict1 = {'name': 'Jerry', 'age': 36, 'course': 'Python', '_Teacher__salary': 20000}
# 先看一下3个方法返回的可迭代对象
print(dict1.items())
print(dict1.keys())
print(dict1.values())
# 用下面的方法输出
print('\n'.join(('%s:%s' % item for item in dict1.items())))  # 每行一对key和value，中间是分号
print(' '.join(('%s' % item for item in dict1.keys())))  # 所有的key打印一行
print(' '.join(('%s' % item for item in dict1.values())))  # 所有的value打印一行
```

最后拆分一下打印的时候用到的方法

a = dict1.items() 这个是可迭代对象，可以用for遍历

b = ("%s:%s"%item for item in a) 用for循环遍历a，每一项是个元祖，把元祖转成"%s:%s"的字符串形式。最外面的( )就是转成一个迭代器。也可以用[ ]，转成列表。

c = ‘\n’.join(b) 最后用join()方法完成字符串的拼接

## __str__方法

又发现一个更好用的方法，并且可以获取到公有属性了。__str__方法是在打印这个对象的时候，不再打印对象的内存地址，而是打印__str__方法的返回值：

```
class Teacher(object):
    display = "教师"  # 有公有属性
    def __init__(self,name,age,course,salary):
        self.name = name
        self.age = age
        self.course = course
        self.__salary = salary  # 也有私有属性
    def __str__(self):  # 定义打印对象时打印的字符串
        return " ".join(str(item) for item in (
            self.display,self.name,self.age,self.course,self.__salary))
class Student(object):
    display = "学生"
    def __init__(self,name,sid,classes,score):
        self.name = name
        self.sid = sid
        self.calssed = classes
        self.__score = score
    def __str__(self):  # 其实一般可能都是这样简单用一下的
        return self.name
t1 = Teacher("Jerry",36,"Python",20000)
s1 = Student('Barry',12,"python01","B")
print(t1)
print(s1)
```

这里要注意，返回值必须是字符串，所以得传一个数据类型

`return " ".join(str(item) for item in `

`(self.display,self.name,self.age,self.course,self.__salary))` 这个也可以这么写

`return "%s %s %s %s %s"%(self.display,self.name,self.age,self.course,self.__salary)` 这么写虽然好理解，但是前面的%s的数量必须和后面的变量一致，如果要加1个或减1个变量，前后都得改。
__str__方法可以完全自定义自己对象的输出格式，既然是自定义的方法，那么还可以加上参数控制。但是调用的时候似乎并没有地方填参数。

其实是在print调用对象的时候，系统已经帮我们自动将print指向了__str__方法，也就是说 print(t1) 其实执行的是 print(t1.__str__()) ，这个时候我们就可以自己写全，然后加上参数。


```
class Teacher(object):
    display = "教师"  # 有公有属性
    def __init__(self,name,age,course,salary):
        self.name = name
        self.age = age
        self.course = course
        self.__salary = salary  # 也有私有属性
    def __str__(self,print_all=False):  # 定义打印对象时打印的字符串
        if print_all:
            return " ".join(str(item) for item in (
                self.display,self.name,self.age,self.course,self.__salary))
        else:
            return self.name
class Student(object):
    display = "学生"
    def __init__(self,name,sid,classes,score):
        self.name = name
        self.sid = sid
        self.calssed = classes
        self.__score = score
    def __str__(self):  # 其实一般可能都是这样简单用一下的
        return self.name
t1 = Teacher("Jerry",36,"Python",20000)
s1 = Student('Barry',12,"python01","B")
print(t1)
print(s1)
print(t1.__str__())  # 这个和上面的效果是一样的
print(t1.__str__(True))  # 现在可以带上参数了
```

其实这里并没不是打印了所有的属性，而是我们自定义了打印内容。但是自定义的位置是在类中的，这个位置是可以获取到全部属性的。

## 终极方法

其实就是把上面2个方法一起用。其实有上面2个方法应该就可以了，不过既然都搞明白了，留个记录也好。
先提一个点，在定义了__str__方法后，虽然打印出来是字符串，但是在其他时候传的值还是对象。如果想获取就是打印的值而不是对象，那么还是用对象__str__() 来传递，下面就是最终的例子：

```
class Teacher(object):
    display = "教师"  # 有公有属性
    def __init__(self,name,age,course,salary):
        self.name = name
        self.age = age
        self.course = course
        self.__salary = salary  # 也有私有属性
    def __str__(self,print_all=False):  # 定义打印对象时打印的字符串
        if print_all:
            return ' '.join(('%s' % item for item in self.__dict__.values()))
        else:
            return self.name
t1 = Teacher("Jerry",36,"Python",20000)
print(t1)
print(t1.__str__())
print(t1.__str__(True))
t1_obj = t1  # 虽然print的时候打印的是字符串，但是别的时候还是会把对象传过去的
print(t1_obj,type(t1_obj))  # 直接打印看不出来,但是可以看看数据类型
print(t1_obj.name,t1_obj.age)  # 确实内取到对象里的属性
t1_str = t1.__str__()  # 要传字符串，还差直接用__str__来获取
print(t1_str,type(t1_str))  # 这里获取到的就是字符串类型了
```