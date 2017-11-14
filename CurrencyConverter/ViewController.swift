//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Robert Berry on 11/13/17.
//  Copyright © 2017 Robert Berry. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // Labels that display currency value.
    
    @IBOutlet weak var poundLabel: UILabel!
    @IBOutlet weak var yenLabel: UILabel!
    @IBOutlet weak var euroLabel: UILabel!
    
    // Text field for entering dollar amount that the user wishes to convert to another currency.
    
    @IBOutlet weak var inputTextField: UITextField!
    
    // Constants & Variables
    
    let poundRate = 0.69
    let yenRate = 113.94
    let euroRate = 0.89
    
    var dollarAmount = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Button that will convert currencies at exchange rates that have been programatically set.
    
    @IBAction func convertCurrency(_ sender: UIButton) {
        
        // var amount checks to see if the user entered some data that can be converted to Double. If yes, the amount entered is saved in the dollarAmount variable. Which updates the three labels with the converted amount.
        
        if let amount = Double(inputTextField.text!) {
            
            dollarAmount = amount
        }
        
        poundLabel.text = "\(dollarAmount * poundRate)"
        yenLabel.text = "\(dollarAmount * yenRate)"
        euroLabel.text = "\(dollarAmount * euroRate)"
        dollarAmount = 0.0
    }
    
    // Button that will clear text field and currency amounts when tapped.
    
    @IBAction func clearTextField(_ sender: UIButton) {
        
        // When the button is tapped the inputTextField will return an empty String and the currency labels will return the String "0.00".
        
        inputTextField.text = ""
        poundLabel.text = "0.00"
        yenLabel.text = "0.00"
        euroLabel.text = "0.00"
    }
    
    // Called when 'return' key is pressed.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    // Called when user taps outside the text field
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
}

