//
//  ImageController.swift
//  Weather
//
//  Created by Parker Donat on 4/19/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class ImageController {
    
    static func weatherIconForIconCode(iconCode: String, completion:(image: UIImage?) -> Void) {
        let url = NetworkController.urlForIcon(iconCode)
        
        NetworkController.dataAtURL(url) { (success: Bool, resultData) -> Void in
            guard let resultData = resultData
                else {
                    print("NO DATA RETURNED")
                    completion(image: nil)
                    return
            }
            completion(image: UIImage(data: resultData))
        }
    }

}