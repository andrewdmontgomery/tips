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
        // Let's grab our defaults
        var defaults = NSUserDefaults.standardUserDefaults()
        if let currentBillAmount = defaults.objectForKey("currentBillAmount") as? String {
            billField.text = currentBillAmount
        } else {
            billField.text = ""
        }
        
        if billField.text.isEmpty == true {
            tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTip")
        } else {
            tipControl.selectedSegmentIndex = defaults.integerForKey("currentTipIndex")
        }
        
        updateUI()
        let tipTotalCenter = tipTotalView.center
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
                // Using brute force, assuming iPhone 5
                self.tipTotalView.center = CGPoint(x: 160.0, y: 356.0)
                self.tipControl.center = CGPoint(x: 160.0, y: 266.5)
                self.billField.center = CGPoint(x: 160.0, y: 124.0)
                self.dollarSignLabel.center = CGPoint(x: 287.0, y: 124.0)
            })
        } else {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.dollarSignLabel.alpha = 0
                self.tipControl.alpha = 1
                // Using brute force, assuming iPhone 5
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
    
    func updateDefaults() {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: "currentBillAmount")
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "currentTipIndex")
        defaults.synchronize()
        
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        updateDefaults()
        updateUI()
    }

    @IBAction func goToSettings(sender: AnyObject) {
        performSegueWithIdentifier("SettingsSegue", sender: self)
    }

    
    // Dismisses the keyboard when combine with a tap gesture on the ViewController
    /*
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    */
    
}

