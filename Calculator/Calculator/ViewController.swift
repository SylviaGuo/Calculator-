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
    var beforeOperator:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func DigitsPressed(_ sender: UIButton) {
        if !beforeOperator{
            UpdateScreen(currentResult: "")
            beforeOperator = false
        }
        if resultLabel.text == "0" && sender.titleLabel?.text != "."{
            resultLabel.text = ""
        }
            resultLabel.text! += sender.titleLabel!.text!
    
    }
    
    @IBAction func ClearScreenPressed(_ sender: UIButton) {
        
        UpdateScreen(currentResult: "0")
        operatorCount = 0
        firstNum = 0
        secondNum = 0
        beforeOperator = true
    }
    
    @IBAction func SingleOperatorPressed(_ sender: UIButton) {
        currentOperator = sender.titleLabel!.text!
        if currentOperator == "+/-"{
            let temp = resultLabel.text
            
            
        }else{
            if beforeOperator{
                firstNum /= 100
                UpdateScreen(currentResult: "\(firstNum)")
            }else{
                secondNum /= 100
                UpdateScreen(currentResult: "\(secondNum)")
            }
            
        }
    }
    @IBAction func OperatorPressed(_ sender: UIButton) {
        operatorCount += 1
        if operatorCount == 1{
            currentOperator = sender.titleLabel!.text!
            firstNum = Double(resultLabel.text!)!
        }else{
            secondNum = Double(resultLabel.text!)!
            firstNum = Calculator(firstInput: firstNum, secondInput: secondNum, expression: currentOperator)
            UpdateScreen(currentResult: "\(firstNum)")
            currentOperator = sender.titleLabel!.text!
        }
        beforeOperator = false
    }
    
    @IBAction func CalculatePressed(_ sender: UIButton) {
        secondNum = Double(resultLabel.text!)!
        let result = Calculator(firstInput: firstNum, secondInput: secondNum, expression: currentOperator)
        UpdateScreen(currentResult: "\(result)")
    }
    func Calculator(firstInput:Double, secondInput:Double,expression:String) -> Double{
        if expression == "+"{
            return firstInput + secondInput
        }else if expression == "-"{
            return firstInput - secondInput
        }else if expression == "x"{
            return firstInput * secondInput
        }else{
            guard let value = try? firstInput / secondInput else{
                return 0
            }
            return value
        }
    }
    //update the result on screen
    func UpdateScreen(currentResult:String){
        resultLabel.text = currentResult
    }
    
}

