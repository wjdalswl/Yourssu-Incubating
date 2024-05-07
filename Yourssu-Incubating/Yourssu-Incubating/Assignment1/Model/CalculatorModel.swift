//
//  CalculatorModel.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 4/24/24.
//

struct Calculation {
    var firstNumber: Int
    var secondNumber: Int
    var operation: Operation
    
    enum Operation {
        case add, sub, mul, div
    }
    
    func perform() -> String {
        switch operation {
        case .add:
            return "\(firstNumber) + \(secondNumber) = \(firstNumber + secondNumber)"
        case .sub:
            return "\(firstNumber) - \(secondNumber) = \(firstNumber - secondNumber)"
        case .mul:
            return "\(firstNumber) X \(secondNumber) = \(firstNumber * secondNumber)"
        case .div:
            if secondNumber == 0 {
                return "0으로 나눌 수 없습니다."
            } else {
                let quotient = firstNumber / secondNumber
                let remainder = firstNumber % secondNumber
                return "\(firstNumber) / \(secondNumber) = \(quotient).\(remainder)"
            }
        }
    }
}
