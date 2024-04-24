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
    private lazy var firstNumTextField = UITextField().then {
        $0.delegate = self
        $0.placeholder = "첫번째 숫자를 입력해주세요"
        $0.backgroundColor = .systemGray6
        $0.textColor = .black
        $0.layer.cornerRadius = 35/2
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
 
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.rightView = paddingView
        $0.rightViewMode = .always
        
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.15
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    private lazy var secondNumTextField = UITextField().then {
        $0.delegate = self
        $0.placeholder = "두번째 숫자를 입력해주세요"
        $0.backgroundColor = .systemGray6
        $0.textColor = .black
        $0.layer.cornerRadius = 35/2
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.rightView = paddingView
        $0.rightViewMode = .always
        
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.15
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    private let explanationLabel = UILabel().then {
        $0.text = "버튼을 눌러주세요!"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        $0.textAlignment = .center
    }
    private lazy var addButton = UIButton().then {
        $0.backgroundColor = .systemTeal
        $0.layer.cornerRadius = 39/2
        $0.setTitle("더하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        $0.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
    }
    private lazy var subButton = UIButton().then {
        $0.backgroundColor = .systemTeal
        $0.layer.cornerRadius = 39/2
        $0.setTitle("빼기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        $0.addTarget(self, action: #selector(subButtonDidTap), for: .touchUpInside)
    }
    private lazy var mulButton = UIButton().then {
        $0.backgroundColor = .systemTeal
        $0.layer.cornerRadius = 39/2
        $0.setTitle("곱하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        $0.addTarget(self, action: #selector(mulButtonDidTap), for: .touchUpInside)
    }
    private lazy var divButton = UIButton().then {
        $0.backgroundColor = .systemTeal
        $0.layer.cornerRadius = 39/2
        $0.setTitle("나누기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        $0.addTarget(self, action: #selector(divButtonDidTap), for: .touchUpInside)
    }

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

//MARK: - UITextFieldDelegate
extension CalculatorViewController: UITextFieldDelegate {
    
}
