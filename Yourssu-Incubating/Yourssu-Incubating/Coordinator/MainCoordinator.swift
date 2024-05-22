//
//  MainCoordinator.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/21/24.
//

import UIKit

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
    
    func showAddMemo() {
        let addMemoViewController = AddMemoViewController()
        addMemoViewController.coordinator = self
        navigationController.pushViewController(addMemoViewController, animated: true)
    }
    
    func showDetailMemo(memo: MemoModel, index: Int, delegate: EditMemoDelegate) {
        let detailMemoViewController = DetailMemoViewController()
        detailMemoViewController.memo = memo
        detailMemoViewController.index = index
        detailMemoViewController.delegate = delegate
        navigationController.pushViewController(detailMemoViewController, animated: true)
    }
}
