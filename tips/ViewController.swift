//
//  ViewController.swift
//  tips
//
//  Created by Andrew Montgomery on 8/23/15.
//  Copyright (c) 2015 Andrew Montgomery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var dollarSignLabel: UILabel!
    @IBOutlet weak var tipTotalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        billField.becomeFirstResponder()
    }

    override func viewWillAppear(animated: Bool) {
        var defaults = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTip")
        updateUI()
        let tipTotalCenter = tipTotalView.center
        println("\(tipTotalCenter)")
        println("\(tipControl.center)")
        println("\(billField.center)")
        println("\(dollarSignLabel.center)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateUI() {
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        if billAmount == 0.0 {
            billField.text = ""
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.dollarSignLabel.alpha = 0.5
                self.tipControl.alpha = 0
                self.tipTotalView.center = CGPoint(x: 160.0, y: 356.0)
                self.tipControl.center = CGPoint(x: 160.0, y: 266.5)
                self.billField.center = CGPoint(x: 160.0, y: 124.0)
                self.dollarSignLabel.center = CGPoint(x: 287.0, y: 124.0)
            })
        } else {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.dollarSignLabel.alpha = 0
                self.tipControl.alpha = 1
                self.tipTotalView.center = CGPoint(x: 160.0, y: 220.0)
                self.tipControl.center = CGPoint(x: 160.0, y: 130.5)
                self.billField.center = CGPoint(x: 160.0, y: 56.0)
                self.dollarSignLabel.center = CGPoint(x: 287.0, y: 56.0)
            })
        }
        
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        updateUI()
    }

    @IBAction func goToSettings(sender: AnyObject) {
        performSegueWithIdentifier("SettingsSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifer = segue.identifier {
            switch identifer {
                case "SettingsSegue":
                    if let vc = segue.destinationViewController as? SettingsViewController {
                        // do stuff here to prepare
                        // outlets are not set yet
                    }
                default: break
            }
        }
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

