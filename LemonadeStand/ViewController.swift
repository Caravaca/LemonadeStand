//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Antonio Caravaca Vega on 15/01/15.
//  Copyright (c) 2015 Antonio Caravaca Vega. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var lemonInventoryLabel: UILabel!
    @IBOutlet weak var iceCubeInventoryLabel: UILabel!
    @IBOutlet weak var lemonPurchaseLabel: UILabel!
    @IBOutlet weak var iceCubePurchaseLabel: UILabel!
    @IBOutlet weak var lemonMixLabel: UILabel!
    @IBOutlet weak var iceCubeMixLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTextLabel: UILabel!
    
    // Inventory
    
    var money:Int = 10
    var lemons:Int = 1
    var iceCubes:Int = 1
    
    // Purchase items
    
    var purchasedLemons:Int = 0
    var purchasedIceCubes:Int = 0
    
    // Mix your brew
    
    var mixedLemons:Int = 0
    var mixedIceCubes:Int = 0
    
    // Weather
    
    var weatherArray:[String] = ["Cold", "Mild", "Warm"]
    var weatherToday:String = ""
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        simulateWeather()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func purchaseLemonButtonPressed(sender: UIButton) {
        if money < 2 {
            showAlerts(message: "You don't have enough money")
        }else {
            purchasedLemons += 1
            lemons += 1
            money -= 2
            updateLabels()
        }
    }

    @IBAction func unPurchaseLemonButtonPressed(sender: UIButton) {
        if purchasedLemons > 0 {
            purchasedLemons -= 1
            lemons -= 1
            money += 2
            updateLabels()
        }else {
            showAlerts(message: "You don't have anything to return")
        }
    }
    
    @IBAction func purchaseIceCubeButtonPressed(sender: UIButton) {
        if money < 1 {
            showAlerts(message: "You don't have enough money")
        }else {
            purchasedIceCubes += 1
            iceCubes += 1
            money -= 1
            updateLabels()
        }
    }
    
    @IBAction func unPurchaseIceCubeButtonPressed(sender: UIButton) {
        if purchasedIceCubes > 0 {
            purchasedIceCubes -= 1
            iceCubes -= 1
            money += 1
            updateLabels()
        }else {
            showAlerts(message: "You don't have anything to return")
        }
    }
    
    @IBAction func mixLemonButtonPressed(sender: UIButton) {
        if lemons == 0 {
            showAlerts(message: "You don't have enough Lemons")
        }else {
            purchasedLemons = 0
            mixedLemons += 1
            lemons -= 1
            updateLabels()
        }
    }
    
    @IBAction func unMixLemonButtonPressed(sender: UIButton) {
        if mixedLemons > 0 {
            purchasedLemons = 0
            mixedLemons -= 1
            lemons += 1
            updateLabels()
        }else {
            showAlerts(message: "There's nothing to un-mix")
        }
    }
    
    @IBAction func mixIceCubeButtonPressed(sender: UIButton) {
        if iceCubes == 0 {
            showAlerts(message: "You don't have enough Ice Cubes")
        }else {
            purchasedIceCubes = 0
            mixedIceCubes += 1
            iceCubes -= 1
            updateLabels()
        }
    }
    
    @IBAction func unMixIceCubeButtonPressed(sender: UIButton) {
        if mixedIceCubes > 0 {
            purchasedIceCubes = 0
            mixedIceCubes -= 1
            iceCubes += 1
            updateLabels()
        }else{
            showAlerts(message: "There's nothing to un-mix")
        }
    }
    
    @IBAction func startDayButtonPressed(sender: UIButton) {
        
        var customers = Int(arc4random_uniform(UInt32(11)))
        
        if weatherToday == "Cold" {
            customers -= 2
            println(" its cold today ")
        }
        else if weatherToday == "Warm" {
            customers += 2
            println(" its warm today ")
        }
        else {
            println(" its a normal day ")
        }
        
        println("Customers today: \(customers + 1) ")
        
        if mixedLemons == 0 || mixedIceCubes == 0 {
            showAlerts(message: "You need to add at least 1 lemon and 1 ice cube")
        }
        else {
            let lemonadeRatio = Double(mixedLemons) / Double(mixedIceCubes)
            for x in 0...customers {
                
                let preference = Double(arc4random_uniform(UInt32(101))) / 100
                
                if preference < 0.4 && lemonadeRatio > 1 {
                    money += 1
                    print(" paid ")
                }else if preference > 0.6 && lemonadeRatio < 1 {
                    money += 1
                    print(" paid ")
                }else if preference >= 0.4 && preference <= 0.6 && lemonadeRatio == 1 {
                    money += 1
                    print(" paid ")
                }else {
                    print(" didn't buy ")
                }
            }
            purchasedLemons = 0
            purchasedIceCubes = 0
            mixedLemons = 0
            mixedIceCubes = 0
            updateLabels()
            simulateWeather()
        }
    }
    
    // Helper Functions
    
    func updateLabels() {
        self.moneyLabel.text = "$\(money)"
        if lemons > 1 {
            self.lemonInventoryLabel.text = "\(lemons) Lemons"
        }else {
            self.lemonInventoryLabel.text = "\(lemons) Lemon"
        }
        if iceCubes > 1 {
            self.iceCubeInventoryLabel.text = "\(iceCubes) Ice Cubes"
        }else {
            self.iceCubeInventoryLabel.text = "\(iceCubes) Ice Cube"
        }
        self.lemonPurchaseLabel.text = "\(purchasedLemons)"
        self.iceCubePurchaseLabel.text = "\(purchasedIceCubes)"
        self.lemonMixLabel.text = "\(mixedLemons)"
        self.iceCubeMixLabel.text = "\(mixedIceCubes)"
    }
    
    func showAlerts (header: String = "Warning", message: String) {
        
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func simulateWeather() {
        
        var index = Int(arc4random_uniform(UInt32(weatherArray.count)))
        
        weatherToday = weatherArray[index]
        
        switch weatherToday {
        case "Cold": self.weatherImage.image = UIImage(named: "Cold"); self.weatherTextLabel.text = "Cold"
        case "Mild": self.weatherImage.image = UIImage(named: "Mild"); self.weatherTextLabel.text = "Mild"
        case "Warm": self.weatherImage.image = UIImage(named: "Warm"); self.weatherTextLabel.text = "Warm"
        default: self.weatherImage.image = UIImage(named: "Warm"); self.weatherTextLabel.text = "Warm"
        }
        
        
    }
    
    
}

