//
//  HWServiceManager.swift
//  HelloWorld
//
//  Created by Manikandan K on 03/11/17.
//  Copyright © 2017 Manikandan K. All rights reserved.
//

import UIKit

class HWServiceManager: NSObject {

    static let sharedManager = HWServiceManager()
    
    func serviceCall(completion:@escaping (_ result: Any) -> Void) {
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=12.9760,80.2212&radius=1000&type=restaurant&keyword=hotels&key=AIzaSyBc_gU87l68hGZbtfMh-vFCzllMy1CEKP8"

        guard let requestURL = URL.init(string: url) else { return }
        
        let urlRequest = URLRequest.init(url: requestURL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                
                guard let urlData = data else { return }
                
                guard let json = (try? JSONSerialization.jsonObject(with: urlData, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else { return }
                
                print(json)

                
                var myNewDictArray = [[String:Any]]()
                if let dict = json["results"] as? [[String : Any]] {
                    myNewDictArray = dict
                    print(myNewDictArray)
                }
                
                if let string = myNewDictArray[0]["icon"] as? String {
                    print("icon = \(string)")
                }
                completion(json)
            }
        }
        task.resume()
    }
}

class SampleDispatch: NSObject {
    
    class func printApples(){
        print("printApples is running on = \(Thread.isMainThread ? "Main Thread":"Background Thread")")
        for i in 0..<3{
            print("🍏\(i)")
        }
    }
    
    class func printStrawberries(){
        print("printStrawberries is running on = \(Thread.isMainThread ? "Main Thread":"Background Thread")")
        for i in 0..<3{
            print("🍓\(i)")
        }
    }
    
    class func printBalls(){
        print("printBalls is running on = \(Thread.isMainThread ? "Main Thread":"Background Thread")")
        for i in 0..<3{
            print("🎱\(i)")
        }
    }

    
    class func queueTest1(){
        let queue = DispatchQueue(label: "com.knowstack.queue1")
        queue.async {
            self.printApples()
        }
        queue.async {
            self.printStrawberries()
        }
        queue.async {
            self.printBalls()
        }
        
    }
    
    class func queueTest2(){
        let queue1 = DispatchQueue(label: "com.knowstack.queue1")
        let queue2 = DispatchQueue(label: "com.knowstack.queue2")
        let queue3 = DispatchQueue(label: "com.knowstack.queue3")
        queue1.async {
            self.printApples()
        }
        queue2.async {
            self.printStrawberries()
        }
        queue3.async {
            self.printBalls()
        }
    }
    
    class func queueTest3(){
        let queue1 = DispatchQueue(label: "com.knowstack.queue1")
        let queue2 = DispatchQueue(label: "com.knowstack.queue2")
        let queue3 = DispatchQueue(label: "com.knowstack.queue3")
        queue1.sync {
            self.printApples()
        }
        queue2.async {
            self.printStrawberries()
        }
        queue3.async {
            self.printBalls()
        }
    }

    class func queueTest4(){
        let globalQueue = DispatchQueue.global()
        globalQueue.async {
            self.printApples()
        }
        globalQueue.async {
            self.printStrawberries()
        }
        globalQueue.async {
            self.printBalls()
        }
        
    }

    class func queueTest5(){
        let globalQueue = DispatchQueue.global()
        globalQueue.sync {
            self.printApples()
        }
        globalQueue.async {
            self.printStrawberries()
        }
        globalQueue.async {
            self.printBalls()
        }
        
    }

    class func queueTest6(){
        let mainQueue = DispatchQueue.main
        mainQueue.async {
            self.printApples()
        }
        
        mainQueue.async {
            self.printStrawberries()
        }
        mainQueue.async {
            self.printBalls()
        }
    }

    class func queueTest7(){
        let queue1 = DispatchQueue(label: "com.knowstack.queue1", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.global())
        let queue2 = DispatchQueue(label: "com.knowstack.queue1", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.global())
        
        queue1.async {
            self.printStrawberries()
        }
        queue2.async {
            self.printBalls()
        }
        
    }

    class func queueTest8(){
        let queue1 = DispatchQueue(label: "com.knowstack.queue1", qos:.utility, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.global())
        let queue2 = DispatchQueue(label: "com.knowstack.queue1", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.global())
        
        queue1.async {
            self.printStrawberries()
        }
        queue2.async {
            self.printBalls()
        }
        
    }

    class func queueTest9(){
        let queue1 = DispatchQueue(label: "com.knowstack.queue1", qos:.utility, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.global())
        let queue2 = DispatchQueue(label: "com.knowstack.queue1", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.global())
        
        queue1.asyncAfter(deadline: .now()+5.0) {
            print("In Print Strawberries = \(Date())")
            self.printStrawberries()
            
        }
        
        queue2.async {
            print("In Print Balls = \(Date())")
            self.printBalls()
            
        }
    }
}
