//
//  ViewController.swift
//  HelloWorld
//
//  Created by Manikandan K on 01/10/17.
//  Copyright © 2017 Manikandan K. All rights reserved.
//

import UIKit

//MARK: Class

class HWViewController: UIViewController {
    
    var sampleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sample for print variables
        printMethod(str: "Hello World...!!!")
        
        //Sample for method with paramters
        sampleMethodWithParamter(numA: 10, numB: 20)
        
        //Sample gaurd
        sampleGuard(text: "World")
        
        //Sample for wrapping and unwrapping
        wrappingAndUnWrapping(text: "World")
        
        //Sample for Structs
        sampleStructCall()
        
        //Int Extenstion
        sampleExtenstionUsage()
        
        //CustomExtensions
        swapTwoNumbers(a: 10, b: 20)
        
        //Sample closure
        sampleClosure1()
        
        // Longer Version
        let closure1 = sampleClosure2(from: 0, to: 10, closure: { number in return number * 10 })
        print("closure 1 = \(closure1)")
        // Shorter Version
        let closure2 = sampleClosure2(from: 0, to: 10, closure: { $0 * 10 })
        print("closure 2 = \(closure2)")
        
        //Web service example
        HWServiceManager.sharedManager.serviceCall()
        
        //GCD examples
        SampleDispatch.queueTest8()
        
    }
    
    /// This method used for print the variables
    ///
    /// - Parameter str: Instance of the string
    fileprivate func printMethod(str: String) {
        print("Hello World...!!!")
        print(str)
        print("String Value = ", str)
    }
    
    /// This is a sampe mehtod which is explains about the parameter passing
    ///
    /// - Parameters:
    ///   - numA: Integer value
    ///   - numB: Integer value
    private func sampleMethodWithParamter(numA: Int, numB: Int) {
        var sum: Int
        sum = numA + numB
        printMethod(str: String(sum))
    }
    
    /// This method explains about 'guard'
    ///
    /// - Parameter text: Instance of Stirng
    private func sampleGuard(text: String) {
        sampleString = "Hello"
        guard let sampleStr = sampleString else {
            printMethod(str: "No sampleString value")
            return
        }
        let concatenateStr = sampleStr + " " + text
        printMethod(str: concatenateStr)
    }
    
    /// This method used to unwrap the string
    ///
    /// - Parameter text: Instance of String
    private func wrappingAndUnWrapping(text: String) {
        if let sampleStr = sampleString {
            let concatenateStr = sampleStr + " " + text
            printMethod(str: concatenateStr)
        }
    }
    
    
    /// This method explains about the struct concept
    fileprivate func sampleStructCall() {
        let firstObj = SampleStruct(overAllMark: 100, percentage: 18)
        print(firstObj.calculatePercentageForMark())
        
        //This is called as struct value type
        var secondObj = firstObj
        secondObj.overAllMark = 500
        secondObj.percentage = 84
        print(secondObj.calculatePercentageForMark())
        
        let thirdObj = SampleStruct(overAllMark: 1200, percentage: 83)
        print(thirdObj.calculatePercentageForMark())
        
        //The first object values won't change.
        print(firstObj.overAllMark, firstObj.percentage)
        
        /*
         1) Structs are value types.
         2) Can't inherit
         3) Structs have handy memberwise initializers. All properties must be specified.
         */
    }
    
    
    /// This method will explain about the extention usage.
    fileprivate func sampleExtenstionUsage() {
        print(4.isOdd())
        print(2.isEven())
        
        5.times(task: {(i) in
            print(i)
        })
    }
    
    //This method will explains about the closure
    func sampleClosure1() {
        
        //Example 1 :
        let sayHello = {(name: String) -> String in
            return "Hello \(name)"
        }
        print(sayHello("Swift...!"))
        
        //Example 2 :
        
        let devide = {(value1: Int, value2: Int) -> Int in
            return value1 / value2
        }
        let result = devide(100, 10)
        print("Closeure example 1 : \(result)")
        
        
        //Closure Type 1 :
        let timesTenClosure2: (Int) -> Int = { x in return x * 10 }
        print("Closeure Type 1 : \(timesTenClosure2(10))")
        
        
        //Closure Type 2 :
        let timesTenClosure1: (Int) -> Int = { $0 * 10 }
        print("Closeure Type 2 : \(timesTenClosure1(10))")
        
        let multiply: (Int, Int) -> Int = { ($0 * $1) }
        print("Closeure Type 3 : \(multiply(10, 5))")
    }
    
    func sampleClosure2(from: Int, to: Int, closure: (Int) -> (Int)) -> Int {
        var sum = 0
        for i in from...to {
            sum += closure(i)
        }
        return sum
    }
    
    //FIXME: Need to exploare about the completion block.
    func sampleClosure3(input: String, completion: (String) -> Void) {
        
    }
    
}

//MARK: Struct

struct SampleStruct {
    var overAllMark: Float
    var percentage: Float
    
    
    /// This method will calculate the marks against given percentage.
    ///
    /// - Returns: Return the instance of the string
    func calculatePercentageForMark() -> String {
        let percentageValue = (overAllMark / 100 ) * percentage
        return String(percentageValue)
    }
}

//MARK: Extensions (Int)

extension Int {
    
    //var someInt = 3   //Error: ❌❌❌❌
    
    //1) Extensions may not contain stored properties
    
    func isOdd () -> Bool{
        return self % 2 != 0
    }
    
    func isEven() -> Bool {
        return !isOdd()
    }
    
    func times(task: (Int)->()) {
        for i in 0..<self {
            task(i)
        }
    }
}

//MARK: Extensions (Custom)

extension HWViewController {
    func swapTwoNumbers(a: Int, b: Int) {
        var num1 = a
        var num2 = b
        print("Before swap a = \(num1) b = \(num2)")
        num1 = num1 + num2
        num2 = num1 - num2
        num1 = num1 - num2
        print("After swap a = \(num1) b = \(num2)")
    }
}

