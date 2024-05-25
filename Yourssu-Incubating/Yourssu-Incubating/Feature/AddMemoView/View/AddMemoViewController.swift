//
//  AddMemoViewController.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/12/24.
//

import UIKit
import SnapKit
import Then
import Combine

final class AddMemoViewController: UIViewController {
    var coordinator: MainCoordinator?
    
    // MARK: - Properties
    private let titleTextField = UITextField().then {
        $0.placeholder = "제목을 작성해주세요"
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 0.8
        $0.layer.borderColor = UIColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 1).cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.rightView = paddingView
        $0.rightViewMode = .always
    }
    
    private lazy var contentTextView = UITextView().then {
        $0.text = "내용을 작성해주세요"
        $0.textColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 14, bottom: 15, right: 14)
        $0.delegate = self
    }
    
    private var cancellables = Set<AnyCancellable>()
    private var addButton: UIBarButtonItem!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setLayout()
        setNavigationBar()
        bindTextFields()
    }
    
    // MARK: - SetLayout
    private func setLayout() {
        [titleTextField, contentTextView].forEach {
            self.view.addSubview($0)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(35)
        }
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }

    // MARK: - SetNavigationBar
    private func setNavigationBar() {
        navigationItem.title = "메모 작성"
        addButton = UIBarButtonItem(title: "등록", style: .plain, target: self, action: #selector(addButtonTapped))
        addButton.isEnabled = false
        navigationItem.rightBarButtonItem = addButton
    }
    
    // MARK: - BindTextFields
    private func bindTextFields() {
        let titlePublisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: titleTextField)
            .compactMap { ($0.object as? UITextField)?.text }

        let contentPublisher = NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification, object: contentTextView)
            .compactMap { [weak self] _ in self?.contentTextView.text }
        
        Publishers.CombineLatest(titlePublisher, contentPublisher)
            .map { [weak self] title, content in
                return !title.isEmpty && !content.isEmpty && !(content == "내용을 작성해주세요" && self?.contentTextView.textColor == UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1))
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] isEnabled in
                self?.addButton.isEnabled = isEnabled
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Action
    @objc func addButtonTapped() {
        guard let title = titleTextField.text, let content = contentTextView.text else {
            return
        }
        
        let newMemo = MemoModel(id: ObjectIdentifier(self), title: title, content: content)
        
        if let viewController = navigationController?.viewControllers.first as? MemoListViewController {
            viewController.addMemo(newMemo)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextViewDelegate
extension AddMemoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "내용을 작성해주세요" && textView.textColor == UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1) {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 작성해주세요"
            textView.textColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1)
        }
    }
}
