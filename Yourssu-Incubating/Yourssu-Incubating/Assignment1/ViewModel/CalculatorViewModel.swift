//
//  CalculatorViewModel.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 4/24/24.
//

import RxSwift
import RxCocoa

class CalculatorViewModel {
    private let disposeBag = DisposeBag()
    
    // MARK: - Inputs
    struct Input {
        let firstNumber: Observable<String>
        let secondNumber: Observable<String>
        let operation: Observable<Calculation.Operation>
        let calculateTrigger: Observable<Void>
    }
    
    // MARK: - Outputs
    struct Output {
        let result: Observable<String>
        let bool: Observable<Bool>
    }
    
    // MARK: - Transform
    func transform(input: Input) -> Output {
        let result = input.calculateTrigger
            .withLatestFrom(
                Observable.combineLatest(
                    input.firstNumber,
                    input.secondNumber,
                    input.operation)
            ) { _, values in
                (values.0, values.1, values.2)
            }
            .map { first, second, op -> (String, Bool) in
                if first.isEmpty && second.isEmpty {
                    return ("값을 먼저 입력해주세요.", false)
                } else if first.isEmpty || second.isEmpty {
                    return ("숫자를 모두 입력해주세요.", false)
                }
                
                guard let firstNum = Int(first),
                      let secondNum = Int(second) else {
                    return ("정수 숫자를 입력해주세요", false)
                }
                
                
                let calculationResult = self.performCalculation(first: firstNum, second: secondNum, operation: op)
                return (calculationResult, true)
            }
            .catchAndReturn(("연산 오류", false))
        
        return  Output(result: result.map { $0.0 }, bool: result.map { $0.1 })
    }
    
    private func performCalculation(first: Int, second: Int, operation: Calculation.Operation) -> String {
        let calculation = Calculation(firstNumber: first, secondNumber: second, operation: operation)
        return calculation.perform()
    }
}


