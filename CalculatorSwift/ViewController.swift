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
            display.text = textInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
}

