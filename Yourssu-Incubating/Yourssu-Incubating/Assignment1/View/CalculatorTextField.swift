//
//  CalculatorTextField.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 4/24/24.
//

import UIKit
import Then

class CalculatorTextField: UITextField{
    init(title: String) {
            super.init(frame: .zero)
        self.do {
            $0.delegate = self
            $0.placeholder = title
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UITextFieldDelegate
extension CalculatorTextField: UITextFieldDelegate {
    
}
