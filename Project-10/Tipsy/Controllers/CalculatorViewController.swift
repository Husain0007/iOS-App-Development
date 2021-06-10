//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet var billTextField: UITextField!
    @IBOutlet var zeroPctButton: UIButton!
    @IBOutlet var tenPctButton: UIButton!
    @IBOutlet var twentyPctButton: UIButton!
    @IBOutlet var splitNumberLabel: UILabel!
    
    var tipSelected = Float(0.0)
    var splitAmount = Float(0.0)
    var setting : String?

    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true) // to dismiss the onscreen keyboard after entering bill amount.
        
        if(sender.currentTitle == zeroPctButton.currentTitle)
        {
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
            tipSelected = 0.0
        }
        else if (sender.currentTitle == tenPctButton.currentTitle)
        {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = true
            twentyPctButton.isSelected = false
            tipSelected = 0.1
        }
        else if (sender.currentTitle == twentyPctButton.currentTitle)
        {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = true
            tipSelected = 0.2
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let billAmount = Float(billTextField.text!)
        let splitNumber = Float(splitNumberLabel.text!)
        setting = "Split between \(splitNumber ?? 2) people, with \(tipSelected*100)% tip."
        
        splitAmount = (billAmount! + tipSelected * billAmount!) / splitNumber!
        
        print(splitAmount)
        
        performSegue(withIdentifier: "goToResults", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "goToResults")
        {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalValue = String(format: "%.2f", splitAmount)
            destinationVC.settingsResult = setting ?? "Empty"
        }
    }
}

