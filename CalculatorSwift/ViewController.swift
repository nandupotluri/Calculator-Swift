//
//  ViewController.swift
//  CalculatorSwift
//
//  Created by user127456 on 5/16/17.
//  Copyright © 2017 user127456. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchdigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if(userIsInTheMiddleOfTyping){
            let textInDisplay = display.text!
            if (digit != "."){
                display.text = textInDisplay + digit
            } else {
                if (textInDisplay.contains(digit)){
                    display.text = textInDisplay
                }
                else {
                    display.text = textInDisplay + digit
                }
            }
        } else {
            if(digit != ".") {
                display.text = digit
            } else {
                display.text = display.text! + digit
            }
            userIsInTheMiddleOfTyping = true
        }
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    var brain: CalculatorBrain = CalculatorBrain()
    
    @IBOutlet weak var programDisplay: UILabel!
    @IBAction func operationPressed(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result{
            displayValue = result
        }
    }
}

