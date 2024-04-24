//
//  CalculatorViewController.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 4/24/24.
//

import UIKit
import SnapKit
import Then

final class CalculatorViewController: UIViewController {
    //MARK: - Properties
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

    //MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setLayout()
    }
    
    //MARK: - setLayout
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
    
    //MARK: - Action
    private func textFieldDidChange() {
        
    }
    @objc private func addButtonDidTap() {
        
    }
    @objc private func subButtonDidTap() {
        
    }
    @objc private func mulButtonDidTap() {
        
    }
    @objc private func divButtonDidTap() {
        
    }
}
