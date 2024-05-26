//
//  MemoListViewModel.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/18/24.
//

import Combine

final class MemoListViewModel {
    //MARK: - Input
    @Published private(set) var memos: [MemoModel] = []

    //MARK: - Output
    var memosPublisher: AnyPublisher<[MemoModel], Never> {
        $memos.eraseToAnyPublisher()
    }
    
    //MARK: - addMemo
    func addMemo(_ memo: MemoModel) {
        memos.append(memo)
    }
    
    //MARK: -deleteMemo
    func deleteMemo(at index: Int) {
        memos.remove(at: index)
    }
    
    //MARK: -updateMemo
    func updateMemo(_ memo: MemoModel, at index: Int) {
        memos[index] = memo
    }
}
