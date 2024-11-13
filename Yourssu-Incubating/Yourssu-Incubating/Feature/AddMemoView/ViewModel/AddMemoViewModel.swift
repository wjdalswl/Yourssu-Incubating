//
//  AddMemoViewModel.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/18/24.
//

import Combine

final class AddMemoViewModel {
    //MARK: - Input
    @Published var title: String = ""
    @Published var content: String = ""
    
    //MARK: - Output
    @Published var isSaveButtonEnabled: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Publishers.CombineLatest($title, $content)
            .map { !$0.isEmpty && !$1.isEmpty }
            .assign(to: &$isSaveButtonEnabled)
    }
    
    func saveMemo() -> MemoModel {
        return MemoModel(title: title, content: content)
    }
}
