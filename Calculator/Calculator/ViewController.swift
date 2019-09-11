//
//  ViewController.swift
//  Calculator
//
//  Created by wendy on 2019/9/11.
//  Copyright © 2019 Chunli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var resultLabel: UILabel!
    var firstResult: Double = 0
    var secondInput: Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    var currentNum:Double = 0
    var currentOperator:String = ""
    @IBAction func DigitsPressed(_ sender: UIButton) {
        resultLabel.text! += sender.titleLabel!.text!
    }
    
    @IBAction func ClearScreenPressed(_ sender: UIButton) {
        resultLabel.text = "0"
    }
    
    @IBAction func OperatorPressed(_ sender: UIButton) {
        currentNum = Double(resultLabel.text!)!
        currentOperator = sender.titleLabel!.text!
        if currentOperator == "+/-"{
            currentNum *= -1
            resultLabel.text = "\(currentNum)"
        }else if currentOperator == "%"{
            currentNum /= 100
            resultLabel.text = "\(currentNum)"
        }else{
            
        }
    }
    
    @IBAction func CalculatePressed(_ sender: UIButton) {
        if currentOperator == "+"{
            
        }
    }
    
}

