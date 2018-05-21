//
//  EnumViewController.swift
//  iOSPrinciple_NamedTypes
//
//  Created by WhatsXie on 2018/5/21.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit

//定义一个表示学生类型的全新枚举类型 StudentType，他有三个成员分别是pupils（小学生，玩LOL最怕遇到这种队友了）、middleSchoolStudent（中学生，现在的中学生都很拽）、collegeStudents（大学生，据说大学生活很不错，注意断句）
//enum StudentType {
//    case pupils
//    case middleSchoolStudent
//    case collegeStudent
//}

//枚举的原始值(raw value)
enum StudentTypeRaw: Int{
    case pupils = 10
    case middleSchoolStudent = 15
    case collegeStudents = 20
}

//枚举的关联值(associated value)
//定义一个表示学生类型的枚举类型 StudentTypeAssociated，他有三个成员分别是pupils、middleSchoolStudent、collegeStudents
enum StudentTypeAssociated {
    case pupils(String)
    case middleSchoolStudent(Int, String)
    case collegeStudents(Int, String)
}


class EnumViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        testEnumStudentTypeRaw()
        
        testEnumStudentTypeAssociated()
        
        //1 * 2 * 3 * 4 * 5 * 6 = 720
        let sum = factorial(n: 6)
        print("sum:\(sum)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func testEnumStudentTypeRaw() {
        //  常量student1值是 10
        let student1 = StudentTypeRaw.pupils.rawValue
        print("student1:\(student1)")
        //  变量student2值是 15
        let student2 = StudentTypeRaw.middleSchoolStudent.rawValue
        print("student2:\(student2)")
        //  使用成员rawValue属性创建一个`StudentType`枚举的新实例
        let student3 = StudentTypeRaw.init(rawValue: 15)
        //  student3的值是 Optional<senson>.Type
        print("student3:\(type(of: student3))")
        //  student4的值是nil，因为并不能通过整数30得到一个StudentType实例的值
        let student4 = StudentTypeRaw.init(rawValue: 30)
        print("student4:\(student4)")
    }
    
    func testEnumStudentTypeAssociated() {
        //student1 是一个StudentType类型的常量，其值为pupil（小学生），特征是"have fun"（总是在玩耍）
        let student1 = StudentTypeAssociated.pupils("have fun")
        print("student1:\(student1)")
        //student2 是一个StudentType类型的常量，其值为middleSchoolStudent（中学生），特征是 7, "always study"（一周7天总是在学习）
        let student2 = StudentTypeAssociated.middleSchoolStudent(7, "always study")
        print("student2:\(student2)")
        //student3 是一个StudentType类型的常量，其值为collegeStudent（大学生），特征是 7, "always LOL"（一周7天总是在撸啊撸）
        let student3 = StudentTypeAssociated.middleSchoolStudent(7, "always LOL")
        print("student3:\(student3)")
        
        switch student3 {
        case .pupils(let things):
            print("student3 is a pupil and \(things)")
        case .middleSchoolStudent(let day, let things):
            print("student3 is a middleSchoolStudent and \(day) days \(things)")
        case .collegeStudents(let day, let things):
            print("student3 is a collegeStudent and \(day) days \(things)")
        }
    }
    
    //一个经典的通过递归算法求解n!（阶乘）的函数
    func factorial(n: Int)->Int {
        if n > 0 {
            return n * factorial(n: n - 1)
        } else {
            return 1
        }
    }

}
