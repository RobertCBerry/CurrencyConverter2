//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Robert Berry on 11/13/17.
//  Copyright © 2017 Robert Berry. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON 

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    // Labels that display currency value.
    
    @IBOutlet weak var poundLabel: UILabel!
    @IBOutlet weak var yenLabel: UILabel!
    @IBOutlet weak var euroLabel: UILabel!
    
    // Text field for entering dollar amount that the user wishes to convert to another currency.
    
    @IBOutlet weak var inputTextField: UITextField!
    
    var dollarAmount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Button that will convert currencies at exchange rate that is updated by Open Exchange Rates.
    
    @IBAction func convertCurrency(_ sender: UIButton) {
        
        // var amount checks to see if the user entered some data that can be converted to Double. If yes, the amount entered is saved in the dollarAmount variable. Which updates the three labels with the converted amount.
        
        if let amount = Double(inputTextField.text!) {
            
            dollarAmount = amount
        }
        
        guard let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=ba4ddd56148446029b751c93feb50524") else { return }
        
        Alamofire.request(url)
            .validate()
            .responseJSON { response in
                
                if response.result.isSuccess {
                    
                    if let currencyJSON = response.result.value {
                        
                        let parsedData = JSON(currencyJSON)
                        
                        if let yen = parsedData["rates", "JPY"].double {
                            
                            let yenConversion = self.dollarAmount * yen
                            
                            // ".2f" means that only two numbers will be displayed after the decimal point.
                            
                            self.yenLabel.text = String(format: "¥%.2f", yenConversion)
                            
                        }
                        
                        if let pound = parsedData["rates", "GBP"].double {
                            
                            let poundConversion = self.dollarAmount * pound
                            
                            // ".2f" means that only two numbers will be displayed after the decimal point.
                            
                            self.poundLabel.text = String(format: "£%.2f", poundConversion)
                            
                        }
                        
                        if  let euro = parsedData["rates", "EUR"].double {
                            
                            let euroConversion = self.dollarAmount * euro
                            
                            // ".2f" means that only two numbers will be displayed after the decimal point.
                            
                            self.euroLabel.text = String(format: "€%.2f", euroConversion)
                            
                        }
                        
                    }
                    
                } else {
                    
                    print(response.result.error.debugDescription)
                }
        }
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

