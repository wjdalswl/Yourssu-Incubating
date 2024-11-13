//
//  MainCoordinator.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/21/24.
//

import UIKit

enum Flow {
    case add
    case detail(memo: MemoModel, index: Int, delegate: EditMemoDelegate)
    case pop
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let memoListViewController = MemoListViewController()
        memoListViewController.coordinator = self
        navigationController.pushViewController(memoListViewController, animated: false)
    }
    
    func performTransition(to flow: Flow) {
        switch flow {
        case .add:
            let addMemoViewController = AddMemoViewController()
            addMemoViewController.coordinator = self
            navigationController.pushViewController(addMemoViewController, animated: true)
            
        case .detail(let memo, let index, let delegate):
            let detailMemoViewController = DetailMemoViewController()
            detailMemoViewController.memo = memo
            detailMemoViewController.index = index
            detailMemoViewController.delegate = delegate
            navigationController.pushViewController(detailMemoViewController, animated: true)
        
        case .pop:
            navigationController.popViewController(animated: true)
        }
    }
}
