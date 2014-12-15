//
//  CustomerGenerator.swift
//  LemonadeStand
//
//  Created by Daniel Lopez on 12/14/14.
//  Copyright (c) 2014 Daniel Lopez. All rights reserved.
//

import Foundation

class CustomerGenerator {
    class func createCustomers () ->Int {
        return Int(arc4random_uniform(UInt32(10))) + 1
    }
    
    class func assignPreferences (numCustomers: Int) -> [String] {
        
        var preferences: [String] = []
        
        for var customer = 0; customer < numCustomers; ++customer {
            var prefValue = Double(arc4random_uniform(UInt32(11)))/10.0
            
            if prefValue <= 0.4 {
                preferences.append("Acidic")
            }
            else if prefValue <= 0.6 {
                preferences.append("Equal Portioned")
            }
            else {
                preferences.append("Diluted")
            }
        }
        
        return preferences
    }
    
    class func calcRevenue ( numCustomers: Int, lemonadeType: String) -> Int{
        var preferences: [String] = assignPreferences(numCustomers)
        var revenue = 0
        
        for pref in preferences {
            if pref == lemonadeType {
                ++revenue
                println("Get paid a dollar!")
            }
        }
        return revenue
    }
}