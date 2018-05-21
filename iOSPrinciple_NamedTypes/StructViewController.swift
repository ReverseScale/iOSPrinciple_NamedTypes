//
//  StructViewController.swift
//  iOSPrinciple_NamedTypes
//
//  Created by WhatsXie on 2018/5/21.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
//定义一个 Student（学生）类型的结构体用于表示一个学生，Student的成员分别是语、数、外三科`Int`类型的成绩

//没有初始值
struct Student {
    var chinese: Int
    var math: Int
    var english: Int
}

//有初始值
struct Students {
    var chinese: Int = 50
    var math: Int = 50
    var english: Int = 50
}

//自定义初始化方法
struct Studentes {
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
    //修改数学成绩
    mutating func changeMath(num: Int) {
        self.math += num
    }
}

// Person 类
class Person {
    var name: String = "jack"
    let life: Int = 1
}

// People 结构体数据结构
struct People {
    var name: String = "jack"
    let life: Int = 1
}

class StructViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //error
//        let student1 = Student()

        let student2 = Student(chinese: 90, math: 80, english: 70)
        print("student2:\(student2)")
        
        let student3 = Students()
        print("student3:\(student3)")
        
        let student4 = Studentes()
        print("student4:\(student4)")

        let student5 = Studentes(chinese: 90, math: 80, english: 70)
        print("student5:\(student5)")

        var student6 = Studentes(stringScore: "70,80,90")
        print("student6:\(student6)")
        
        changeChinese(num: 20, student: &student6)
        print("student6 re-:\(student6)")

        var student7 = Studentes(chinese: 20, math: 30, english: 40)
        student7.changeMath(num: 10)
        print("student7:\(student7)")
        
        testClassChangeValue()
        testStructChangeValue()

    }
    
    //更改某个学生某门学科的成绩
    func changeChinese(num: Int, student: inout Studentes) {
        student.chinese += num
    }
    
    func testClassChangeValue() {
        var s1 = Person()
        var s2 = s1
        s2.name = "mike"
        print("class s1 name:\(s1.name)")
    }
    
    func testStructChangeValue() {
        var p1 = People()
        var p2 = p1
        p2.name = "mike"
        print("struct p1 name:\(p1.name)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
