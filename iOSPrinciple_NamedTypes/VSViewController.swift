//
//  VSViewController.swift
//  iOSPrinciple_NamedTypes
//
//  Created by WhatsXie on 2018/5/21.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit

class StudentC{
    var name:String
    init(name:String) {
        self.name = name
    }
//    var date = NSDate()
    
}

struct StudentS{
    var name:String
    init( name:String) {
        self.name = name
    }
//    var date = NSDate()
}

class VSViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        testStudentC()
        testStudentS()
    }
    
    func testStudentC() {
//        测试1: 循环创建类和结构体
        let date = Date()
        for i in 0...100_000_000{
            let s = StudentC(name: "run run run")
        }
        print(Date().timeIntervalSince(date))
        
//
//        for i in 0...10_000_000{
//            let s = StudentS()
//        }
        
//        测试2:创建1000_000 个对象或者结构体放在数组中,查看内存占用率
//        var students:[StudentC] = []
//        // 创建
//        for i in 0...1000_000{
//            let s = StudentC(name: "酷走天涯")
//            students.append(s)
//        }
        
//        var students:[StudentC] = []
//        for i in 0...10_000_000{
//            let s = StudentC()
//            students.append(s)
//        }
        
//        测试3:对1_000_000个结构体实体和对象进行排序,测消耗时间
//        let date = Date()
//        students.sort { (stu1, stu2) -> Bool in
//            return stu1.name > stu2.name
//        }
//        print(Date().timeIntervalSince(date))
    }
    
    func testStudentS() {
//        测试1: 循环创建类和结构体
        let date = Date()
        for i in 0...1000_000_000{
            let s = StudentS(name: "run run run")
        }
        print(Date().timeIntervalSince(date))
        
        
//        for i in 0...10_000_000{
//            let s = StudentS()
//        }
        
//        测试2:创建1000_000 个对象或者结构体放在数组中,查看内存占用率
//        var students:[StudentS] = []
//        for i in 0...1000_000{
//            let s = StudentS(name: "酷走天涯")
//            students.append(s)
//        }
        
//        for i in 0...10_000_000{
//            let s = StudentS()
//            students.append(s)
//        }
        
//        测试3:对1_000_000个结构体实体和对象进行排序,测消耗时间
//        let date = Date()
//        students.sort { (stu1, stu2) -> Bool in
//            return stu1.name > stu2.name
//        }
//        print(Date().timeIntervalSince(date))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
