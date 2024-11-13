//
//  MemoListViewController.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/12/24.
//

import UIKit
import SnapKit
import Then

final class MemoListViewController: UIViewController {
    // MARK: - Properties
    var coordinator: MainCoordinator?
    private var memos = [MemoModel]()
    
    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .white
        $0.dataSource = self
        $0.delegate = self
        $0.register(MemoTableViewCell.self, forCellReuseIdentifier: MemoTableViewCell.identifier)
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 75
    }
    
    private let emptyLabel = UILabel().then {
        $0.text = "메모가 없습니다.\n메모를 추가해주세요 !"
        $0.textColor = UIColor.lightGray
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigationBar()
        setLayout()
        updateBackgroundView()
    }
    
    // MARK: - SetLayout
    private func setLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.directionalHorizontalEdges.equalToSuperview().inset(18)
        }
    }

    // MARK: - SetNavigationBar
    private func setNavigationBar() {
        navigationItem.title = "메모 목록"
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func updateBackgroundView() {
        if memos.isEmpty {
            tableView.backgroundView = emptyLabel
        } else {
            tableView.backgroundView = nil
        }
    }
    
    // MARK: - Action
    @objc private func addButtonTapped() {
        coordinator?.performTransition(to: .add)
    }
    
    func addMemo(_ memo: MemoModel) {
        memos.append(memo)
        tableView.reloadData()
        updateBackgroundView()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (_, _, completionHandler) in
            self.memos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.updateBackgroundView()
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memo = memos[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.performTransition(to: .detail(memo: memo, index: indexPath.row, delegate: self))
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else { return UITableViewCell() }
        let memo = memos[indexPath.row]
        cell.configure(with: memo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

// MARK: - EditMemoDelegate
extension MemoListViewController: EditMemoDelegate {
    func didUpdateMemo(_ memo: MemoModel, atIndex index: Int) {
        memos[index] = memo
        tableView.reloadData()
    }
}
