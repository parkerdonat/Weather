//
//  WeatherController.swift
//  Weather
//
//  Created by Parker Donat on 4/18/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class WeatherController {

    static func weatherBySearchingCity(city: String, completion: (weather: Weather?) -> Void) {
        
        let url = self.searchURLByCity(city)
        
        NetworkController.dataAtURL(url) { (success, resultData) in
            
            var weatherModelObject: Weather?
            
            guard let resultData = resultData,
                json = NetworkController.serializedDataAtJson(resultData) else {
                    
                    print("No data returned.")
                    completion(weather: nil)
                    
                    return
            }
            
            weatherModelObject = Weather(jsonDictionary: json)
            completion(weather: weatherModelObject)
        }
    }
    
    private static let API_KEY = "4e63f48bb2d090d7fb7d80f6447ace6a"
    static let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    
    static func searchURLByCity(city: String) -> NSURL {
        let escapedCityString = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet())
        
        return NSURL(string: baseURL + "?q=\(escapedCityString!)" + "&appid=\(API_KEY)")!
    }
    
    static func urlForIcon(iconString: String) -> NSURL {
        return NSURL(string: "http://openweathermap.org/img/w/\(iconString).png")!
    }

}