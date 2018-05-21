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
#### 枚举定义
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




