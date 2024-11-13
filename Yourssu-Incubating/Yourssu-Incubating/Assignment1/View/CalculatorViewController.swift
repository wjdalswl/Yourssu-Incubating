//
//  CalculatorViewController.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 4/24/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class CalculatorViewController: UIViewController {
    //MARK: - Properties
    private var viewModel: CalculatorViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var firstNumTextField = CalculatorTextField(title: "첫번째 숫자를 입력해주세요")
    private lazy var secondNumTextField = CalculatorTextField(title: "두번째 숫자를 입력해주세요")
    private let explanationLabel = UILabel().then {
        $0.text = "버튼을 눌러주세요!"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        $0.textAlignment = .center
    }
    private lazy var addButton = CalculatorButton(title: "더하기")
    private lazy var subButton = CalculatorButton(title: "빼기")
    private lazy var mulButton = CalculatorButton(title: "곱하기")
    private lazy var divButton = CalculatorButton(title: "나누기")
    
    init(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setLayout()
        bindViewModel()
    }
    
    //MARK: - SetLayout
    private func setLayout() {
        [firstNumTextField,
         secondNumTextField,
         explanationLabel,
         addButton,
         subButton,
         mulButton,
         divButton].forEach {
            self.view.addSubview($0)
        }
        
        firstNumTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(157)
            $0.leading.trailing.equalToSuperview().inset(47)
            $0.height.equalTo(35)
        }
        secondNumTextField.snp.makeConstraints {
            $0.top.equalTo(firstNumTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(47)
            $0.height.equalTo(35)
        }
        explanationLabel.snp.makeConstraints {
            $0.top.equalTo(secondNumTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(47)
        }
        addButton.snp.makeConstraints {
            $0.top.equalTo(explanationLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(47)
            $0.height.equalTo(39)
        }
        subButton.snp.makeConstraints {
            $0.top.equalTo(addButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(47)
            $0.height.equalTo(39)
        }
        mulButton.snp.makeConstraints {
            $0.top.equalTo(subButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(47)
            $0.height.equalTo(39)
        }
        divButton.snp.makeConstraints {
            $0.top.equalTo(mulButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(47)
            $0.height.equalTo(39)
        }
    }
    // MARK: - BindViewModel
    private func bindViewModel() {
        let operationObservable = Observable.merge(
            addButton.rx.tap.map { Calculation.Operation.add },
            subButton.rx.tap.map { Calculation.Operation.sub },
            mulButton.rx.tap.map { Calculation.Operation.mul },
            divButton.rx.tap.map { Calculation.Operation.div }
        ).asObservable()
        let calculateTrigger = Observable.merge(
            addButton.rx.tap.asObservable(),
            subButton.rx.tap.asObservable(),
            mulButton.rx.tap.asObservable(),
            divButton.rx.tap.asObservable()
        ).map { _ in Void() }
        
        let input = CalculatorViewModel.Input(
            firstNumber: firstNumTextField.rx.text.orEmpty.asObservable(),
            secondNumber: secondNumTextField.rx.text.orEmpty.asObservable(),
            operation: operationObservable,
            calculateTrigger: calculateTrigger
        )
        
        let output = viewModel.transform(input: input)
        output.result
            .bind(to: explanationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.bool
            .map { isBlack in
                return isBlack ? .black : .gray
            }
            .bind(to: explanationLabel.rx.textColor)
            .disposed(by: disposeBag)
    }
}
