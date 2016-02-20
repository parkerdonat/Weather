//
//  WeatherController.swift
//  Weather
//
//  Created by Parker Donat on 2/18/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class WeatherController {
    
    // This function passes in the city search parameter and, through a completion closure, provides a Weather object
    static func weatherBySearchCity(city: String, completion:(result: Weather?) -> Void) {
        
        let url = NetworkController.searchURLByCity(city)
        
        NetworkController.dataAtURL(url) { (resultData) -> Void in
            
            guard let resultData = resultData
                else {
                    print("No data return dude.")
                    completion(result: nil)
                    return
            }
            
            
            // Error handle to serialize the NSData to JSON objects else return nil as a completion.
            
            do {
                let weatherAnyObject = try NSJSONSerialization.JSONObjectWithData(resultData, options: NSJSONReadingOptions.AllowFragments)
                
                var weatherModelObject: Weather?
                
                if let weatherDictionary = weatherAnyObject as? [String: AnyObject] {
                    weatherModelObject = Weather(jsonDictionary: weatherDictionary)
                }
                
                completion(result: weatherModelObject)
                
            } catch {
                completion(result: nil)
            }
        }
    }
    
    static func weatherIconForIconCode(iconCode: String, completion:(image: UIImage?) -> Void) {
        
        let url = NetworkController.urlForIcon(iconCode)
        
        NetworkController.dataAtURL(url) { (resultData) -> Void in
            guard let resultData = resultData
            else {
                print("No data returned dude.")
                completion(image: nil)
                return
            }
            completion(image: UIImage(data: resultData))
        }
    }
}







