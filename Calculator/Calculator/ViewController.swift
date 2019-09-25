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
    var hasNewInput:Bool = false
    var hasCalculated:Bool = false
    
    enum CalculateError: Error{
        case DivideByZeroError
        case TransferError
    }
    func ThrowError(type: Int) throws ->Double{
        if type == 0 {
            throw CalculateError.DivideByZeroError
        }else if type == 1 {
            throw CalculateError.TransferError
        }
        return 0
    }
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
            if !hasNewInput{
                UpdateScreen(currentResult: "")
                hasNewInput = true
                if currentOperator == ""{
                    operatorCount = 0
                    print("No Operator")
                }
            }
            if resultLabel.text == "0"{
                resultLabel.text = ""
            }
            resultLabel.text! += sender.titleLabel!.text!
            hasCalculated = false
        }else{
            if !hasNewInput {
                UpdateScreen(currentResult: "0")
                hasNewInput = true
                if currentOperator == ""{
                    operatorCount = 0
                    print("No Operator")
                }
            }
            //make sure only one . allow
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
        hasNewInput = false
        hasCalculated = false
    }
    //press +/-  %
    @IBAction func SingleOperatorPressed(_ sender: UIButton) {
        if resultLabel!.text != "-"{
            singleOperator = sender.titleLabel!.text!
            let temp = Double(resultLabel.text!)!
            print(temp)
            if singleOperator == "+/-"{
                if !hasNewInput {
                    //press afeter calculated
                    if hasCalculated{
                        UpdateScreen(currentResult:"\(-temp)")
                    }else{//press before input a number
                        resultLabel.text = "-"
                        hasNewInput = true
                    }
                }else{//press after input a number
                    UpdateScreen(currentResult:"\(-temp)")
                }
            }else if singleOperator == "%"{
                let tempRestult = temp/100
                UpdateScreen(currentResult:"\(tempRestult)")
                if hasCalculated{
                    firstNum = tempRestult
                    print("firstNum:\(firstNum),hasCalculated\(hasCalculated)")
                }
            }else{
                print("unknow singleOperator:\(singleOperator)")
            }
        }
        
    }
    //pressed + - x /
    @IBAction func OperatorPressed(_ sender: UIButton) {
        if hasNewInput && resultLabel.text != "-"{
            operatorCount += 1
            //first input
            if operatorCount == 1 && !hasCalculated{
                print("operatorCount:\(operatorCount),!hasCaulculated:\(!hasCalculated)")
                currentOperator = sender.titleLabel!.text!
                firstNum = Double(resultLabel.text!)!
            }else{//second or more inputs
                secondNum = Double(resultLabel.text!)!
                print("OperatorPressed: firstNum \(firstNum) \(currentOperator) \(secondNum)")
                firstNum = Calculator(firstInput: firstNum, secondInput: secondNum, expression: currentOperator)
                UpdateScreen(currentResult: "\(firstNum)")
                currentOperator = sender.titleLabel!.text!
                print("CurrentOperator:\(currentOperator)")
            }
            hasNewInput = false
            
        }else{
            currentOperator = sender.titleLabel!.text!
            print("CurrentOperator: \(currentOperator)")
        }
    }
    //Pressed =
    @IBAction func CalculatePressed(_ sender: UIButton) {
        if hasNewInput && resultLabel.text != "-" && currentOperator != ""{
            secondNum = Double(resultLabel.text!)!
            print("CalculatePressed = : firstNum \(firstNum) \(currentOperator) \(secondNum)")
            firstNum = Calculator(firstInput: firstNum, secondInput: secondNum, expression: currentOperator)
            UpdateScreen(currentResult: "\(firstNum)")
            hasNewInput = false
            hasCalculated = true
            currentOperator = ""
        }
        
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
//            do {
//                var result = try firstInput / secondInput
//            } catch {
//                print(error)
//                return 0
//            }
            guard secondInput != 0 else{
                return 0
            }
                return firstInput / secondInput
        default:
            return 0
        }
    }
    //update the result on screen
    func UpdateScreen(currentResult:String){
        let newResult = deleteInvalidNum(num: currentResult)
        resultLabel.text = newResult
//        if currentResult.contains(".")
//        {
//            var strings = currentResult.components(separatedBy: ".")
//            let iszeros: Int = Int (strings[1])!
//            if iszeros == 0{
//                resultLabel.text = strings[0]
//            }else{
//                resultLabel.text = currentResult
//            }
//
//        }else{
//            resultLabel.text = currentResult
//        }
    }
    
    //delete invalid 0
    func deleteInvalidNum(num:String) ->String{
        var outNumber = num
        var i = 1
        if num.contains("."){
            while i < num.count{
                if outNumber.hasSuffix("0"){
                outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
                    i = i + 1
                }else{
                    break
                }
            }
            if outNumber.hasSuffix("."){
                outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
            }
                return outNumber
        }else{
            return num
        }
    }
    
}



