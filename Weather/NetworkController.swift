//
//  NetworkController.swift
//  Weather
//
//  Created by Parker Donat on 4/18/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class NetworkController {
    
    private static let API_KEY = "4e63f48bb2d090d7fb7d80f6447ace6a"
    static let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    
    static func searchURLByCity(city: String) -> NSURL {
        let escapedCityString = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet())
        
        return NSURL(string: baseURL + "?q=\(escapedCityString!)" + "&appid=\(API_KEY)")!
    }
    
    static func urlForIcon(iconString: String) -> NSURL {
        return NSURL(string: "http://openweathermap.org/img/w/\(iconString).png")!
    }
    
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