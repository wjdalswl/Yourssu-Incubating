//
//  DetailMemoViewController.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/12/24.
//

import UIKit
import SnapKit
import Then
import Combine

final class DetailMemoViewController: UIViewController {
    // MARK: - Properties
    var coordinator: MainCoordinator?
    var memo: MemoModel?
    var index: Int?
    weak var delegate: EditMemoDelegate?
    
    private lazy var viewModel: DetailMemoViewModel = {
        guard let memo = memo else {
            fatalError("메모가 설정되기 전에 DetailMemoViewModel이 초기화되는 문제 발생")
        }
        return DetailMemoViewModel(memo: memo)
    }()
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    private let contentLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.numberOfLines = 0
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setLayout()
        setNavigationBar()
        bindViewModel()
    }
    
    // MARK: - SetLayout
    private func setLayout() {
        [titleLabel, contentLabel].forEach {
            self.view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(34)
            $0.directionalHorizontalEdges.equalToSuperview().inset(36)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(36)
        }
    }
    
    // MARK: - SetNavigationBar
    private func setNavigationBar() {
        navigationItem.title = "메모 상세"
    }
    
    // MARK: - BindViewModel
    private func bindViewModel() {
        viewModel.titlePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.text, on: titleLabel)
            .store(in: &cancellables)
        
        viewModel.contentPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.text, on: contentLabel)
            .store(in: &cancellables)
    }
    
    // MARK: - Action
    @objc func backButtonTapped() {
        guard let updatedTitle = titleLabel.text,
              let updatedContent = contentLabel.text else {
            return
        }
        
        let updatedMemo = viewModel.updateMemo(title: updatedTitle, content: updatedContent)
        delegate?.didUpdateMemo(updatedMemo, atIndex: index!)
        coordinator?.performTransition(to: .pop)
    }
}

// MARK: - EditMemoDelegate
extension DetailMemoViewController: EditMemoDelegate {
    func didUpdateMemo(_ memo: MemoModel, atIndex: Int) {
        viewModel.memo = memo
    }
}
