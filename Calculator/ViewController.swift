//
//  ViewController.swift
//  Calculator
//
//  Created by Chris Ding on 2015-01-29.
//  Copyright (c) 2015 cding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // @IBOutlet is created by XCode
    // ULabel!
    @IBOutlet weak var display: UILabel!

    var userIsInTheMiddleOfTypingNumber = false

    var brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!

        if userIsInTheMiddleOfTypingNumber {
            display.text = display.text! + digit
        }
        else
        {
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        }
    }

    @IBAction func operate(sender: UIButton) {

        if userIsInTheMiddleOfTypingNumber {
            enter()
        }

        if let operation = sender.currentTitle
        {
            if let result = brain.performOperation(operation)
            {
                displayValue = result
            } else {
                displayValue = 0
            }
        }

    }

    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false

        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }

    @IBAction func clearOp()
    {
        brain.clearStack()

        userIsInTheMiddleOfTypingNumber = false
        displayValue = 0
    }

    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false
        }
    }
}
