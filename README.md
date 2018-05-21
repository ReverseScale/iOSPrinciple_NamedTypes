# iOSPrinciple_NamedTypes
Principle NamedTypes 

### 前言 

在开发过程中常常需要用到系统提供的基础类型之外的的类型，Swift 作为一款成长中的语言，自然敏锐的注意到这一点，所以 Swift 允许我们根据自己的需要构建属于自己的类型系统，以便于更加灵活和方便的开发程序并其称之为named types。

Named types 的四种类型：
* enum
* struct
* class
* protocol

相比于 Objective-C 中的这三者，Swift 将 enum 和 struct 变得更加灵活且强大，并且赋予了他们很多和class 相似的属性实现更加丰富多彩的功能。

本文重点介绍在 Swift 中 enum 和 struct 的定义和新特性以及两者与 class 之间的异同。

### 枚举（enum）
Swift 中的枚举的定义与C家族有些许不同，Swift 中枚举定义是“为一组有限种可能性的相关值提供的通用类型”，而在 C/C++/C# 中，“枚举是一个被命名的整型常数的集合”。

使用枚举可以类型安全并且有提示性地操作这些值。与结构体、类相似，使用关键词enum来定义枚举，并在一对大括号内定义具体内容包括使用case关键字列举成员。

就像下面一样：

```swift
enum StudentType {
    case pupils
    case middleSchoolStudent
    case collegeStudent
}
```

上面的代码可以读作：如果存在一个StudentType的实例，他要么是pupils （小学生）、要么是middleSchoolStudent（中学生）、要么是collegeStudent（大学生）。

和C、objective-c中枚举的不同，Swift 中的枚举成员在被创建时不会分配一个默认的整数值。而且不强制要求给枚举中的每一个成员都提供值。

> 如果一个值（所谓“原始值”）要被提供给每一个枚举成员，那么这个值可以是字符串、字符、任意的整数值，或者是浮点类型。

Swift中定义的枚举只需要帮助我们表明不同的情况就够了，他的成员可以没有值，也可以有其他类型的值，不像 OC 中枚举值只局限于整数类型，缺点就是你再回去写 OC 时可能会不习惯。

枚举中有两个很容易混淆的概念：原始值(raw value)、关联值(associated value)，两个词听起来比较模糊，下面简单介绍一下：

* 枚举的原始值(raw value)

枚举成员可以用相同类型的默认值预先填充，这样的值我们称为原始值(raw value)。

```swift
//枚举的原始值(raw value)
enum StudentType: Int{
    case pupil = 10
    case middleSchoolStudent = 15
    case collegeStudents = 20
}
```

上面的StudentType中三个成员分别被Int类型的10 、15、 20填充表示不同阶段学生的年龄。

> 注意：Int修饰的是StudentType成员原始值的类型而不是StudentType的类型，StudentType类型从定义开始就是一个全新的枚举类型。

```swift
//  常量student1值是 10
let student1 = StudentType.pupils.rawValue
print("student1:\(student1)")
//  变量student2值是 15
let student2 = StudentType.middleSchoolStudent.rawValue
print("student2:\(student2)")
//  使用成员rawValue属性创建一个`StudentType`枚举的新实例
let student3 = StudentType.init(rawValue: 15)
//  student3的值是 Optional<senson>.Type
print("student3:\(type(of: student3))")
//  student4的值是nil，因为并不能通过整数30得到一个StudentType实例的值
let student4 = StudentType.init(rawValue: 30)
print("student4:\(student4)")
```

