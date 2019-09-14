//
//  ViewController.swift
//  Calculator
//
//  Created by Chunli on 2019/9/11.
//  Copyright © 2019 Chunli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var firstNum:Double = 0
    var secondNum:Double = 0
    var operatorCount:Int = 0
    var currentOperator:String = ""
    var singleOperator:String = ""
    var hasNewInput:Bool = true
    var hasCalculated:Bool = false
    var dotInput:Bool = false
    var hasPercentage:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //press 0 1 2 3 4 5 6 7 8 9 .
    @IBAction func DigitsPressed(_ sender: UIButton) {
        if sender.titleLabel?.text != "."{
            if !hasNewInput || hasPercentage{
                UpdateScreen(currentResult: "")
                hasNewInput = true
                hasPercentage = false
            }
            if resultLabel.text == "0"{
                resultLabel.text = ""
            }
            resultLabel.text! += sender.titleLabel!.text!
            hasCalculated = false
        }else{
            if !hasNewInput || hasPercentage{
                UpdateScreen(currentResult: "0")
                hasNewInput = true
                hasPercentage = false
            }
            if !(resultLabel.text?.contains("."))!{
                resultLabel.text! += "."
            }
            hasCalculated = false
        }
        
    
    }
    //press C
    @IBAction func ClearScreenPressed(_ sender: UIButton) {
        
        UpdateScreen(currentResult: "0")
        firstNum = 0
        secondNum = 0
        operatorCount = 0
        currentOperator = ""
        singleOperator = ""
        hasNewInput = true
        hasCalculated = false
        dotInput = false
    }
    //press +/-  %
    @IBAction func SingleOperatorPressed(_ sender: UIButton) {
        singleOperator = sender.titleLabel!.text!
        let tempResult = Double(resultLabel.text!)!
        if singleOperator == "+/-"{
            resultLabel.text = "\(-tempResult)"
        }else{
            resultLabel.text = "\(tempResult/100)"
            hasNewInput = true
            hasPercentage = true
        }
    }
    //pressed + - x /
    @IBAction func OperatorPressed(_ sender: UIButton) {
        if hasNewInput{
            operatorCount += 1
            //first input
            if operatorCount == 1 && !hasCalculated{
                currentOperator = sender.titleLabel!.text!
                firstNum = Double(resultLabel.text!)!
            }else{
                secondNum = Double(resultLabel.text!)!
                firstNum = Calculator(firstInput: firstNum, secondInput: secondNum, expression: currentOperator)
                print("Digits time: firstNum \(firstNum) \(currentOperator) \(secondNum)")
                UpdateScreen(currentResult: "\(firstNum)")
                currentOperator = sender.titleLabel!.text!
            }
            hasNewInput = false
            dotInput = false
            
        }else{
            currentOperator = sender.titleLabel!.text!
            print("Digits operator: \(currentOperator)")
        }
    }
    //Pressed =
    @IBAction func CalculatePressed(_ sender: UIButton) {
        if hasNewInput{
            secondNum = Double(resultLabel.text!)!
            print("Before = : firstNum \(firstNum) \(currentOperator) \(secondNum)")
            firstNum = Calculator(firstInput: firstNum, secondInput: secondNum, expression: currentOperator)
            UpdateScreen(currentResult: "\(firstNum)")
            hasNewInput = false
            hasCalculated = true
            dotInput = false
        }
        operatorCount = 0
        
    }
    //calculate result
    func Calculator(firstInput:Double, secondInput:Double,expression:String) -> Double{
        //reset second number
        secondNum = 0
        switch expression{
        case "+":
            return firstInput + secondInput
        case "-":
            return firstInput - secondInput
        case "x":
            return firstInput * secondInput
        case "÷":
            if secondInput == 0
            {
                return 0
            }else{
                return firstInput / secondInput
            }
        default:
            return 0
        }
    }
    //update the result on screen
    func UpdateScreen(currentResult:String){
        resultLabel.text = currentResult
    }
    
}

