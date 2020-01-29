//
//  DataGetter.swift
//  JSON_Usage_Swift
//
//  Created by Felix Mbikogbia  on 1/28/20.
//  Copyright © 2020 Felix Mbikogbia . All rights reserved.
//

import Foundation
import UIKit

class DataGetter: NSObject {
    
    let MYJSONURL = "https://api.myjson.com/bins/f13o6"
    
    var dataArray = ["No data to display! :("]
    
    func getData(completion: @escaping (_ success: Bool) -> ()) {
        var success = true
        
        let actualUrl = URL(string: MYJSONURL)
        
        let task = URLSession.shared.dataTask(with: actualUrl!) { (data, response, error) in
            
            guard let _ = data, error == nil else {
                // we had an error or the data didn't come back
                success = false
                return
            }
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                print(jsonObj.value(forKey: "players")!)
                
                //getting the characters tag array from json and converting it to NSArray
                if let veggieArray = jsonObj.value(forKey: "players") as? Array<String> {
                    self.dataArray = veggieArray
                }
            }
            
            // call back to the completion handler that was passed in, notifying to do things (we don't care what)
            completion(success)
        }
        task.resume()
        
    }
    

}