![](http://og1yl0w9z.bkt.clouddn.com/18-5-21/19587755.jpg)

使用原始值初始化器这种方式初始化创建得到StudentType的实例student4是一个StudentType的可选类型，因为并不是给定一个年龄就能找到对应的学生类型，比如在StudentType中给定年龄为30就找不到对应的学生类型（很可能30岁的人已经是博士了）

总之，原始值是为枚举的成员们绑定了一组类型必须相同值不同的固定的值（可能是整型，浮点型，字符类型等等）。这样很好解释为什么提供原始值的时候用的是等号。

* 枚举的关联值(associated value)

关联值和原始值不同，关联值更像是为枚举的成员们绑定了一组类型，不同的成员可以是不同的类型(提供关联值时用的是括号)。例如下面的代码：

```swift
//枚举的关联值(associated value)
//定义一个表示学生类型的枚举类型 StudentType，他有三个成员分别是pupils、middleSchoolStudent、collegeStudents
enum StudentTypeAssociated {
    case pupils(String)
    case middleSchoolStudent(Int, String)
    case collegeStudents(Int, String)
}
```

这里我们并没有为StudentType的成员提供具体的值，而是为他们绑定了不同的类型，分别是pupil绑定String类型、middleSchoolStudent和collegeStudents绑定（Int， String）元祖类型。接下来就可以创建不同StudentType枚举实例并为对应的成员赋值了。

```swift
//student1 是一个StudentType类型的常量，其值为pupil（小学生），特征是"have fun"（总是在玩耍）
let student1 = StudentTypeAssociated.pupils("have fun")
print("student1:\(student1)")
//student2 是一个StudentType类型的常量，其值为middleSchoolStudent（中学生），特征是 7, "always study"（一周7天总是在学习）
let student2 = StudentTypeAssociated.middleSchoolStudent(7, "always study")
print("student2:\(student2)")
//student3 是一个StudentType类型的常量，其值为collegeStudent（大学生），特征是 7, "always LOL"（一周7天总是在撸啊撸）
let student3 = StudentTypeAssociated.middleSchoolStudent(7, "always LOL")
print("student3:\(student3)")
```

这个时候如果需要判断某个StudentType实例的具体的值就需要这样做了：

```swift
switch student3 {
    case .pupils(let things):
        print("is a pupil and \(things)")
    case .middleSchoolStudent(let day, let things):
        print("is a middleSchoolStudent and \(day) days \(things)")
    case .collegeStudents(let day, let things):
        print("is a collegeStudent and \(day) days \(things)")
}
```

![](http://og1yl0w9z.bkt.clouddn.com/18-5-21/44000116.jpg)

控制台输出：is a collegeStudent and 7 days always LOL，看到这你可能会想，是否可以为一个枚举成员提供原始值并且绑定类型呢，答案是不能的！因为首先给成员提供了固定的原始值，那他以后就不能改变了；而为成员提供关联值(绑定类型)就是为了创建枚举实例的时候赋值。

* 递归枚举

递归枚举是拥有另一个枚举作为枚举成员关联值的枚举。

关于递归枚举我们可以拆封成两个概念来看：递归 + 枚举。递归是指在程序运行中函数（或方法）直接或间接调用自己的这样一种方式，其特点为重复有限个步骤、格式较为简单。

下面是一个经典的通过递归算法求解n!（阶乘）的函数。

```swift
func factorial(n: Int)->Int {
    if n > 0 {
        return n * factorial(n: n - 1)
    } else {
        return 1
    }
}
    //1 * 2 * 3 * 4 * 5 * 6 = 720
    let sum = factorial(n: 6)
```

函数factorial (n: int)-> Int在执行过程中很明显的调用了自身。结合枚举的概念我们这里可以简单的理解为递归枚举类似上面将枚举值本身传入给成员去判断的情况。

可以看出Swift中枚举变得更加灵活和复杂，有递归枚举的概念，还有很多和类类似的特性，比如：计算属性用来提供关于枚举当前值的额外信息；实例方法提供与枚举表示值相关的功能；定义初始化器来初始化成员值；而且能够遵循协议来提供标准功能等等。

### 结构体（struct）

结构体是由一系列具有相同类型或不同类型的数据构成的数据集合。结构体是一种值类型的数据结构，在Swift中常常使用结构体封装一些属性甚至是方法来组成新的复杂类型，目的是简化运算。

定义好的结构体存在一个自动生成的成员初始化器，使用它来初始化结构体实例的成员属性。

```swift
struct Student {
    var chinese: Int
    var math: Int
    var english: Int
}
```

看到木有，定义结构体类型时其成员可以没有初始值，要是类那个坑货早报错了...(提醒这个类没有被初始化)

* 结构体实例的创建

创建结构体和类的实例的语法非常相似，结构体和类两者都能使用初始化器语法来生成新的实例。

最简单的语法是在类或结构体名字后面接一个空的圆括号，例如:

```swift
let student1 = Student()
```

这样就创建了一个新的类或者结构体的实例，任何成员都被初始化为它们的默认值（前提是成员均有默认值）。

![](http://og1yl0w9z.bkt.clouddn.com/18-5-21/29012933.jpg)

但是如果定义结构体时没有设置初始值，像上面直接()的写法编译器会报错（出来混迟早是要给初始值的）

```swift
//使用Student类型的结构体创建Student类型的实例（变量或常量）并初始化三个成员（这个学生的成绩会不会太好了点）
let student2 = Student(chinese: 90, math: 80, english: 70)
```

所有的结构体都有一个自动生成的成员初始化器，你可以使用它来初始化新结构体实例的成员就像上面一样（前提是没有自定义的初始化器）。如果我们在定义Student时为他的成员赋上初值，那么下面的代码是编译通过的：

```swift
struct Students {
    var chinese: Int = 50
    var math: Int = 50
    var english: Int = 50
}
let student3 = Students()
print("student3:\(student3)")
```

![](http://og1yl0w9z.bkt.clouddn.com/18-5-21/72665728.jpg)

总之，定义结构体类型时其成员可以没有初始值，但是创建结构体实例时该实例的成员必须有初值。

* 自定义的初始化器

当我们想要使用自己的方式去初始化创建一个Student类型的实例时，系统提供的成员初始化器可能就不够用了。例如，我们希望通过如下方式创建实例时，就需要自定义初始化方法了：

```swift
let student5 = Student(stringScore: "70,80,90")
```

自定义初始化方法

```swift
struct Student {
    var chinese: Int = 50
    var math: Int = 50
    var english: Int = 50
    init() {}
    init(chinese: Int, math: Int, english: Int) {
        self.chinese = chinese
        self.math = math
        self.english = english
    }
    init(stringScore: String) {
        let cme = stringScore.characters.split(separator: ",")
        chinese = Int(atoi(String(cme.first!)))
        math = Int(atoi(String(cme[1])))
        english = Int(atoi(String(cme.last!)))
    }
}
let student6 = Student()
let student7 = Student(chinese: 90, math: 80, english: 70)
let student8 = Student(stringScore: "70,80,90")
```

一旦我们自定义了初始化器，系统自动的初始化器就不起作用了，如果还需要使用到系统提供的初始化器，在我们自定义初始化器后就必须显式的定义出来。

![](http://og1yl0w9z.bkt.clouddn.com/18-5-21/18822147.jpg)

* 定义其他方法

如果此时需要修改某个学生某科的成绩，该如何实现呢？可以定义下面的方法：

```swift
//更改某个学生某门学科的成绩
func changeChinese(num: Int, student: inout Student){
    student.chinese += num
}
changeChinese(num: 20, student: &student7)
```

此时student7的语文成绩就由原来的70被修改到了90

![](http://og1yl0w9z.bkt.clouddn.com/18-5-21/19059693.jpg)

但是此方法有两个明显的弊端：

1.学生的语文成绩chinese是Student结构体的内部成员，一个学生的某科成绩无需被Student的使用者了解。即我们只关心学生的语文成绩更改了多少，而不是关心学生语文成绩本身是多少。

2.更改一个学生的语文成绩本身就是和Student结构体内部成员计算相关的事情，我们更希望达到如下形如：

```swift
student7.changeChinese(num: 10) 
```

因为只有学生本身清楚自己需要将语文成绩更改多少（更像是面向对象封装的思想）。很明显此时changeChinese(num:)方法是Student结构体内部的方法而不是外部的方法，所以我定义了一个修改某个学生数学成绩的内部方法用于和之前修改语文成绩的外部方法对比：

```swift
struct Studentes {
    var chinese: Int = 50
    var math: Int = 50
    var english: Int = 50
    //修改数学成绩
    mutating func changeMath(num: Int) {
        self.math += num
    }
}
var student7 = Studentes(chinese: 20, math: 30, english: 40)
student7.changeMath(num: 10)
print("student7:\(student7)")
```

运行结果：

![](http://og1yl0w9z.bkt.clouddn.com/18-5-21/64881545.jpg)

尽管两者都能达到同样的效果，但是把修改结构体成员的方法定义在结构体内部显得更加合理同时满足面向对象封装的特点。以上两点就是我们为Student结构体内部添加changeMath(num:)的原因，他让我们把类型相关的计算表现的更加自然和统一，即自己的事情应该用自己的方法实现不应该被别人关心。

值得一提的是在结构体内部方法中如果修改了结构体的成员，那么该方法之前应该加入：mutating关键字。由于结构体是值类型，Swift规定不能直接在结构体的方法（初始化器除外）中修改成员。原因很简单，结构体作为值的一种表现类型怎么能提供改变自己值的方法呢，但是使用mutating我们便可以办到这点，当然这也是和类的不同点。

* 常见的结构体

Swift中很多的基础数据类型都是结构体类型，下面列举的是一些常用的结构体类型：

```swift
//表示数值类型的结构体：
Int，Float，Double，CGFloat...
//表示字符和字符串类型的结构体
Character，String...
//位置和尺寸的结构体
CGPoint，CGSize...
//集合类型结构体
Array，Set，Dictionary...
```

很多时候你不细心观察的话可能不会想到自己信手拈来的代码中居然藏了这么多结构体。另外有时候在使用类和结构体的时候会出现下面的情况

类方法：
```swift
// Person 类
class Person {
    var name: String = "jack"
    let life: Int = 1
}
var s1 = Person()
var s2 = s1
s2.name = "mike"
s1
```

结构体方法：
```swift
// People 结构体数据结构
struct People {
    var name: String = "jack"
    let life: Int = 1
}
var p1 = People()
var p2 = p1
p2.name = "mike"
p1
```

![](http://og1yl0w9z.bkt.clouddn.com/18-5-21/26226782.jpg)

细心的同学可能已经发现了其中的诡异。变量s1、s2是Person类的实例，修改了s2的name属性，s1的name也会改变；而p1、p2作为People结构体的实例，修改了p1的name属性，p2的name并不会发生改变。这是为什么呢？

类能够改变是因为，类是引用类型，内部做浅拷贝处理，本质是指向同一个对象，自然可以改name；
结构体之前已经说过是值类型，内部做深拷贝处理，会重新生成一个对象，在复制时修改一个实例的数据并不影响副本的数据。

### 性能对比

其实本质是对比值类型和引用类型的性能，因此擂台上的选手就是结构体（struct）和类（class）。

#### 测试1: 循环创建类和结构体

a.执行1亿次类创建

```swift
// 定义类
class StudentC{
    var name:String
    init(name:String) {
        self.name = name
    }
}
// 统计时间
let date = Date()
for i in 0...100_000_000{
    let s = StudentC(name: "酷走天涯")
}
print(Date().timeIntervalSince(date))
```

运行三次结果:
> 19.3928480148315
> 20.9919492812921
> 20.7549253872943

b.执行10亿次结构体创建

```swift
// 定义结构体
struct StudentS{
    var name:String
    init( name:String) {
        self.name = name
    }
}
let date = Date()
for i in 0...1000_000_000{
    let s = StudentS(name: "酷走天涯")
}
print(Date().timeIntervalSince(date))
```

运行三次结果:
> 9.99221454212455
> 10.9281648273917
> 10.7281881727434

我们上面的属性为基本数据类型,我们将属性改为对象测试一下速度

c.创建10_000_000个对象

```swift
class StudentC{
    var date = NSDate()
}
for i in 0...10_000_000{
    let s = StudentS()
}
```
测试结果:

> 6.38509398698807
> 6.43649202585222
> 6.39519000053406

d.创建10_000_000个结构体实例

```swift
struct StudentS{
    var date = NSDate()
}
for i in 0...10_000_000{
    let s = StudentS()
}
```
测试结果:

> 4.38509398698807
> 4.43649202585222
> 4.39519000053406

结论：创建结构体要比创建对象速度快

#### 测试2:创建1000_000 个对象或者结构体放在数组中,查看内存占用率

a.循环创建1000_000个对象

```swift
class StudentC{
    var name:String
    init( name:String) {
        self.name = name
    }
}
var students:[StudentC] = []
// 创建
for i in 0...1000_000{
let s = StudentC(name: "酷走天涯")
students.append(s)
}
```

运行结果:

> 内存占用61.8MB

b.循环创建1000_000个结构体

```swift
struct StudentS{
    var name:String
    init( name:String) {
        self.name = name
    }
}
var students:[StudentS] = []
for i in 0...1000_000{
let s = StudentS(name: "酷走天涯")
students.append(s)
}
```

运行结果:

> 内存占用32.6MB

照样,我们将基本属性改为对象继续测试

c.10_000_000 个对象添加到数组中

```swift
class StudentC{
    var date = NSDate()
}
var students:[StudentC] = []
for i in 0...10_000_000{
    let s = StudentC()
    students.append(s)
}
```
测试结果:

> 占内存538.7MB

d.10_000_000 个结构体添加到数组中

```swift
struct StudentS{
    var date = NSDate()
}
for i in 0...10_000_000{
    let s = StudentS()
    students.append(s)
}
```
测试结构:

> 占用225.7MB

结论：创建相同属性的结构体比类更加节省内存

#### 测试3:对1_000_000个结构体实体和对象进行排序,测消耗时间

a.对1_000_000个结构体实体进行排序

```swift
let date = Date()
students.sort { (stu1, stu2) -> Bool in
    return stu1.name > stu2.name
}
print(Date().timeIntervalSince(date))
```

运行结果:

> 13.3783949613571
> 13.6793909668922

b.对1_000_000个对象进行排序

```swift
let date = Date()
students.sort { (stu1, stu2) -> Bool in
    return stu1.name > stu2.name
}
print(Date().timeIntervalSince(date))
```

运行结果:

> 6.70881998538971
> 6.60394102334976

结论: 在数据量比较大的排序中,结构体排序的速度比较慢,因为结构体是值类型,排序的时候,需要大量的赋值运算。而对象只需要交换地址即可。

### 对比总结

#### 枚举、结构体、类的共同点：

* 定义属性和方法；
* 下标语法访问值；
* 初始化器；
* 支持扩展增加功能；
* 可以遵循协议；

#### 结构体、类的不同点：

* 类可以继承,结构体不能继承；
* 类能够在运行时检查和解释类实例的类型；
* Deinitializers使一个类的实例来释放任何资源分配；
* 类有引用计数,允许对象被多次引用；

#### 类特有的功能：

* 继承；
* 允许类型转换；
* 析构方法释放资源；
* 引用计数；

#### 如何选择使用：

当你使用Cocoa框架的时候，很多API都要通过NSObject的子类使用，所以这时候必须要用到引用类型class。在其他情况下，有下面几个准则：

1.什么时候该用值类型：

* 要用==运算符来比较实例的数据时
* 你希望那个实例的拷贝能保持独立的状态时
* 数据会被多个线程使用时

2.什么时候该用引用类型（class）：   

* 要用==运算符来比较实例身份的时候
* 你希望有创建一个共享的、可变对象的时候

3.类和结构体在效率上的差异：

结构体创建速度,内存占用更小,如果需要使用复杂的运算,这个时候,就需要综合考虑两者的有缺点了。

> 以上原理解析文章来源：https://www.jianshu.com/p/51f99a352838，http://www.cocoachina.com/swift/20161221/18377.html


