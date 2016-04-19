//
//  WeatherViewController.swift
//  Weather
//
//  Created by Parker Donat on 4/18/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            
            WeatherController.weatherBySearchingCity(searchText, completion: { (weather) in
                guard let weatherResult = weather else { return }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    self.cityNameLabel.text = weatherResult.cityName
                    if let temperatureC = weatherResult.temperatureC {
                        self.temperatureLabel.text = String(temperatureC) + " °C"
                    } else {
                        self.temperatureLabel.text = "No temperature available"
                    }
                    self.mainLabel.text = weatherResult.main
                    self.descriptionLabel.text = weatherResult.description
    
                    ImageController.weatherIconForIconCode(weatherResult.iconString, completion: { (image) -> Void in
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.iconImageView.image = image
                        })
                    })
                })
            })
            
        }
        searchBar.resignFirstResponder()
    }
}
