//
//  DetailMemoViewModel.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/18/24.
//

import Combine

final class DetailMemoViewModel {
    //MARK: - Input
    @Published var memo: MemoModel
    
    //MARK: - Output
    var titlePublisher: AnyPublisher<String?, Never> {
        $memo
            .map { $0.title }
            .eraseToAnyPublisher()
    }
    
    var contentPublisher: AnyPublisher<String?, Never> {
        $memo
            .map { $0.content }
            .eraseToAnyPublisher()
    }
    
    init(memo: MemoModel) {
        self.memo = memo
    }
    
    func updateMemo(title: String, content: String) -> MemoModel {
        var updatedMemo = memo
        updatedMemo.title = title
        updatedMemo.content = content
        return updatedMemo
    }
}
