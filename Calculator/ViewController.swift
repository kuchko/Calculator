//
//  ViewController.swift
//  Calculator
//
//  Created by Oleksii KUCHKO on 6/24/19.
//  Copyright © 2019 Oleksii KUCHKO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResLabel: UILabel!
    var stillType = false
    var firstOp: Double = 0
    var secondOp: Double = 0
    var opSign: String = ""



    var currentInput: Double {
        get {
            return Double(displayResLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valArray = value.components(separatedBy: ".")

            if (valArray.count > 1 && valArray[1] == "0") {
                displayResLabel.text = "\(valArray[0])"
            }
            else
            {
                displayResLabel.text = "\(newValue)"
            }
            stillType = false
        }
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        let num = sender.currentTitle!
        print(num)
        if (stillType && displayResLabel.text != "0")
            {
            if (displayResLabel.text?.count)! < 18 {
                    displayResLabel.text = displayResLabel.text! + num
            }
        } else {
            displayResLabel.text = num
            stillType = true
        }
    }

    @IBAction func TwoOpSignedPessed(_ sender: UIButton) {
        opSign = sender.currentTitle!
        firstOp = currentInput
        stillType = false
        print(opSign)
    }

    func operationTwoOp(operation : (Double, Double) -> Double) {
        currentInput = operation(firstOp, secondOp)
        //secondOp = 0 // tut?
        stillType = false
    }

    @IBAction func equalPressed(_ sender: UIButton) {
        if stillType
        {
            secondOp = currentInput
        }

        switch opSign {
            case "+":
                operationTwoOp{$0 + $1}
            case "-":
                operationTwoOp{$0 - $1}
            case "*":
                operationTwoOp{$0 * $1}
            case "/":
                operationTwoOp{$0 / $1}
            default:
                break
        }
        print(firstOp,opSign,secondOp,"=",currentInput)
    }

    @IBAction func AcButtonPressed(_ sender: UIButton) {
        firstOp = 0
        secondOp = 0
        currentInput = 0
        stillType = false
        opSign = ""
        displayResLabel.text = "0"
        print("AC")
    }

    @IBAction func negButton(_ sender: UIButton) {
        currentInput = -currentInput
        stillType = true
        print(currentInput)
    }

}
