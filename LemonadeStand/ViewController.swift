//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Daniel Lopez on 12/14/14.
//  Copyright (c) 2014 Daniel Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var lemonLabel: UILabel!
    @IBOutlet weak var iceCubeLabel: UILabel!
    @IBOutlet weak var suppliesLemonCountLabel: UILabel!
    @IBOutlet weak var suppliesIceCubeCountLabel: UILabel!
    @IBOutlet weak var mixLemonCountLabel: UILabel!
    @IBOutlet weak var mixIceCubeCountLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    var money = 10
    var lemons = 1
    var iceCubes = 1
    
    var supplyLemons = 0
    var supplyIceCubes = 0
    var mixLemons = 0
    var mixIceCubes = 0
    
    var lemonadeType = ""
    var numCustomers = 0
    var preferences: [String] = []
    var revenue = 0
    var currentWeather: Weather = Weather.generateWeather()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        weatherImage.image = currentWeather.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    supplies buttons
    @IBAction func suppliesAddLemonButtonPressed(sender: UIButton) {
        if money >= 2 {
            money -= 2
            ++supplyLemons
            ++lemons
            updateLabels()
        }
        else{
            showAlert(header: "Not Enough Money!", message: "You don't have enough money")
        }
    }
    @IBAction func suppliesSubtractLemonButtonPressed(sender: UIButton) {
        if supplyLemons == 0 {
            showAlert(header: "Alert!", message: "You are already at 0!")
        }
        else {
            --supplyLemons
            --lemons
            money += 2
            updateLabels()
        }
    }
    @IBAction func suppliesAddIceCubeButtonPressed(sender: UIButton) {
        if money >= 1 {
            money -= 1
            ++supplyIceCubes
            ++iceCubes
            updateLabels()
        }
        else{
            showAlert(header: "Not Enough Money!", message: "You don't have enough money")
        }
    }
    @IBAction func suppliesSubtractIceCubeButtonPressed(sender: UIButton) {
        if supplyIceCubes == 0 {
            showAlert(header: "Alert!", message: "You are already at 0!")
        }
        else {
            --supplyIceCubes
            --iceCubes
            money += 1
            updateLabels()
        }
    }
    
//    mix buttons
    @IBAction func mixAddLemonsButtonPressed(sender: UIButton) {
        if lemons >= 1 {
            --lemons
            ++mixLemons
            updateLabels()
        }
        else{
            showAlert(header: "Not enough lemons!", message: "Buy more lemons!")
        }
    }
    @IBAction func mixSubtractLemonsButtonPressed(sender: UIButton) {
        if mixLemons == 0 {
            showAlert(header: "No lemons!", message: "You already have 0!")
        }
        else {
            --mixLemons
            ++lemons
            updateLabels()
        }
    }
    @IBAction func mixAddIceCubesButtonPressed(sender: UIButton) {
        if iceCubes >= 1 {
            --iceCubes
            ++mixIceCubes
            updateLabels()
        }
        else {
            showAlert(header: "Not enough cubes!", message: "Buy more ice cubes!")
        }
    }
    @IBAction func mixSubtractIceCubeButtonPressed(sender: UIButton) {
        if mixIceCubes == 0 {
            showAlert(header: "No cubes!", message: "You already have 0!")
        }
        else {
            --mixIceCubes
            ++iceCubes
            updateLabels()
        }
    }
    
//    start day button
    @IBAction func startDayButtonPressed(sender: UIButton) {
        lemonadeType = calculateLemonadeType()
        numCustomers = CustomerGenerator.createCustomers() + currentWeather.customerModifier
        revenue = CustomerGenerator.calcRevenue(numCustomers, lemonadeType: lemonadeType)
        showAlert(header: "Today's Revenue:", message: "You made \(revenue) dollars!")
        currentWeather = Weather.generateWeather()
        weatherImage.image = currentWeather.image
        money += revenue
        supplyIceCubes = 0
        supplyLemons = 0
        mixIceCubes = 0
        mixLemons = 0
        updateLabels()
        
    }
    
    func showAlert (header: String = "Warning!", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    func updateLabels () {
        moneyLabel.text = "$\(money)"
        lemonLabel.text = "\(lemons) Lemons"
        iceCubeLabel.text = "\(iceCubes) Ice Cubes"
        suppliesLemonCountLabel.text = "\(supplyLemons)"
        suppliesIceCubeCountLabel.text = "\(supplyIceCubes)"
        mixLemonCountLabel.text = "\(mixLemons)"
        mixIceCubeCountLabel.text = "\(mixIceCubes)"
    }
    func calculateLemonadeType () -> String{
        var lemonadeRatio = Double(mixLemons) / Double(mixIceCubes)
        if lemonadeRatio > 1.0 {
            return "Acidic"
        }
        else if lemonadeRatio == 1.0 {
            return "Equal Portioned"
        }
        else {
            return "Diluted"
        }
    }

}

