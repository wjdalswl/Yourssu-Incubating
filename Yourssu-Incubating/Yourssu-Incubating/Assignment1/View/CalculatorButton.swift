//
//  CalculatorButton.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 4/24/24.
//

import UIKit
import Then

class CalculatorButton: UIButton {
    init(title: String) {
            super.init(frame: .zero)
        self.do {
            $0.backgroundColor = .systemTeal
            $0.layer.cornerRadius = 39/2
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
