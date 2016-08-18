//
//  ViewController.swift
//  calculator
//
//  Created by ivote on 2016/8/5.
//  Copyright © 2016年 ivote. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func AppendDigit(sender: UIButton){
    
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }else {
            display.text  = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperationSqrt { sqrt($0) }
        default:break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayvalue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }

    func performOperationSqrt(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayvalue = operation(operandStack.removeLast())
            enter()
        }
    }
    

    
    
    var operandStack  = Array<Double>()

    @IBAction func enter() {
        self.userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayvalue)
        print("oprandStack = \(operandStack)")
        
    }
    
    var displayvalue : Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            self.userIsInTheMiddleOfTypingANumber = false
        }
    }
}
