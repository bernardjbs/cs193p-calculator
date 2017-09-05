//
//  ViewController.swift
//  Calculator
//
//  Created by Bernard Sin Fat on 5/9/17.
//  Copyright © 2017 Bernard Sin Fat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // INSTANCE VARIABLE
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }

    // COMPUTED PROPERTY
    // SIDE NOTE: TO MALKE READ ONLY VAR, USE COMPUTED PROPERTY (BY THE GET METHOD)
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            switch mathematicalSymbol {
            case "π" :
                displayValue = Double.pi
            case "√" :
                displayValue = sqrt(displayValue)
            default:
                break
            }
        }
        
    }


}

