//
//  ViewController.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 4/24/24.
//

import UIKit

class ViewController: UIViewController {
    var anyDic = ["name": "minji"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
    }

    func hi(_ name: String) {
        print(name)
    }
}

