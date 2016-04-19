
//
//  Weather.swift
//  Weather
//
//  Created by Parker Donat on 4/18/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class Weather {
    
    static let kWeatherKey = "weather"
    static let kMainKey = "main"
    static let kDescriptionKey = "description"
    static let kIconKey = "icon"
    static let kTemperatureKey = "temp"
    static let kNameKey = "name"
    
    
    var main = ""
    var description = ""
    var iconString = ""
    var cityName = ""
    var iconImage: UIImage?
    var temperatureK: Float?
    var temperatureC: Float? {
        get {
            if let temperatureK = temperatureK {
                return temperatureK - 273.15
            } else {
                return nil
            }
        }
    }
    
    
    init?(jsonDictionary: [String: AnyObject]) {
        
        guard let arrayUsingWeatherKey = jsonDictionary[Weather.kWeatherKey] as? [[String: AnyObject]],
            main = arrayUsingWeatherKey[0][Weather.kMainKey] as? String,
            description = arrayUsingWeatherKey[0][Weather.kDescriptionKey] as? String,
            iconString = arrayUsingWeatherKey[0][Weather.kIconKey] as? String else { return }
        
            self.main = main
            self.description = description
            self.iconString = iconString
        
        guard let mainTemp = jsonDictionary[Weather.kMainKey] as? [String: AnyObject],
            let temperature = mainTemp[Weather.kTemperatureKey] as? NSNumber else { return }
        
            self.temperatureK = Float(temperature)
        
        guard let cityName = jsonDictionary[Weather.kNameKey] as? String else { return }
        
            self.cityName = cityName
    }
}