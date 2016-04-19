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
        
        let url = NetworkController.searchURLByCity(city)
        
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
}