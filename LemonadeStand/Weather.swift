//
//  Weather.swift
//  LemonadeStand
//
//  Created by Daniel Lopez on 12/14/14.
//  Copyright (c) 2014 Daniel Lopez. All rights reserved.
//

import Foundation
import UIKit

class Weather {
    var image = UIImage(named: "")
    var customerModifier = 0
    
    class func generateWeather() -> Weather{
        let type = Int(arc4random_uniform(UInt32(3)))
        var weather: Weather = Weather()
        
        switch type {
        case 0:
            weather.customerModifier = -3
            weather.image = UIImage(named: "Cold")
        case 1:
            weather.customerModifier = 0
            weather.image = UIImage(named: "Mild")
        default:
            weather.customerModifier = 4
            weather.image = UIImage(named: "Warm")
        }
        
        return weather
    }
}