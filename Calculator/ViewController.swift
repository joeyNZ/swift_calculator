//
//  ViewController.swift
//  Calculator
//
//  Created by Joseph Casey on 25/09/16.
//  Copyright © 2016 Joseph Casey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var brain = CalculatorBrain()
    
    var userIsTyping = false
    var userAlreadyPressedPoint = false
    
    var displayValue: Double {
        get {
            if let value = display.text {
                return Double(value)!
            } else {
                return 0.0;
            }
        }
        set {
            display.text = String(newValue)
        }
    }

    @IBOutlet weak var display: UILabel!
    
    @IBAction func touchDigit(_ sender: UIButton) {
        if !userIsTyping {
            if let digit = sender.currentTitle {
                display.text = digit
                userIsTyping = true
                if digit == "." {
                    userAlreadyPressedPoint = true
                }
            }
        } else {
            if let digit = sender.currentTitle {
                if digit == "." {
                    if !userAlreadyPressedPoint {
                        display.text = display.text! + digit
                        userAlreadyPressedPoint = true
                    }
                } else {
                    display.text = display.text! + digit
                }
            }
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if let operation = sender.currentTitle {
            userIsTyping = false
            userAlreadyPressedPoint = false
            brain.setOperand(operand: displayValue)
            brain.performOperation(symbol: operation)
            displayValue = brain.result
        }
    }
    
    @IBAction func clearAll(_ sender: UIButton) {
        brain = CalculatorBrain()
        userIsTyping = false
        userAlreadyPressedPoint = false
        displayValue = 0.0
    }
    

}

