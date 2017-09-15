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
    @IBOutlet weak var descrition: UILabel!
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var dotButton: UIButton!
    
    var userIsInTheMiddleOfTyping = false
    
    override func viewDidLoad() {
        
    }
        
    @IBAction func Del(_ sender: UIButton) {
        if (display.text?.characters.count)! <= 1 {
            display.text = "0"
            userIsInTheMiddleOfTyping = false
            return
        }
        display.text = String(display.text!.characters.dropLast())
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            if (display.text?.characters.count)! < 20 {
                let textCurrentlyInDisplay = display.text!
                display.text = textCurrentlyInDisplay + digit
            }
        }
        else {
            if digit == "." {
                display.text = "0."
            }
            else if digit == "0" {
                return
            } else {
                display.text = digit
            }
            userIsInTheMiddleOfTyping = true
        }
        dotButton.isEnabled = brain.decimalButtonStatus(display.text!)
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
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
            dotButton.isEnabled = brain.decimalButtonStatus(mathematicalSymbol)
        }
        if let result = brain.result {
            if result == 0 {
                display.text = "0"
            } else {
                displayValue = result
            }
        }
    }
}

