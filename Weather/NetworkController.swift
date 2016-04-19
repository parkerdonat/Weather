//
//  NetworkController.swift
//  Weather
//
//  Created by Parker Donat on 4/18/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class NetworkController {
    
    static func dataAtURL(url: NSURL, completion:(success: Bool, resultData: NSData?) -> Void) {
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithURL(url) { (data, _, error) -> Void in
            
            guard let data = data  else {
                print(error?.localizedDescription)
                completion(success: false, resultData: nil)
                return
            }
            
            completion(success: true, resultData: data)
        }
        
        dataTask.resume()
    }
    
    static func serializedDataAtJson(data: NSData) -> [String: AnyObject]? {
        
        return (try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)) as? [String: AnyObject]
    }

}