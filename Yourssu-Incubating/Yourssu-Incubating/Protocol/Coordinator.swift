//
//  Coordinator.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/21/24.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
