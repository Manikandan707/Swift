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
    
    func serviceCall() {
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
            }
        }
        task.resume()
    }
    
    ///Test reset commit action...
}
